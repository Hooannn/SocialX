package com.ht.services;

import com.ht.beans.GoogleUserData;
import com.ht.dtos.ForgotPasswordDto;
import com.ht.dtos.ResetPasswordDto;
import com.ht.dtos.SignInDto;
import com.ht.dtos.SignUpDto;
import com.ht.entities.User;
import com.ht.enums.UserRole;
import com.ht.utils.VerificationTokenResult;
import jakarta.servlet.http.HttpServletRequest;
import org.hibernate.Query;
import org.hibernate.Session;
import org.hibernate.SessionFactory;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.security.crypto.password.PasswordEncoder;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import java.net.URL;
import java.time.Instant;
import java.util.Date;
import java.util.concurrent.CompletableFuture;

@Service
@Transactional
public class AuthService {
    private final SessionFactory sessionFactory;
    private final PasswordEncoder passwordEncoder;
    private final JwtService jwtService;
    private final MailService mailService;

    @Autowired
    public AuthService(PasswordEncoder passwordEncoder, SessionFactory sessionFactory, JwtService jwtService, MailService mailService) {
        this.passwordEncoder = passwordEncoder;
        this.sessionFactory = sessionFactory;
        this.mailService = mailService;
        this.jwtService = jwtService;
    }

    public String signUp(SignUpDto signUpDto) throws Exception {
        Session session = sessionFactory.getCurrentSession();
        Query query = session.createQuery("SELECT COUNT(*) FROM User WHERE email = :email");
        query.setParameter("email", signUpDto.getEmail());
        Long count = (Long) query.uniqueResult();

        if (count > 0) {
            throw new Exception("Email đã tồn tại");
        }

        User user = new User();
        user.setEmail(signUpDto.getEmail());
        user.setPassword(passwordEncoder.encode(signUpDto.getPassword()));
        user.setFirstName(signUpDto.getFirstName());
        user.setLastName(signUpDto.getLastName());
        user.setDisabled(false);
        user.setSex(false);
        user.setRole(UserRole.USER);
        user.setAvatar("https://cdn-icons-png.flaticon.com/512/6596/6596121.png");
        user.setCoverImage("https://res.cloudinary.com/dwbwvdguk/image/upload/v1717726216/jw0tg3wl0jicwfp1qqoo.jpg");
        user.setCreatedAt(new Date());

        session.save(user);
        return jwtService.generateAccessToken(user);
    }

    public String signIn(SignInDto signInDto) throws Exception {
        Session session = sessionFactory.getCurrentSession();
        Query query = session.createQuery("FROM User WHERE email = :email");
        query.setParameter("email", signInDto.getEmail());
        User user = (User) query.uniqueResult();

        if (user == null) {
            throw new Exception("Tài khoản không tồn tại");
        }

        if (user.isDisabled()) {
            throw new Exception("Tài khoản đã bị khóa");
        }

        if (!passwordEncoder.matches(signInDto.getPassword(), user.getPassword())) {
            throw new Exception("Mật khẩu không chính xác");
        }

        return jwtService.generateAccessToken(user);
    }

    public void forgotPassword(ForgotPasswordDto forgotPasswordDto, HttpServletRequest request) throws Exception {
        Session session = sessionFactory.getCurrentSession();
        Query query = session.createQuery("FROM User WHERE email = :email");
        query.setParameter("email", forgotPasswordDto.getEmail());
        User user = (User) query.uniqueResult();

        if (user == null) {
            throw new Exception("Tài khoản không tồn tại");
        }

        if (user.isDisabled()) {
            throw new Exception("Tài khoản đã bị khóa");
        }
        String userEmail = user.getEmail();
        String token = jwtService.generateResetPasswordToken(userEmail);

        user.setResetPasswordToken(token);
        session.update(user);

        CompletableFuture.runAsync(() -> {
            try {
                String contextPath = request.getContextPath();
                URL url = new URL(request.getRequestURL().toString());
                String host = url.getHost();
                String protocol = url.getProtocol();
                int port = url.getPort();
                String resetPasswordUrl = protocol + "://" + host + ":" + port + contextPath + "/auth/reset-password?token=" + token;

                String mailContent = """
                        <html><head><meta charset="UTF-8"><meta http-equiv="X-UA-Compatible" content="IE=edge"><meta name="viewport" content="width=device-width,initial-scale=1"><title>SocialX | Đặt lại mật khẩu</title><style>body{position:relative;height:100vh;margin:0;text-align:center}
                        .container{width:100%;max-width:700px;height:100%;padding:35px;border-radius:5px;background-color:#222831;color:#fff}.card{position:absolute;top:50%;left:50%;width:100%;transform:translate(-50%,-50%)}span{color:#ffbe33}button{padding:1em 6em;border:0;border-radius:5px;
                        background-color:#ffbe33;transition:all .3s ease-in}button:hover{background-color:#e69c00}.spacing{margin-top:3rem}</style></head><body><div class="container"><div class="card"><h1 style="margin-top:0"><span>Xin chào!</h1><p>Chúng tôi đã nhận được yêu cầu đặt lại mật khẩu cho tài khoản của bạn</p><p>Bạn đã quên mật khẩu?</p>
                        <div class="spacing"><p>Để đặt lại mật khẩu, hãy ấn vào nút bên dưới 👇🏻</p><p>Liên kết này sẽ hết hiệu lực trong 10 phút và chỉ dùng được 1 lần</p><a href="
                        """
                        + resetPasswordUrl +
                        """
                                                " target="_blank"><button style="cursor:pointer">Đặt lại mật khẩu</button></a></div></div></div></body></html>
                                """;
                mailService.send("noreply@socialx.online", userEmail, "SocialX | Đặt lại mật khẩu", mailContent);
            } catch (Exception e) {
                e.printStackTrace();
            }
        });
    }

    public void resetPassword(ResetPasswordDto resetPasswordDto) throws Exception {
        VerificationTokenResult result = jwtService.verifyResetPasswordToken(resetPasswordDto.getToken());
        if (!result.isTokenValid()) {
            throw new Exception("Token không hợp lệ");
        }
        Session session = sessionFactory.getCurrentSession();
        Query query = session.createQuery("FROM User WHERE email = :email");
        query.setParameter("email", result.subject());
        User user = (User) query.uniqueResult();
        user.setPassword(passwordEncoder.encode(resetPasswordDto.getPassword()));
        user.setResetPasswordToken(null);
        session.update(user);
    }

    public String authenticateByGoogle(GoogleUserData userData) throws Exception {
        Session session = sessionFactory.getCurrentSession();
        Query query = session.createQuery("FROM User WHERE email = :email");
        query.setParameter("email", userData.getEmail());
        User user = (User) query.uniqueResult();

        // Generate new user if doesn't exist
        if (user == null) {
            String autoPassword = userData.getId() + Instant.now().toEpochMilli();

            User newUser = new User();
            newUser.setEmail(userData.getEmail());
            newUser.setPassword(passwordEncoder.encode(autoPassword));
            newUser.setFirstName(userData.getGivenName());
            newUser.setLastName(userData.getFamilyName());
            newUser.setDisabled(false);
            newUser.setSex(false);
            newUser.setRole(UserRole.USER);
            newUser.setAvatar(userData.getPicture());
            newUser.setCreatedAt(new Date());

            session.save(newUser);
            return jwtService.generateAccessToken(newUser);
        }

        if (user.isDisabled()) {
            throw new Exception("Tài khoản đã bị khóa");
        }

        // Login the existed user
        return jwtService.generateAccessToken(user);
    }
}
