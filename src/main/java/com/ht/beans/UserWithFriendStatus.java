package com.ht.beans;

import com.ht.entities.User;
import com.ht.enums.FriendStatus;

public class UserWithFriendStatus {
    private User user;
    private FriendStatus friendStatus;

    public UserWithFriendStatus() {
    }

    public UserWithFriendStatus(User user, FriendStatus friendStatus) {
        this.user = user;
        this.friendStatus = friendStatus;
    }

    public User getUser() {
        return user;
    }

    public void setUser(User user) {
        this.user = user;
    }

    public FriendStatus getFriendStatus() {
        return friendStatus;
    }

    public void setFriendStatus(FriendStatus friendStatus) {
        this.friendStatus = friendStatus;
    }
}
