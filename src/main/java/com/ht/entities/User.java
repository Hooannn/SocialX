package com.ht.entities;

import com.ht.enums.UserRole;

import javax.persistence.*;
import java.text.SimpleDateFormat;
import java.util.Date;
import java.util.Locale;

@Entity
@Table(name = "users")
public class User {
    @Id
    @GeneratedValue(strategy = GenerationType.IDENTITY)
    private Long id;

    @Column(name = "email", unique = true)
    private String email;

    @Column(name = "password", nullable = false)
    private String password;

    @Column(name = "first_name", nullable = false)
    private String firstName;

    @Column(name = "last_name", nullable = false)
    private String lastName;

    @Column(name = "avatar", nullable = false)
    private String avatar;

    @Column(name = "cover_image")
    private String coverImage;

    @Column(name = "reset_password_token")
    private String resetPasswordToken;

    @Column(name = "created_at", nullable = false)
    private Date createdAt;

    @Column(name = "date_of_birth")
    private Date dateOfBirth;

    @Column(name = "sex")
    private boolean sex; // 0 is male, 1 is female

    @Column(name = "address", columnDefinition = "TEXT")
    private String address;

    @Column(name = "disabled", nullable = false)
    private boolean disabled;

    @Column(name = "role", nullable = false)
    @Enumerated(EnumType.STRING)
    private UserRole role;

    public User() {
    }

    public User(Long id, String email, String password, String firstName, String lastName, String avatar, String coverImage, String resetPasswordToken, Date createdAt, Date dateOfBirth, boolean sex, String address, boolean disabled, UserRole role) {
        this.id = id;
        this.email = email;
        this.password = password;
        this.firstName = firstName;
        this.lastName = lastName;
        this.avatar = avatar;
        this.coverImage = coverImage;
        this.resetPasswordToken = resetPasswordToken;
        this.createdAt = createdAt;
        this.dateOfBirth = dateOfBirth;
        this.sex = sex;
        this.address = address;
        this.disabled = disabled;
        this.role = role;
    }

    public Long getId() {
        return id;
    }

    public void setId(Long id) {
        this.id = id;
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

    public String getAvatar() {
        return avatar;
    }

    public void setAvatar(String avatar) {
        this.avatar = avatar;
    }

    public String getResetPasswordToken() {
        return resetPasswordToken;
    }

    public void setResetPasswordToken(String resetPasswordToken) {
        this.resetPasswordToken = resetPasswordToken;
    }

    public Date getCreatedAt() {
        return createdAt;
    }

    public void setCreatedAt(Date createdAt) {
        this.createdAt = createdAt;
    }

    public UserRole getRole() {
        return role;
    }

    public void setRole(UserRole role) {
        this.role = role;
    }

    public boolean isDisabled() {
        return disabled;
    }

    public void setDisabled(boolean disabled) {
        this.disabled = disabled;
    }

    public Date getDateOfBirth() {
        return dateOfBirth;
    }

    public void setDateOfBirth(Date dateOfBirth) {
        this.dateOfBirth = dateOfBirth;
    }

    public boolean isSex() {
        return sex;
    }

    public void setSex(boolean sex) {
        this.sex = sex;
    }

    public String getAddress() {
        return address;
    }

    public void setAddress(String address) {
        this.address = address;
    }

    public String getCoverImage() {
        return coverImage;
    }

    public void setCoverImage(String coverImage) {
        this.coverImage = coverImage;
    }

    public String getFullName() {
        return lastName + " " + firstName;
    }

    public String getFormattedBirthday() {
        SimpleDateFormat sdf = new SimpleDateFormat("dd MMMM, yyyy", new Locale("vi", "VN"));
        return sdf.format(dateOfBirth);
    }

    public String getFormattedCreatedAt() {
        SimpleDateFormat sdf = new SimpleDateFormat("dd MMMM, yyyy", new Locale("vi", "VN"));
        return sdf.format(createdAt);
    }

    @PrePersist
    public void prePersist() {
        if (role == null) role = UserRole.USER;
        if (createdAt == null) createdAt = new Date();
        if (avatar == null) avatar = "https://cdn-icons-png.flaticon.com/512/6596/6596121.png";
    }

    @Override
    public String toString() {
        return "User{" +
                "id=" + id +
                ", email='" + email + '\'' +
                ", password='" + password + '\'' +
                ", firstName='" + firstName + '\'' +
                ", lastName='" + lastName + '\'' +
                ", avatar='" + avatar + '\'' +
                ", coverImage='" + coverImage + '\'' +
                ", resetPasswordToken='" + resetPasswordToken + '\'' +
                ", createdAt=" + createdAt +
                ", dateOfBirth=" + dateOfBirth +
                ", sex=" + sex +
                ", address='" + address + '\'' +
                ", disabled=" + disabled +
                ", role=" + role +
                '}';
    }
}
