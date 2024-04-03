package com.ht.services;

import com.ht.dtos.ForgotPasswordDto;
import com.ht.dtos.ResetPasswordDto;
import com.ht.dtos.SignInDto;
import com.ht.dtos.SignUpDto;
import com.ht.entities.User;
import com.ht.enums.UserRole;
import com.ht.utils.VerificationTokenResult;
import io.jsonwebtoken.Jwt;
import jakarta.servlet.http.HttpServletRequest;
import org.hibernate.Query;
import org.hibernate.Session;
import org.hibernate.SessionFactory;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.security.crypto.password.PasswordEncoder;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import java.net.URL;
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
                String host  = url.getHost();
                String protocol = url.getProtocol();
                int port = url.getPort();
                String resetPasswordUrl = protocol + "://" + host + ":" + port + contextPath + "/auth/reset-password?token=" + token;
                mailService.send("noreply@socialx.online", userEmail, "Reset Password", "Click <a href=\"" + resetPasswordUrl + "\">here</a> to reset password");
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
}
