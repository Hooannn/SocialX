package com.ht.controllers;

import com.ht.entities.User;
import com.ht.services.FriendService;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.ModelMap;
import org.springframework.web.bind.annotation.*;

@Controller
@RequestMapping("/friend")
public class FriendController {
    private final FriendService friendService;

    @Autowired
    public FriendController(FriendService friendService) {
        this.friendService = friendService;
    }

    @GetMapping("/accept/{userId}")
    public String acceptRequest(
            ModelMap model,
            @RequestAttribute("user") User authUser,
            @PathVariable("userId") Long userId,
            @RequestParam(value = "redirect", required = false) String redirect) {
        try {
            friendService.acceptRequest(authUser.getId(), userId);
        } catch (Exception e) {
            model.addAttribute("errorMessage", e.getMessage());
        }
        String redirectUrl = redirect != null ? redirect : "/";
        return "redirect:" + redirectUrl;
    }

    @GetMapping("/decline/{userId}")
    public String declineRequest(
            ModelMap model,
            @RequestAttribute("user") User authUser,
            @PathVariable("userId") Long userId,
            @RequestParam(value = "redirect", required = false) String redirect) {
        try {
            friendService.declineRequest(authUser.getId(), userId);
        } catch (Exception e) {
            model.addAttribute("errorMessage", e.getMessage());
        }
        String redirectUrl = redirect != null ? redirect : "/";
        return "redirect:" + redirectUrl;
    }
}
