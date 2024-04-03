package com.ht.controllers;

import jakarta.servlet.http.HttpServletRequest;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.RequestMapping;

import java.net.MalformedURLException;
import java.net.URL;

@Controller
@RequestMapping("/home")
public class HomeController {
    @GetMapping
    public String index(HttpServletRequest request) {
        return "home/index";
    }
}
