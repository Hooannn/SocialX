package com.ht.controllers;

import com.ht.services.NotificationService;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.RequestMapping;

@Controller
@RequestMapping("/notification")
public class NotificationController {
    private final NotificationService notificationService;

    @Autowired
    public NotificationController(NotificationService notificationService) {
        this.notificationService = notificationService;
    }

    @GetMapping("/{id}/read")
    public String readNotification(
            @PathVariable("id") Long notificationId
    ) {
        var notification = notificationService.readNotification(notificationId);
        return "redirect:" + notification.getActionUrl();
    }
}
