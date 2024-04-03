package com.ht.dtos;

import jakarta.validation.constraints.Email;
import jakarta.validation.constraints.NotEmpty;
import jakarta.validation.constraints.NotNull;
import jakarta.validation.constraints.Size;

public class SignUpDto {
    @NotEmpty(message = "Email không được để trống")
    @Email(message = "Email không hợp lệ")
    private String email;

    @Size(min = 6, max = 50, message = "Mật khẩu phải có ít nhất 6 ký tự")
    private String password;

    @Size(min = 6, max = 50, message = "Mật khẩu phải có ít nhất 6 ký tự")
    private String confirmPassword;

    @Size(min = 2, max = 50, message = "Tên phải có ít nhất 2 ký tự")
    private String firstName;

    @Size(min = 2, max = 50, message = "Họ phải có ít nhất 2 ký tự")
    private String lastName;

    public SignUpDto() {
    }

    public SignUpDto(String email, String password, String confirmPassword, String firstName, String lastName) {
        this.email = email;
        this.password = password;
        this.confirmPassword = confirmPassword;
        this.firstName = firstName;
        this.lastName = lastName;
    }

    public String getEmail() {
        return email;
    }

    public void setEmail(String email) {
        this.email = email;
    }

    public String getPassword() {
        return password;
    }

    public void setPassword(String password) {
        this.password = password;
    }

    public String getConfirmPassword() {
        return confirmPassword;
    }

    public void setConfirmPassword(String confirmPassword) {
        this.confirmPassword = confirmPassword;
    }

    public String getFirstName() {
        return firstName;
    }

    public void setFirstName(String firstName) {
        this.firstName = firstName;
    }

    public String getLastName() {
        return lastName;
    }

    public void setLastName(String lastName) {
        this.lastName = lastName;
    }
}
