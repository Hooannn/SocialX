package com.ht.services;

import com.ht.entities.Notification;
import org.hibernate.Query;
import org.hibernate.Session;
import org.hibernate.SessionFactory;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import java.util.List;

@Service
@Transactional
public class NotificationService {
    private final SessionFactory sessionFactory;

    @Autowired
    public NotificationService(SessionFactory sessionFactory) {
        this.sessionFactory = sessionFactory;
    }

    public List<Notification> findAllByUserId(Long userId) {
        Session session = sessionFactory.getCurrentSession();
        Query query = session.createQuery("from Notification where user.id = :userId order by createdAt desc");
        query.setParameter("userId", userId);
        return query.list();
    }
}
