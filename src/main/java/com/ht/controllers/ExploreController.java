package com.ht.controllers;

import com.ht.entities.User;
import com.ht.services.UserService;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.ModelMap;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.RequestAttribute;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;

@Controller
@RequestMapping("/explore")
public class ExploreController {
    private final UserService userService;

    @Autowired
    public ExploreController(UserService userService) {
        this.userService = userService;
    }

    @GetMapping
    public String index(@RequestParam(value = "page", required = false, defaultValue = "1") int page,
                        @RequestParam(value = "size", required = false, defaultValue = "10") int size,
                        @RequestParam(value = "query", required = false, defaultValue = "") String query,
                        @RequestAttribute("user") User authUser,
                        ModelMap model) {
        var searchUserResponse = userService.searchUser(authUser, query, page, size);
        int totalPages = (int) Math.ceil((double) searchUserResponse.total() / size);
        model.addAttribute("usersWithFriendStatus", searchUserResponse.data());
        model.addAttribute("page", page);
        model.addAttribute("totalPages", totalPages);
        model.addAttribute("query", query);
        model.addAttribute("size", size);
        return "explore/index";
    }
}
