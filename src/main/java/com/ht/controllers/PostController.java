package com.ht.controllers;

import com.ht.entities.User;
import com.ht.services.PostService;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.ModelMap;
import org.springframework.web.bind.annotation.*;

@Controller
@RequestMapping("/post")
public class PostController {
    private final PostService postService;

    @Autowired
    public PostController(PostService postService) {
        this.postService = postService;
    }

    @GetMapping("/{id}/unlike")
    public String unlike(
            ModelMap model,
            @RequestAttribute("user") User authUser,
            @RequestParam(value = "redirect", required = false) String redirect,
            @PathVariable("id") Long id) {
        try {
            postService.unlike(authUser.getId(), id);
        } catch (Exception e) {
            model.addAttribute("errorMessage", e.getMessage());
        }
        String redirectUrl = redirect != null ? redirect : "/";
        return "redirect:" + redirectUrl;
    }

    @GetMapping("/{id}/like")
    public String like(
            ModelMap model,
            @RequestAttribute("user") User authUser,
            @RequestParam(value = "redirect", required = false) String redirect,
            @PathVariable("id") Long id) {
        try {
            postService.like(authUser.getId(), id);
        } catch (Exception e) {
            model.addAttribute("errorMessage", e.getMessage());
        }
        String redirectUrl = redirect != null ? redirect : "/";
        return "redirect:" + redirectUrl;
    }

    //Create, update, delete post
}
