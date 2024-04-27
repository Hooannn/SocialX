package com.ht.controllers;

import com.ht.dtos.ForgotPasswordDto;
import com.ht.dtos.ResetPasswordDto;
import com.ht.dtos.SignInDto;
import com.ht.dtos.SignUpDto;
import com.ht.services.AuthService;
import jakarta.servlet.http.Cookie;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.validation.Valid;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.ModelMap;
import org.springframework.validation.BindingResult;
import org.springframework.web.bind.annotation.*;
import org.springframework.web.servlet.mvc.support.RedirectAttributes;

@Controller
@RequestMapping("/auth")
public class AuthController {
    private final AuthService authService;

    @Autowired
    public AuthController(AuthService authService) {
        this.authService = authService;
    }

    // GET Method

    @GetMapping("/sign-in")
    public String signIn(ModelMap model) {
        model.addAttribute("signInDto", new SignInDto());
        return "auth/sign-in";
    }

    @GetMapping("/sign-up")
    public String signUp(ModelMap model) {
        model.addAttribute("signUpDto", new SignUpDto());
        return "auth/sign-up";
    }

    @GetMapping("/forgot-password")
    public String forgotPassword(ModelMap model) {
        model.addAttribute("forgotPasswordDto", new ForgotPasswordDto());
        return "auth/forgot-password";
    }

    @GetMapping(value = "/reset-password")
    public String resetPassword(ModelMap model, @RequestParam(name = "token", required = false) String token) {
        ResetPasswordDto resetPasswordDto = new ResetPasswordDto();
        resetPasswordDto.setToken(token);
        if (token == null || token.isEmpty())
            model.addAttribute("errorMessage", "Token không hợp lệ");
        model.addAttribute("resetPasswordDto", resetPasswordDto);
        return "auth/reset-password";
    }

    @GetMapping("/sign-out")
    public String signOut(HttpServletResponse response) {
        Cookie cookie = new Cookie("access_token", "");
        cookie.setPath("/");
        cookie.setMaxAge(0);
        response.addCookie(cookie);
        return "redirect:/auth/sign-in";
    }

    // POST Method

    @PostMapping("/sign-in")
    public String signIn(@Valid @ModelAttribute("signInDto") SignInDto signInDto, BindingResult result, ModelMap model, HttpServletResponse response, RedirectAttributes redirectAttributes) {
        if (result.hasErrors()) {
            return "auth/sign-in";
        }
        try {
            String accessToken = authService.signIn(signInDto);
            Cookie cookie = saveAccessToken(accessToken);
            response.addCookie(cookie);
        } catch (Exception e) {
            model.addAttribute("errorMessage", e.getMessage() == null ? e.toString() : e.getMessage());
            return "auth/sign-in";
        }
        redirectAttributes.addFlashAttribute("successMessage", "Đăng nhập thành công");
        return "redirect:/home";
    }

    @PostMapping("/sign-up")
    public String signUp(@Valid @ModelAttribute("signUpDto") SignUpDto signUpDto, BindingResult result, ModelMap model, HttpServletResponse response, RedirectAttributes redirectAttributes) {
        if (result.hasErrors()) {
            return "auth/sign-up";
        }
        if (!signUpDto.getPassword().equals(signUpDto.getConfirmPassword())) {
            result.rejectValue("confirmPassword", "confirmPassword", "Mật khẩu không khớp");
            return "auth/sign-up";
        }
        try {
            String accessToken = authService.signUp(signUpDto);
            Cookie cookie = saveAccessToken(accessToken);
            response.addCookie(cookie);
        } catch (Exception e) {
            model.addAttribute("errorMessage", e.getMessage() == null ? e.toString() : e.getMessage());
            return "auth/sign-up";
        }
        redirectAttributes.addFlashAttribute("successMessage", "Đăng ký thành công");
        return "redirect:/home";
    }

    @PostMapping("/forgot-password")
    public String forgotPassword(@Valid @ModelAttribute("forgotPasswordDto") ForgotPasswordDto forgotPasswordDto, BindingResult result, ModelMap model, HttpServletRequest request, RedirectAttributes redirectAttributes) {
        if (result.hasErrors()) {
            return "auth/forgot-password";
        }
        try {
            authService.forgotPassword(forgotPasswordDto, request);
        } catch (Exception e) {
            model.addAttribute("errorMessage", e.getMessage() == null ? e.toString() : e.getMessage());
            return "auth/forgot-password";
        }
        model.addAttribute("successMessage", "Vui lòng kiểm tra email để đặt lại mật khẩu");
        return "auth/forgot-password";
    }

    @PostMapping(value = "/reset-password")
    public String resetPassword(@Valid @ModelAttribute("resetPasswordDto") ResetPasswordDto resetPasswordDto, BindingResult result, ModelMap model, RedirectAttributes redirectAttributes) {
        if (result.hasErrors()) {
            return "auth/reset-password";
        }
        if (!resetPasswordDto.getPassword().equals(resetPasswordDto.getConfirmPassword())) {
            result.rejectValue("confirmPassword", "confirmPassword", "Mật khẩu không khớp");
            return "auth/reset-password";
        }
        try {
            authService.resetPassword(resetPasswordDto);
        } catch (Exception e) {
            model.addAttribute("errorMessage", e.getMessage() == null ? e.toString() : e.getMessage());
            return "auth/reset-password";
        }
        redirectAttributes.addFlashAttribute("successMessage", "Mật khẩu của bạn đã được đặt lại thành công");
        return "redirect:/auth/sign-in";
    }

    private Cookie saveAccessToken(String accessToken) {
        Cookie cookie = new Cookie("access_token", accessToken);
        cookie.setPath("/");
        cookie.setMaxAge(60 * 60 * 24 * 30); // 30 days
        return cookie;
    }
}
