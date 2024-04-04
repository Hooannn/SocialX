package com.ht.controllers;

import com.ht.entities.User;
import com.ht.services.FriendService;
import com.ht.services.NotificationService;
import com.ht.services.PostService;
import jakarta.servlet.http.HttpServletRequest;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.RequestAttribute;
import org.springframework.web.bind.annotation.RequestMapping;

import java.net.MalformedURLException;
import java.net.URL;

@Controller
@RequestMapping("/home")
public class HomeController {
    private final FriendService friendService;
    private final PostService postService;
    private final NotificationService notificationService;

    @Autowired
    public HomeController(FriendService friendService, PostService postService, NotificationService notificationService) {
        this.friendService = friendService;
        this.postService = postService;
        this.notificationService = notificationService;
    }

    @GetMapping
    public String index(@RequestAttribute("user") User authUser) {
        var friends = friendService.findAllByUserId(authUser.getId());
        var posts = postService.findAllByUserFriends(authUser.getId());
        var notifications = notificationService.findAllByUserId(authUser.getId());
        var friendRequests = friendService.findAllRequestByUserId(authUser.getId());

        friends.forEach(friend -> {
            System.out.println(friend);
        });

        posts.forEach(post -> {
            System.out.println(post);
        });

        notifications.forEach(notification -> {
            System.out.println(notification);
        });

        friendRequests.forEach(friendRequest -> {
            System.out.println(friendRequest);
        });

        return "home/index";
    }
}
