package com.ht.services;

import com.ht.entities.Friend;
import com.ht.entities.User;
import com.ht.enums.FriendStatus;
import org.hibernate.Query;
import org.hibernate.Session;
import org.hibernate.SessionFactory;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import java.util.Date;
import java.util.List;
import java.util.concurrent.CompletableFuture;

@Service
@Transactional
public class FriendService {
    private final SessionFactory sessionFactory;
    private final NotificationService notificationService;

    @Autowired
    public FriendService(SessionFactory sessionFactory, NotificationService notificationService) {
        this.sessionFactory = sessionFactory;
        this.notificationService = notificationService;
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

    public List<User> findLatestByUserId(Long userId, int limit) {
        Session session = sessionFactory.getCurrentSession();
        Query query = session.createQuery("""
            from User where id in (select toUser.id from Friend where fromUser.id = :userId and status = 1)
            or id in (select fromUser.id from Friend where toUser.id = :userId and status = 1)
            order by createdAt desc
        """);
        query.setParameter("userId", userId);
        query.setMaxResults(limit);
        return query.list();
    }

    public List<User> findAllRequestByUserId(Long userId) {
        Session session = sessionFactory.getCurrentSession();
        Query query = session.createQuery("from User where id in (select fromUser.id from Friend where toUser.id = :userId and status = 0)");
        query.setParameter("userId", userId);
        return query.list();
    }

    public FriendStatus checkFriendRequest(Long authUserId, Long toUserId) {
        Session session = sessionFactory.getCurrentSession();
        Query query = session.createQuery("""
            from Friend 
            where fromUser.id = :fromUserId and toUser.id = :toUserId 
            or fromUser.id = :toUserId and toUser.id = :fromUserId
        """);
        query.setParameter("fromUserId", toUserId);
        query.setParameter("toUserId", authUserId);
        Friend friend = (Friend) query.uniqueResult();

        if (friend == null) {
            // CASE 1: chưa là bạn + chưa có request (hiện nút add friend)
            return FriendStatus.NOT_FRIENDS;
        } else if (friend.isStatus() == true) {
            // CASE 2: đã là bạn (hiện nút unfriend)
            return FriendStatus.ARE_FRIENDS;
        } else if (friend.getFromUser().getId() == authUserId) {
            // CASE 3: chưa là bạn và auth gửi request (hiện nút cancel request)
            return FriendStatus.PENDING_SENT_REQUEST;
        } else {
            // CASE 4: chưa là bạn và auth nhận request (hện nút accept request)
            return FriendStatus.PENDING_RECEIVED_REQUEST;
        }
    }

    public void sendNewRequest(Long authUserId, Long toUserId) throws Exception {
        Session session = sessionFactory.getCurrentSession();

        var fromUser = new User();
        var toUser = new User();
        fromUser.setId(authUserId);
        toUser.setId(toUserId);

        Friend newFriendRequest = new Friend(fromUser, toUser, false, new Date());
        session.save(newFriendRequest);

        CompletableFuture.runAsync(() -> {
            try {
                // TODO: send request received notification
            } catch (Exception e) {
                e.printStackTrace();
            }
        });
    }

    public void cancelFriendRequest(Long authUserId, Long toUserId) throws Exception {
        Session session = sessionFactory.getCurrentSession();
        Query query = session.createQuery("from Friend where fromUser.id = :fromUserId and toUser.id = :toUserId");
        query.setParameter("fromUserId", authUserId);
        query.setParameter("toUserId", toUserId);
        Friend friend = (Friend) query.uniqueResult();
        if (friend == null) {
            throw new Exception("Không tìm thấy yêu cầu kết bạn");
        } else if (friend.isStatus() == true) {
            throw new Exception("Yêu cầu không thể hủy vì đã được chấp nhận");
        }
        session.delete(friend);
    }

    public void unfriend(Long authUserId, Long toUserId) throws Exception {
        Session session = sessionFactory.getCurrentSession();
        Query query = session.createQuery("""
            from Friend 
            where fromUser.id = :fromUserId and toUser.id = :toUserId 
            or fromUser.id = :toUserId and toUser.id = :fromUserId
        """);
        query.setParameter("fromUserId", toUserId);
        query.setParameter("toUserId", authUserId);
        Friend friend = (Friend) query.uniqueResult();
        if (friend == null) {
            throw new Exception("Không tìm thấy bạn bè hoặc đã bị hủy từ trước");
        }
        session.delete(friend);
    }

    public void acceptRequest(Long authUserId, Long toUserId) throws Exception {
        Session session = sessionFactory.getCurrentSession();
        Query query = session.createQuery("from Friend where fromUser.id = :fromUserId and toUser.id = :toUserId and status = 0");
        query.setParameter("fromUserId", toUserId);
        query.setParameter("toUserId", authUserId);
        Friend friend = (Friend) query.uniqueResult();
        if (friend == null) {
            throw new Exception("Không tìm thấy yêu cầu kết bạn");
        }

        friend.setStatus(true);
        session.update(friend);

        CompletableFuture.runAsync(() -> {
            try {
                notificationService.createFriendAcceptedNotification(friend);
            } catch (Exception e) {
                e.printStackTrace();
            }
        });
    }

    public void declineRequest(Long authUserId, Long toUserId) throws Exception {
        Session session = sessionFactory.getCurrentSession();
        Query query = session.createQuery("from Friend where fromUser.id = :fromUserId and toUser.id = :toUserId and status = 0");
        query.setParameter("fromUserId", toUserId);
        query.setParameter("toUserId", authUserId);
        Friend friend = (Friend) query.uniqueResult();
        if (friend == null) {
            throw new Exception("Không tìm thấy yêu cầu kết bạn");
        }
        session.delete(friend);
    }
}
