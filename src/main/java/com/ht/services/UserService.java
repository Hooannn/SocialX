package com.ht.services;

import com.ht.entities.User;
import org.hibernate.Query;
import org.hibernate.Session;
import org.hibernate.SessionFactory;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

@Service
@Transactional
public class UserService {
    private final SessionFactory sessionFactory;

    @Autowired
    public UserService(SessionFactory sessionFactory) {
        this.sessionFactory = sessionFactory;
    }

    public User getUserById (Long userId) {
        Session session = sessionFactory.getCurrentSession();
        Query getUserQuery = session.createQuery("FROM User WHERE id = :userId AND disabled = 0");
        getUserQuery.setParameter("userId", userId);

        return (User) getUserQuery.uniqueResult();
    }
}
