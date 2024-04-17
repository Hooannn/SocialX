package com.ht.configs;

import com.ht.entities.User;
import com.ht.services.FriendService;
import com.ht.services.NotificationService;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import org.springframework.web.servlet.HandlerInterceptor;

public class PrepareModelInterceptor implements HandlerInterceptor {
    private final FriendService friendService;
    private final NotificationService notificationService;

    public PrepareModelInterceptor(FriendService friendService, NotificationService notificationService) {
        this.friendService = friendService;
        this.notificationService = notificationService;
    }

    @Override
    public boolean preHandle(HttpServletRequest request, HttpServletResponse response, Object handler) throws Exception {
        System.out.println("PrepareModelInterceptor.preHandle called");
        var notifications = notificationService.findAllByUserId(((User) request.getAttribute("user")).getId());
        var friendRequests = friendService.findAllRequestByUserId(((User) request.getAttribute("user")).getId());

        request.setAttribute("notifications", notifications);
        request.setAttribute("friendRequests", friendRequests);
        return true;
    }
}
