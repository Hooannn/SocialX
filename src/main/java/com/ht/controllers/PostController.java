package com.ht.controllers;

import com.ht.dtos.CreatePostDto;
import com.ht.entities.User;
import com.ht.services.PostService;
import jakarta.validation.Valid;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.ModelMap;
import org.springframework.validation.BindingResult;
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

    @GetMapping("create")
    public String createPost(ModelMap model) {
        CreatePostDto createPostDto = new CreatePostDto();
        model.addAttribute("createPostDto", createPostDto);
        return "post/create";
    }

    @GetMapping("{id}")
    public String viewPost(ModelMap model, @PathVariable("id") Long id) {
        model.addAttribute("post", postService.getPost(id));
        return "post/detail";
    }

    @PostMapping("create")
    public String createPost(@RequestAttribute("user") User authUser,
                             @Valid @ModelAttribute("createPostDto") CreatePostDto createPostDto,
                             BindingResult bindingResult) {
        if (bindingResult.hasErrors()) {
            return "post/create";
        }
        // TODO: create post, create notification for friends, then redirect to post detail page
        System.out.println(createPostDto);
        return "redirect:/post/" + 1; //replace with created post id;
    }
}
