package com.ht.controllers;

import com.ht.entities.User;
import com.ht.services.UserService;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.ModelMap;
import org.springframework.web.bind.annotation.*;

import java.util.Objects;

@Controller
@RequestMapping("/profile")
public class ProfileController {
    private final UserService userService;

    @Autowired
    public ProfileController(UserService userService) {
        this.userService = userService;
    }

    @GetMapping()
    public String myProfile (@RequestAttribute("user") User authUser) {
        return "redirect:/profile/" + authUser.getId();
    }

    @GetMapping("/{userId}")
    public String userProfilePage (
            ModelMap model,
            @RequestAttribute("user") User authUser,
            @PathVariable("userId") Long userId
    ) {
        User targetUser = userService.getUserById(userId);
        if (targetUser == null) {
            // TODO: show error message USER NOT FOUND
            return "redirect:/home";
        }

        if (Objects.equals(authUser.getId(), targetUser.getId())) {
            model.addAttribute("isCurrentUser", true);
        }
        model.addAttribute("targetUser", targetUser);

        return "profile/index";
    }
}
