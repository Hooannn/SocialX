package com.ht.dtos;

import jakarta.validation.constraints.Size;

public class ChangePasswordDto {
    @Size(min = 6, max = 50, message = "Mật khẩu phải có ít nhất 6 ký tự")
    private String currentPassword;

    @Size(min = 6, max = 50, message = "Mật khẩu phải có ít nhất 6 ký tự")
    private String newPassword;

    @Size(min = 6, max = 50, message = "Mật khẩu phải có ít nhất 6 ký tự")
    private String confirmPassword;

    public ChangePasswordDto(String currentPassword, String newPassword, String confirmPassword) {
        this.currentPassword = currentPassword;
        this.newPassword = newPassword;
        this.confirmPassword = confirmPassword;
    }

    public ChangePasswordDto() {
    }

    public String getCurrentPassword() {
        return currentPassword;
    }

    public void setCurrentPassword(String currentPassword) {
        this.currentPassword = currentPassword;
    }

    public String getNewPassword() {
        return newPassword;
    }

    public void setNewPassword(String newPassword) {
        this.newPassword = newPassword;
    }

    public String getConfirmPassword() {
        return confirmPassword;
    }

    public void setConfirmPassword(String confirmPassword) {
        this.confirmPassword = confirmPassword;
    }

    @Override
    public String toString() {
        return "ChangePasswordDto{" +
                "currentPassword='" + currentPassword + '\'' +
                ", newPassword='" + newPassword + '\'' +
                ", confirmPassword='" + confirmPassword + '\'' +
                '}';
    }
}
