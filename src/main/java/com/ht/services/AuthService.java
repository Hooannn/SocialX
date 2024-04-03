package com.ht.services;

import com.ht.dtos.SignInDto;
import com.ht.dtos.SignUpDto;
import com.ht.entities.User;
import com.ht.enums.UserRole;
import org.hibernate.Query;
import org.hibernate.Session;
import org.hibernate.SessionFactory;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.security.crypto.password.PasswordEncoder;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import java.util.Date;
import java.util.UUID;

@Service
@Transactional
public class AuthService {
    private final SessionFactory sessionFactory;
    private final PasswordEncoder passwordEncoder;
    @Autowired
    public AuthService(PasswordEncoder passwordEncoder, SessionFactory sessionFactory) {
        this.passwordEncoder = passwordEncoder;
        this.sessionFactory = sessionFactory;
    }
    public void signUp(SignUpDto signUpDto) throws Exception {
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
        user.setRole(UserRole.USER);
        user.setAvatar("https://cdn-icons-png.flaticon.com/512/6596/6596121.png");
        user.setCreatedAt(new Date());
        session.save(user);
        //Todo: generate token & send email & save to cookie
    }

    public void signIn(SignInDto signInDto) throws Exception {
        Session session = sessionFactory.getCurrentSession();
        Query query = session.createQuery("FROM User WHERE email = :email");
        query.setParameter("email", signInDto.getEmail());
        User user = (User) query.uniqueResult();

        if (user == null) {
            throw new Exception("Email không tồn tại");
        }

        if (!passwordEncoder.matches(signInDto.getPassword(), user.getPassword())) {
            throw new Exception("Mật khẩu không chính xác");
        }
        //Todo: generate token & save to cookie
    }
}
