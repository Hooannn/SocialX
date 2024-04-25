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

    public void saveOrUpdateUser (User authUser) {
        Session session = sessionFactory.getCurrentSession();
        Query getUserQuery = session.createQuery("UPDATE User u SET first_name = :first_name, last_name = :last_name, " +
                "date_of_birth = :date_of_birth, sex = :sex, address = :address, " +
                "avatar = :avatar, password = :password WHERE id = :userId");
        getUserQuery.setParameter("first_name", authUser.getFirstName())
                .setParameter("last_name", authUser.getLastName())
                .setParameter("date_of_birth", authUser.getDateOfBirth())
                .setParameter("sex", authUser.isSex())
                .setParameter("address", authUser.getAddress())
                .setParameter("avatar", authUser.getAvatar())
                .setParameter("userId", authUser.getId())
                .setParameter("password", authUser.getPassword())
                .executeUpdate();
    }
}
