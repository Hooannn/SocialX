package com.ht.services;

import com.ht.entities.User;
import org.hibernate.Query;
import org.hibernate.Session;
import org.hibernate.SessionFactory;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import java.util.List;

@Service
@Transactional
public class FriendService {
    private final SessionFactory sessionFactory;

    @Autowired
    public FriendService(SessionFactory sessionFactory) {
        this.sessionFactory = sessionFactory;
    }

    public List<User> findAllByUserId(Long userId) {
        Session session = sessionFactory.getCurrentSession();
        Query query = session.createQuery("""
            from User where id in (select toUser.id from Friend where fromUser.id = :userId and status = 1)
            or id in (select fromUser.id from Friend where toUser.id = :userId and status = 1)
        """);
        query.setParameter("userId", userId);
        return query.list();
    }

    public List<User> findAllRequestByUserId(Long userId) {
        Session session = sessionFactory.getCurrentSession();
        Query query = session.createQuery("from User where id in (select toUser.id from Friend where fromUser.id = :userId and status = 0)");
        query.setParameter("userId", userId);
        return query.list();
    }
}
