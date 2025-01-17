package com.ht.services;

import com.ht.entities.*;
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
        notification.setActionUrl("/profile/" + friend.getToUser().getId());

        session.save(notification);
    }

    public void createCommentCreatedNotification(Comment comment, Long authorId) {
        Session session = sessionFactory.getCurrentSession();
        Notification notification = new Notification();
        User user = new User();
        user.setId(authorId);
        notification.setUser(user);
        notification.setContent(comment.getUser().getFullName() + " đã bình luận về bài viết của bạn");
        notification.setCreatedAt(new Date());
        notification.setStatus(false);
        notification.setTitle("Bình luận mới");
        notification.setImageUrl(comment.getUser().getAvatar());
        notification.setActionUrl("/post/" + comment.getPost().getId());

        session.save(notification);
    }

    public Notification readNotification(Long notificationId) {
        Session session = sessionFactory.getCurrentSession();
        Notification notification = (Notification) session.get(Notification.class, notificationId);
        notification.setStatus(true);
        session.update(notification);
        return notification;
    }

    public void createPostCreatedNotification(Post post, List<User> friends) {
        Session session = sessionFactory.getCurrentSession();
        for (User friend : friends) {
            Notification notification = new Notification();
            notification.setUser(friend);
            notification.setContent(post.getUser().getFullName() + " đã đăng một bài viết mới");
            notification.setCreatedAt(new Date());
            notification.setStatus(false);
            notification.setTitle("Bài viết mới");
            notification.setImageUrl(post.getUser().getAvatar());
            notification.setActionUrl("/post/" + post.getId());

            session.save(notification);
        }
    }

    public void createPostLikedNotification(Post post, User user) {
        Session session = sessionFactory.getCurrentSession();
        Notification notification = new Notification();
        notification.setUser(post.getUser());
        notification.setContent(user.getFullName() + " đã thích bài viết của bạn");
        notification.setCreatedAt(new Date());
        notification.setStatus(false);
        String notificationTitle = """
                Bài viết: '%s'
                """;
        notification.setTitle(String.format(notificationTitle, post.getTitle()));
        notification.setImageUrl(user.getAvatar());
        notification.setActionUrl("/post/" + post.getId());

        session.save(notification);
    }
}
