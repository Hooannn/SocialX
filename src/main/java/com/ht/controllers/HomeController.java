package com.ht.controllers;

import com.ht.entities.User;
import com.ht.services.FriendService;
import com.ht.services.NotificationService;
import com.ht.services.PostService;
import jakarta.servlet.http.HttpServletRequest;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.ModelMap;
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

    @Autowired
    public HomeController(FriendService friendService, PostService postService) {
        this.friendService = friendService;
        this.postService = postService;
    }

    @GetMapping
    public String index(@RequestAttribute("user") User authUser, ModelMap model) {
        var friends = friendService.findLatestByUserId(authUser.getId(), 5);
        var posts = postService.findAllByUserFriends(authUser.getId());

        model.addAttribute("friends", friends);
        model.addAttribute("posts", posts);
        return "home/index";
    }
}
