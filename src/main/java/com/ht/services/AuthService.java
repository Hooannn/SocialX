package com.ht.services;

import com.ht.dtos.SignInDto;
import com.ht.dtos.SignUpDto;
import com.ht.entities.User;
import com.ht.enums.UserRole;
import io.jsonwebtoken.Jwt;
import org.hibernate.Query;
import org.hibernate.Session;
import org.hibernate.SessionFactory;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.security.crypto.password.PasswordEncoder;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import java.util.Date;

@Service
@Transactional
public class AuthService {
    private final SessionFactory sessionFactory;
    private final PasswordEncoder passwordEncoder;
    private final JwtService jwtService;
    @Autowired
    public AuthService(PasswordEncoder passwordEncoder, SessionFactory sessionFactory, JwtService jwtService) {
        this.passwordEncoder = passwordEncoder;
        this.sessionFactory = sessionFactory;
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
}
