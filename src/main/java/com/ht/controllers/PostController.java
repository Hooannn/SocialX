package com.ht.controllers;

import com.cloudinary.Cloudinary;
import com.cloudinary.utils.ObjectUtils;
import com.ht.entities.PostFile;
import com.ht.entities.User;
import com.ht.services.PostService;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.ModelMap;
import org.springframework.web.bind.annotation.*;
import org.springframework.web.multipart.MultipartFile;

import java.util.ArrayList;
import java.util.List;
import java.util.Map;

@Controller
@RequestMapping("/post")
public class PostController {
    private final PostService postService;
    private final Cloudinary cloudinary;

    @Autowired
    public PostController(PostService postService, Cloudinary cloudinary) {
        this.postService = postService;
        this.cloudinary = cloudinary;
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
        return "post/create";
    }

    @GetMapping("{id}")
    public String viewPost(ModelMap model, @PathVariable("id") Long id) {
        model.addAttribute("post", postService.getPost(id));
        return "post/detail";
    }

    @PostMapping("create")
    public String createPost(@RequestAttribute("user") User authUser,
                             @RequestParam(name = "files", required = false) MultipartFile[] files,
                             @RequestParam(name = "title", required = false) String title,
                             @RequestParam(name = "content", required = false) String content,
                             ModelMap model) {
        if (title == null || title.isEmpty() || content == null || content.isEmpty()) {
            model.addAttribute("errorMessage", "Vui lòng nhập đủ thông tin bài viết");
            return "post/create";
        }

        List<PostFile> postFiles = new ArrayList<>();
        if (files != null) {
            for (MultipartFile file : files) {
                try {
                    Map uploadResult = cloudinary.uploader().upload(file.getBytes(), ObjectUtils.emptyMap());
                    String imageUrl = (String) uploadResult.get("url"); // PostFile.fileUrl
                    String signature = (String) uploadResult.get("signature"); // PostFile.id
                    String resourceType = (String) uploadResult.get("resource_type"); // PostFile.mimeType
                    String originalFilename = (String) uploadResult.get("original_filename"); // PostFile.fileName
                    int fileSize = (int) uploadResult.get("bytes"); // PostFile.fileSize
                    PostFile postFile = new PostFile(signature, originalFilename, resourceType, fileSize, imageUrl, null);
                    postFiles.add(postFile);
                } catch (Exception e) {
                    model.addAttribute("errorMessage", "Lỗi khi tải ảnh lên: " + e.getMessage());
                    return "post/create";
                }
            }
        }

        // TODO: create post, create post_files if present, create notification for friends, then redirect to post detail page
        System.out.println("Create post: " + title + " - " + content);
        System.out.println("Files: " + postFiles.size());
        for (PostFile postFile : postFiles) {
            System.out.println(postFile);
        }
        return "redirect:/post/" + 1; //replace with created post id;
    }

    @PostMapping("{id}/comment")
    public String createComment(@RequestAttribute("user") User authUser,
                                @PathVariable("id") Long id,
                                @RequestParam(name = "content", required = false) String content,
                                @RequestParam(name = "authorId", required = false) Long authorId,
                                ModelMap model) {
        if (content == null || content.isEmpty()) {
            model.addAttribute("errorMessage", "Vui lòng nhập nội dung bình luận");
            return "post/detail";
        }
        try {
            postService.createComment(authUser, id, content, authorId);
            return "redirect:/post/" + id;
        } catch (Exception e) {
            model.addAttribute("errorMessage", e.getMessage());
            return "post/detail";
        }
    }
}
