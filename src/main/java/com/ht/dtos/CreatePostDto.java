package com.ht.dtos;

import jakarta.validation.constraints.NotEmpty;

public class CreatePostDto {
    @NotEmpty(message = "Tiêu đề không được để trống")
    private String title;

    @NotEmpty(message = "Nội dung không được để trống")
    private String content;

    public CreatePostDto() {
    }

    public CreatePostDto(String title, String content) {
        this.title = title;
        this.content = content;
    }

    public String getTitle() {
        return title;
    }

    public void setTitle(String title) {
        this.title = title;
    }

    public String getContent() {
        return content;
    }

    public void setContent(String content) {
        this.content = content;
    }

    @Override
    public String toString() {
        return "CreatePostDto{" +
                "title='" + title + '\'' +
                ", content='" + content + '\'' +
                '}';
    }
}
