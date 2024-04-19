package com.ht.controllers;

import com.ht.dtos.ChangePasswordDto;
import com.ht.entities.User;
import com.ht.enums.FriendStatus;
import com.ht.services.FriendService;
import com.ht.services.PostService;
import com.ht.services.UserService;
import jakarta.validation.Valid;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.ModelMap;
import org.springframework.validation.BindingResult;
import org.springframework.web.bind.annotation.*;

import java.util.Objects;

@Controller
@RequestMapping("/profile")
public class ProfileController {
    private final UserService userService;
    private final PostService postService;
    private final FriendService friendService;

    @Autowired
    public ProfileController(UserService userService, PostService postService, FriendService friendService) {
        this.userService = userService;
        this.postService = postService;
        this.friendService = friendService;
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

        var posts = this.postService.findAllByUserId(targetUser.getId());

        if (Objects.equals(authUser.getId(), targetUser.getId())) {
            model.addAttribute("isCurrentUser", true);
        } else {
            FriendStatus friendStatus = this.friendService.checkFriendRequest(authUser.getId(), targetUser.getId());
            model.addAttribute("friendStatus", friendStatus.toString());
        }

        model.addAttribute("targetUser", targetUser);
        model.addAttribute("posts", posts);

        return "profile/index";
    }

    @GetMapping("/edit")
    public String editProfilePage (
            ModelMap model,
            @RequestAttribute("user") User authUser
    ) {
        ChangePasswordDto changePasswordDto = new ChangePasswordDto();
        model.addAttribute("user", authUser);
        model.addAttribute("changePasswordDto", changePasswordDto);
        return "profile/edit";
    }

    @PostMapping("/edit/information")
    public String editProfileInformation (
            @ModelAttribute("user") User user, BindingResult result,
            ModelMap model
    ) {
        if (result.hasErrors()) {
            model.addAttribute("tab", "information");
            return "profile/edit";
        }

        /* TODO:
        Update user information, generate new access token, then return redirect to /profile/edit,
        If update failed, add error message to model, and return to /profile/edit
        */
        System.out.println(user);
        return "redirect:/profile/edit";
    }

    @PostMapping("/edit/password")
    public String editProfilePassword (
            @Valid @ModelAttribute("changePasswordDto") ChangePasswordDto changePasswordDto, BindingResult result,
            ModelMap model
    ) {
        if (result.hasErrors()) {
            model.addAttribute("tab", "password");
            return "profile/edit";
        }
        if (!changePasswordDto.getNewPassword().equals(changePasswordDto.getConfirmPassword())) {
            result.rejectValue("confirmPassword", "confirmPassword", "Mật khẩu không khớp");
            model.addAttribute("tab", "password");
            return "profile/edit";
        }

        /* TODO: Update user password, then return redirect to /profile/edit */
        System.out.println(changePasswordDto);
        return "redirect:/profile/edit";
    }
}
