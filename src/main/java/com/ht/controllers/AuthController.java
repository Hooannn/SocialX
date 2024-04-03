package com.ht.controllers;

import com.ht.dtos.SignInDto;
import com.ht.dtos.SignUpDto;
import com.ht.services.AuthService;
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
    public String signIn(@Valid @ModelAttribute("signInDto") SignInDto signInDto, BindingResult result, ModelMap model) {
        if (result.hasErrors()) {
            return "auth/sign-in";
        }
        try {
            authService.signIn(signInDto);
        } catch (Exception e) {
            model.addAttribute("errorMessage", e.getMessage());
            return "auth/sign-in";
        }
        return "redirect:/";
    }

    @GetMapping("/sign-up")
    public String signUp(ModelMap model) {
        model.addAttribute("signUpDto", new SignUpDto());
        return "auth/sign-up";
    }

    @PostMapping("/sign-up")
    public String signUp(@Valid @ModelAttribute("signUpDto") SignUpDto signUpDto, BindingResult result, ModelMap model) throws Exception {
        if (result.hasErrors()) {
            return "auth/sign-up";
        }
        if (!signUpDto.getPassword().equals(signUpDto.getConfirmPassword())) {
            result.rejectValue("confirmPassword", "confirmPassword", "Mật khẩu không khớp");
            return "auth/sign-up";
        }
        try {
            authService.signUp(signUpDto);
        } catch (Exception e) {
            model.addAttribute("errorMessage", e.getMessage());
            return "auth/sign-up";
        }
        return "redirect:/";
    }
}
