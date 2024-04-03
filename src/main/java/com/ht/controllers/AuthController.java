package com.ht.controllers;

import com.ht.dtos.SignInDto;
import com.ht.dtos.SignUpDto;
import com.ht.services.AuthService;
import jakarta.servlet.http.Cookie;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.validation.Valid;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.ModelMap;
import org.springframework.validation.BindingResult;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.ModelAttribute;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestMapping;

@Controller
@RequestMapping("/auth")
public class AuthController {
    private final AuthService authService;
    @Autowired
    public AuthController(AuthService authService) {
        this.authService = authService;
    }

    @GetMapping("/sign-in")
    public String signIn(ModelMap model) {
        model.addAttribute("signInDto", new SignInDto());
        return "auth/sign-in";
    }

    @PostMapping("/sign-in")
    public String signIn(@Valid @ModelAttribute("signInDto") SignInDto signInDto, BindingResult result, ModelMap model, HttpServletResponse response) {
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
        return "redirect:/home";
    }

    @GetMapping("/sign-up")
    public String signUp(ModelMap model) {
        model.addAttribute("signUpDto", new SignUpDto());
        return "auth/sign-up";
    }

    @PostMapping("/sign-up")
    public String signUp(@Valid @ModelAttribute("signUpDto") SignUpDto signUpDto, BindingResult result, ModelMap model, HttpServletResponse response) {
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
            System.out.println("error: " + e.toString());
            model.addAttribute("errorMessage", e.getMessage() == null ? e.toString() : e.getMessage());
            return "auth/sign-up";
        }
        return "redirect:/home";
    }

    @GetMapping("/sign-out")
    public String signOut(HttpServletResponse response) {
        Cookie cookie = new Cookie("access_token", "");
        cookie.setPath("/");
        cookie.setMaxAge(0);
        response.addCookie(cookie);
        return "redirect:/auth/sign-in";
    }

    private Cookie saveAccessToken(String accessToken) {
        Cookie cookie = new Cookie("access_token", accessToken);
        cookie.setPath("/");
        cookie.setMaxAge(60 * 60 * 24 * 30); // 30 days
        return cookie;
    }
}
