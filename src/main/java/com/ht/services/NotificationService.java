package com.ht.services;

import com.ht.entities.Friend;
import com.ht.entities.Notification;
import org.hibernate.Query;
import org.hibernate.Session;
import org.hibernate.SessionFactory;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import java.util.Date;
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

    public void createFriendAcceptedNotification(Friend friend) {
        Session session = sessionFactory.getCurrentSession();
        Notification notification = new Notification();
        notification.setUser(friend.getFromUser());
        notification.setContent(friend.getToUser().getFullName() + " đã chấp nhận lời mời kết bạn của bạn");
        notification.setCreatedAt(new Date());
        notification.setStatus(false);
        notification.setTitle("Bạn mới");
        notification.setImageUrl(friend.getToUser().getAvatar());
        notification.setActionUrl("profile/" + friend.getToUser().getId());

        session.save(notification);
    }
}
