package com.ht.entities;

import javax.persistence.*;
import java.io.Serializable;
import java.util.Date;

@Entity
@IdClass(FriendId.class)
@Table(name = "friends")
public class Friend {
    @ManyToOne
    @Id
    @JoinColumn(name = "from_uid", nullable = false)
    private User fromUser;

    @ManyToOne
    @Id
    @JoinColumn(name = "to_uid", nullable = false)
    private User toUser;

    @Column(name = "status", nullable = false)
    private boolean status; // 0: pending, 1: accepted

    @Column(name = "created_at", nullable = false)
    private Date createdAt;

    public Friend() {
    }

    public Friend(User fromUser, User toUser, boolean status, Date createdAt) {
        this.fromUser = fromUser;
        this.toUser = toUser;
        this.status = status;
        this.createdAt = createdAt;
    }

    @PrePersist
    public void prePersist() {
        if (createdAt == null) createdAt = new Date();
    }

    public User getFromUser() {
        return fromUser;
    }

    public void setFromUser(User fromUser) {
        this.fromUser = fromUser;
    }

    public User getToUser() {
        return toUser;
    }

    public void setToUser(User toUser) {
        this.toUser = toUser;
    }

    public boolean isStatus() {
        return status;
    }

    public void setStatus(boolean status) {
        this.status = status;
    }

    public Date getCreatedAt() {
        return createdAt;
    }

    public void setCreatedAt(Date createdAt) {
        this.createdAt = createdAt;
    }

    @Override
    public String toString() {
        return "Friend{" +
                "fromUser=" + fromUser +
                ", toUser=" + toUser +
                ", status=" + status +
                ", createdAt=" + createdAt +
                '}';
    }
}

class FriendId implements Serializable {
    private User fromUser;
    private User toUser;
}
