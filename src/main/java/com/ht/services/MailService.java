package com.ht.services;

import jakarta.mail.MessagingException;
import jakarta.mail.internet.MimeMessage;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.mail.javamail.JavaMailSender;
import org.springframework.mail.javamail.MimeMessageHelper;
import org.springframework.stereotype.Service;

import java.io.UnsupportedEncodingException;

@Service
public class MailService {
    private final JavaMailSender javaMailSender;

    @Autowired
    public MailService(JavaMailSender javaMailSender) {
        this.javaMailSender = javaMailSender;
    }

    public void send(String from, String to, String subject, String body) throws MessagingException, UnsupportedEncodingException {
        MimeMessage mail = javaMailSender.createMimeMessage();
        MimeMessageHelper helper = new MimeMessageHelper(mail, true, "utf-8");
        helper.setFrom(from, from);
        helper.setTo(to);
        helper.setReplyTo(from, from);
        helper.setSubject(subject);
        helper.setText(body, true);
        javaMailSender.send(mail);
    }
}
