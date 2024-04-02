package com.ht.controllers;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.mail.javamail.JavaMailSender;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;

@Controller("/home/")
public class WelcomeController {
    @Autowired
    JavaMailSender mailSender;
    @RequestMapping(value = "test", method = RequestMethod.GET)
    public String test() {
        return "home/test";
    }
}
