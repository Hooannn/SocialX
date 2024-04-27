package com.ht.controllers;

import com.cloudinary.Cloudinary;
import com.cloudinary.utils.ObjectUtils;
import com.ht.dtos.ChangePasswordDto;
import com.ht.entities.User;
import com.ht.enums.FriendStatus;
import com.ht.services.FriendService;
import com.ht.services.JwtService;
import com.ht.services.PostService;
import com.ht.services.UserService;
import jakarta.servlet.http.Cookie;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.validation.Valid;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.ModelMap;
import org.springframework.validation.BindingResult;
import org.springframework.web.bind.annotation.*;
import org.springframework.web.multipart.MultipartFile;
import org.springframework.web.servlet.mvc.support.RedirectAttributes;

import java.text.ParseException;
import java.text.SimpleDateFormat;
import java.util.Date;
import java.util.Map;
import java.util.Objects;

@Controller
@RequestMapping("/profile")
public class ProfileController {
    private final UserService userService;
    private final PostService postService;
    private final FriendService friendService;
    private final Cloudinary cloudinary;
    private final JwtService jwtService;

    @Autowired
    public ProfileController(UserService userService, PostService postService, FriendService friendService, Cloudinary cloudinary, JwtService jwtService) {
        this.userService = userService;
        this.postService = postService;
        this.friendService = friendService;
        this.cloudinary = cloudinary;
        this.jwtService = jwtService;
    }

    @GetMapping()
    public String myProfile(@RequestAttribute("user") User authUser) {
        return "redirect:/profile/" + authUser.getId();
    }

    @GetMapping("/{userId}")
    public String userProfilePage(
            ModelMap model,
            @RequestAttribute("user") User authUser,
            @PathVariable("userId") Long userId,
            RedirectAttributes redirectAttributes
    ) {
        User targetUser = userService.getUserById(userId);
        if (targetUser == null) {
            redirectAttributes.addFlashAttribute("errorMessage", "Người dùng không tồn tại");
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
            ModelMap model,
            @RequestAttribute("user") User authUser,
            HttpServletResponse response,
            RedirectAttributes redirectAttributes
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

        Date parsedDateOfBirth;
        try {
            parsedDateOfBirth = new SimpleDateFormat("yyyy-MM-dd").parse(dateOfBirth);
        } catch (ParseException e) {
            model.addAttribute("errorMessage", "Định dạng ngày không hợp lệ");
            model.addAttribute("tab", "information");
            return "profile/edit";
        }

        // Cập nhật thông tin cá nhân của người dùng
        authUser.setFirstName(firstName);
        authUser.setLastName(lastName);
        authUser.setDateOfBirth(parsedDateOfBirth);
        authUser.setSex(sex);
        authUser.setAddress(address);
        if (imageUrl != null) {
            authUser.setAvatar(imageUrl);
        }

        // Lưu vào cơ sở dữ liệu
        userService.saveOrUpdateUser(authUser);

        // Cập nhật lại access token
        String accessToken = jwtService.generateAccessToken(authUser);
        Cookie cookie = new Cookie("access_token", accessToken);
        cookie.setPath("/");
        cookie.setMaxAge(60 * 60 * 24 * 30);
        response.addCookie(cookie);

        redirectAttributes.addFlashAttribute("successMessage", "Đổi mật khẩu thành công");

        return "redirect:/profile/edit";
    }

    @PostMapping("/edit/password")
    public String editProfilePassword(
            @Valid @ModelAttribute("changePasswordDto") ChangePasswordDto changePasswordDto, BindingResult result,
            ModelMap model,
            @RequestAttribute("user") User authUser, RedirectAttributes redirectAttributes
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

        try {
            userService.changePassword(authUser.getId(), changePasswordDto);
        } catch (Exception e) {
            model.addAttribute("errorMessage", e.getMessage());
            model.addAttribute("tab", "password");
            return "profile/edit";
        }

        redirectAttributes.addFlashAttribute("successMessage", "Đổi mật khẩu thành công");

        return "redirect:/profile/edit";
    }
}