package com.ht.configs;

import com.ht.entities.User;
import com.ht.services.JwtService;
import jakarta.servlet.http.Cookie;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import org.springframework.web.servlet.HandlerInterceptor;

import java.util.Arrays;

public class AuthInterceptor implements HandlerInterceptor {
    private final JwtService jwtService;
    public AuthInterceptor(JwtService jwtService) {
        this.jwtService = jwtService;
    }
    @Override
    public boolean preHandle(HttpServletRequest request, HttpServletResponse response, Object handler) throws Exception {
        // Logic to check cookies before handling the request
        System.out.println("AuthInterceptor.preHandle called");
        String contextPath = request.getContextPath() + "/";
        Cookie[] cookies = request.getCookies();
        if (cookies != null) {
            for (Cookie cookie : cookies) {
                if ("access_token".equals(cookie.getName())) {
                    try {
                        String accessToken = cookie.getValue();
                        boolean isTokenValid = jwtService.isTokenValid(accessToken);
                        if (!isTokenValid) {
                            response.sendRedirect(contextPath + "auth/sign-in");
                            return false; // Stop processing the request
                        }
                        User user = jwtService.extractUser(accessToken);
                        request.setAttribute("user", user);
                        return true; // Continue processing the request
                    } catch (Exception e) {
                        System.out.println("AuthInterceptor.preHandle: " + e.toString());
                        response.sendRedirect(contextPath + "auth/sign-in");
                        return false; // Stop processing the request
                    }
                }
            }
        }
        response.sendRedirect(contextPath + "auth/sign-in");
        return false; // Stop processing the request
    }
}
