package com.ht.configs;

public class AppConfig {
    private String accessSecretKey;
    private String passwordSecretKey;
    private long jwtExpiration;
    private long resetPasswordExpiration;

    public AppConfig() {
    }

    public AppConfig(String accessSecretKey, String passwordSecretKey, long jwtExpiration, long resetPasswordExpiration) {
        this.accessSecretKey = accessSecretKey;
        this.passwordSecretKey = passwordSecretKey;
        this.jwtExpiration = jwtExpiration;
        this.resetPasswordExpiration = resetPasswordExpiration;
    }

    public String getAccessSecretKey() {
        return accessSecretKey;
    }

    public void setAccessSecretKey(String accessSecretKey) {
        this.accessSecretKey = accessSecretKey;
    }

    public String getPasswordSecretKey() {
        return passwordSecretKey;
    }

    public void setPasswordSecretKey(String passwordSecretKey) {
        this.passwordSecretKey = passwordSecretKey;
    }

    public long getJwtExpiration() {
        return jwtExpiration;
    }

    public void setJwtExpiration(long jwtExpiration) {
        this.jwtExpiration = jwtExpiration;
    }

    public long getResetPasswordExpiration() {
        return resetPasswordExpiration;
    }

    public void setResetPasswordExpiration(long resetPasswordExpiration) {
        this.resetPasswordExpiration = resetPasswordExpiration;
    }
}
