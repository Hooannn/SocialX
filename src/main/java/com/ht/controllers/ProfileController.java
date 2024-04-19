package com.ht.controllers;

import com.cloudinary.Cloudinary;
import com.cloudinary.utils.ObjectUtils;
import com.ht.dtos.ChangePasswordDto;
import com.ht.entities.User;
import com.ht.services.UserService;
import jakarta.validation.Valid;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.ModelMap;
import org.springframework.validation.BindingResult;
import org.springframework.web.bind.annotation.*;
import org.springframework.web.multipart.MultipartFile;

import java.util.Map;
import java.util.Objects;

@Controller
@RequestMapping("/profile")
public class ProfileController {
    private final UserService userService;
    private final Cloudinary cloudinary;

    @Autowired
    public ProfileController(UserService userService, Cloudinary cloudinary) {
        this.userService = userService;
        this.cloudinary = cloudinary;
    }

    @GetMapping()
    public String myProfile(@RequestAttribute("user") User authUser) {
        return "redirect:/profile/" + authUser.getId();
    }

    @GetMapping("/{userId}")
    public String userProfilePage(
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

    @GetMapping("/edit")
    public String editProfilePage(
            ModelMap model,
            @RequestAttribute("user") User authUser
    ) {
        ChangePasswordDto changePasswordDto = new ChangePasswordDto();

        model.addAttribute("user", authUser);
        model.addAttribute("changePasswordDto", changePasswordDto);
        return "profile/edit";
    }

    @PostMapping("/edit/information")
    public String editProfileInformation(
            @RequestParam(name = "file", required = false) MultipartFile file,
            @RequestParam(name = "firstName", required = false) String firstName,
            @RequestParam(name = "lastName", required = false) String lastName,
            @RequestParam(name = "dateOfBirth", required = false) String dateOfBirth,
            @RequestParam(name = "sex") boolean sex,
            @RequestParam(name = "address", required = false) String address,
            ModelMap model
    ) {
        String imageUrl = null;
        if (file != null && !file.isEmpty()) {
            try {
                Map uploadResult = cloudinary.uploader().upload(file.getBytes(), ObjectUtils.emptyMap());
                imageUrl = (String) uploadResult.get("url");
            } catch (Exception e) {
                model.addAttribute("errorMessage", "Lỗi khi tải ảnh lên");
                model.addAttribute("tab", "information");
                return "profile/edit";
            }
        }
        if (firstName.isEmpty() || lastName.isEmpty() || dateOfBirth.isEmpty() || address.isEmpty()) {
            model.addAttribute("errorMessage", "Vui lòng điền đầy đủ thông tin");
            model.addAttribute("tab", "information");
            return "profile/edit";
        }

        /* TODO:
        Update user information, generate new access token, then return redirect to /profile/edit,
        If update failed, add error message to model, and return to /profile/edit
        */
        // Remember to parse dateOfBirth to Date
        System.out.println(
                "firstName: " + firstName + "\n" +
                        "lastName: " + lastName + "\n" +
                        "dateOfBirth: " + dateOfBirth + "\n" +
                        "sex: " + sex + "\n" +
                        "address: " + address + "\n" + "imageUrl: " + imageUrl + "\n"
        );
        return "redirect:/profile/edit";
    }

    @PostMapping("/edit/password")
    public String editProfilePassword(
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
