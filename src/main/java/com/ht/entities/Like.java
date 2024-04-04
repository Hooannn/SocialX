package com.ht.entities;

import javax.persistence.*;
import java.io.Serializable;
import java.util.Date;

@Entity
@IdClass(LikeId.class)
@Table(name = "likes")
public class Like {
    @ManyToOne
    @Id
    @JoinColumn(name = "user_id", nullable = false)
    private User user;

    @ManyToOne
    @Id
    @JoinColumn(name = "post_id", nullable = false)
    private Post post;

    @Column(name = "created_at", nullable = false)
    private Date createdAt;

    @PrePersist
    public void prePersist() {
        if (createdAt == null) createdAt = new Date();
    }

    public Like() {
    }

    public Like(User user, Post post, Date createdAt) {
        this.user = user;
        this.post = post;
        this.createdAt = createdAt;
    }

    public User getUser() {
        return user;
    }

    public void setUser(User user) {
        this.user = user;
    }

    public Post getPost() {
        return post;
    }

    public void setPost(Post post) {
        this.post = post;
    }

    public Date getCreatedAt() {
        return createdAt;
    }

    public void setCreatedAt(Date createdAt) {
        this.createdAt = createdAt;
    }

    @Override
    public String toString() {
        return "Like{" +
                "user=" + user +
                ", post=" + post +
                ", createdAt=" + createdAt +
                '}';
    }
}

class LikeId implements Serializable {
    private User user;
    private Post post;
}