package com.ht.services;

import com.ht.entities.Like;
import com.ht.entities.Post;
import com.ht.entities.User;
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
public class PostService {
    private final SessionFactory sessionFactory;

    @Autowired
    public PostService(SessionFactory sessionFactory) {
        this.sessionFactory = sessionFactory;
    }

    public List<Post> findAllByUserFriends(Long userId) {
        Session session = sessionFactory.getCurrentSession();
        Query query = session.createQuery("""
            from Post where user.id in (select toUser.id from Friend where fromUser.id = :userId and status = 1)
            or user.id in (select fromUser.id from Friend where toUser.id = :userId and status = 1)
        """);
        query.setParameter("userId", userId);
        return query.list();
    }

    public List<Post> findAllByUserId(Long userId) {
        Session session = sessionFactory.getCurrentSession();
        Query query = session.createQuery("""
            from Post where user.id = :userId
        """);
        query.setParameter("userId", userId);
        return query.list();
    }

    public void like(Long userId, Long postId) throws Exception {
        Session session = sessionFactory.getCurrentSession();

        Query checkLikedQuery = session.createQuery("""
            select count(*) from Like where user.id = :userId and post.id = :postId
        """);
        checkLikedQuery.setParameter("userId", userId);
        checkLikedQuery.setParameter("postId", postId);
        Long count = (Long) checkLikedQuery.uniqueResult();

        if (count > 0) {
            throw new Exception("Bạn đã thích bài viết này");
        }

        Like like = new Like();
        var user = new User();
        user.setId(userId);
        var post = new Post();
        post.setId(postId);
        like.setUser(user);
        like.setPost(post);
        like.setCreatedAt(new Date());

        session.save(like);
    }

    public void unlike(Long userId, Long postId) {
        Session session = sessionFactory.getCurrentSession();
        Query query = session.createQuery("""
            delete from Like where user.id = :userId and post.id = :postId
        """);
        query.setParameter("userId", userId);
        query.setParameter("postId", postId);
        query.executeUpdate();
    }

    public Post getPost(Long id) {
        Session session = sessionFactory.getCurrentSession();
        return (Post) session.get(Post.class, id);
    }
}
