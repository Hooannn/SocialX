package com.ht.controllers;

import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.RequestMapping;

@Controller
@RequestMapping("/content")
public class ContentController {
    @GetMapping("/terms")
    public String termsOfService() {
        return "content/terms";
    }

    @GetMapping("/privacy-policy")
    public String privacyPolicy() {
        return "content/privacy-policy";
    }
}
