<%--
  Created by IntelliJ IDEA.
  User: nguyenduckhaihoan
  Date: 03/04/2024
  Time: 21:16
  To change this template use File | Settings | File Templates.
--%>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>
<!doctype html>
<html lang="en">
<head>
    <base href="${pageContext.request.contextPath}/"/>
    <meta charset="utf-8">
    <meta name="viewport" content="width=device-width, initial-scale=1, shrink-to-fit=no">
    <title>SocialX | Trang chủ</title>

    <link rel="shortcut icon" href="images/favicon.ico"/>
    <link rel="stylesheet" href="css/libs.min.css">
    <link rel="stylesheet" href="css/socialv.css?v=4.0.0">
    <link rel="stylesheet" href="vendor/@fortawesome/fontawesome-free/css/all.min.css">
    <link rel="stylesheet" href="vendor/remixicon/fonts/remixicon.css">
    <link rel="stylesheet" href="vendor/vanillajs-datepicker/dist/css/datepicker.min.css">
    <link rel="stylesheet" href="vendor/font-awesome-line-awesome/css/all.min.css">
    <link rel="stylesheet" href="vendor/line-awesome/dist/line-awesome/css/line-awesome.min.css">

</head>
<body class="  ">
<!-- loader Start -->
<div id="loading">
    <div id="loading-center">
    </div>
</div>
<!-- loader END -->
<!-- Wrapper Start -->
<div class="wrapper">
    <div class="iq-sidebar sidebar-default ">
        <div id="sidebar-scrollbar">
            <nav class="iq-sidebar-menu">
                <ul id="iq-sidebar-toggle" class="iq-menu">
                    <li class="active">
                        <a href="home" class=" ">
                            <i class="las la-newspaper"></i><span>Bảng tin</span>
                        </a>
                    </li>
                    <li class="">
                        <a href="profile" class=" ">
                            <i class="las la-user"></i><span>Hồ sơ</span>
                        </a>
                    </li>
                </ul>
            </nav>
            <div class="p-5"></div>
        </div>
    </div>

    <div class="iq-top-navbar">
        <div class="iq-navbar-custom">
            <nav class="navbar navbar-expand-lg navbar-light p-0">
                <div class="iq-navbar-logo d-flex justify-content-between">
                    <a href="home">
                        <img src="images/logo.png" class="img-fluid" alt="">
                        <span>SocialX</span>
                    </a>
                    <div class="iq-menu-bt align-self-center">
                        <div class="wrapper-menu">
                            <div class="main-circle"><i class="ri-menu-line"></i></div>
                        </div>
                    </div>
                </div>
                <div class="iq-search-bar device-search">
                    <form action="#" class="searchbox">
                        <a class="search-link" href="#"><i class="ri-search-line"></i></a>
                        <input type="text" class="text search-input" placeholder="Search here...">
                    </form>
                </div>
                <button class="navbar-toggler" type="button" data-bs-toggle="collapse"
                        data-bs-target="#navbarSupportedContent" aria-controls="navbarSupportedContent"
                        aria-label="Toggle navigation">
                    <i class="ri-menu-3-line"></i>
                </button>
                <div class="collapse navbar-collapse" id="navbarSupportedContent">
                    <ul class="navbar-nav  ms-auto navbar-list">
                        <li>
                            <a href="home" class="  d-flex align-items-center">
                                <i class="ri-home-line"></i>
                            </a>
                        </li>
                        <li class="nav-item dropdown">
                            <a href="#" class="dropdown-toggle" id="group-drop" data-bs-toggle="dropdown"
                               aria-haspopup="true" aria-expanded="false"><i class="ri-group-line"></i></a>
                            <div class="sub-drop sub-drop-large dropdown-menu" aria-labelledby="group-drop">
                                <div class="card shadow-none m-0">
                                    <div class="card-header d-flex justify-content-between bg-primary">
                                        <div class="header-title">
                                            <h5 class="mb-0 text-white">Lời mời kết bạn</h5>
                                        </div>
                                        <small class="badge  bg-light text-dark ">${fn:length(friendRequests)}</small>
                                    </div>
                                    <div class="card-body p-0">
                                        <c:choose>
                                            <c:when test="${not empty friendRequests}">
                                                <c:forEach var="user" items="${friendRequests}">
                                                    <c:if test="${not empty user}">
                                                        <div class="iq-friend-request">
                                                            <div class="iq-sub-card iq-sub-card-big d-flex align-items-center justify-content-between">
                                                                <div class="d-flex align-items-center">
                                                                    <img class="avatar-40 rounded" src="${user.avatar}"
                                                                         alt="">
                                                                    <div class="ms-3">
                                                                        <h6 class="mb-0 ">${user.firstName} ${user.lastName}</h6>
                                                                        <p class="mb-0">${user.createdAt}</p>
                                                                    </div>
                                                                </div>
                                                                <div class="d-flex align-items-center">
                                                                    <a href="friend/accept/${user.id}?redirect=/home"
                                                                       class="me-3 btn btn-primary rounded">Đồng ý</a>
                                                                    <a href="friend/decline/${user.id}?redirect=/home"
                                                                       class="me-3 btn btn-secondary rounded">Xoá</a>
                                                                </div>
                                                            </div>
                                                        </div>
                                                    </c:if>
                                                </c:forEach>
                                            </c:when>
                                            <c:otherwise>
                                                <div class="text-sm-center mx-auto">
                                                    Hiện tại không có lời mời kết bạn nào.
                                                </div>
                                            </c:otherwise>
                                        </c:choose>

                                        <div class="text-center">
                                            <a href="#" class=" btn text-primary">Xem tất cả</a>
                                        </div>
                                    </div>
                                </div>
                            </div>
                        </li>
                        <li class="nav-item dropdown">
                            <a href="#" class="search-toggle   dropdown-toggle" id="notification-drop"
                               data-bs-toggle="dropdown">
                                <i class="ri-notification-4-line"></i>
                            </a>
                            <div class="sub-drop dropdown-menu" aria-labelledby="notification-drop">
                                <div class="card shadow-none m-0">
                                    <div class="card-header d-flex justify-content-between bg-primary">
                                        <div class="header-title bg-primary">
                                            <h5 class="mb-0 text-white">Thông báo</h5>
                                        </div>
                                        <small class="badge  bg-light text-dark">${fn:length(notifications)}</small>
                                    </div>
                                    <div class="card-body p-0">
                                        <c:choose>
                                            <c:when test="${not empty notifications}">
                                                <c:forEach var="notification" items="${notifications}">
                                                    <c:if test="${not empty notification}">
                                                        <a href="${notification.actionUrl}" class="iq-sub-card">
                                                            <div class="d-flex align-items-center">
                                                                <div class="">
                                                                    <img class="avatar-40 rounded"
                                                                         src="${notification.imageUrl}" alt="">
                                                                </div>
                                                                <div class="ms-3 w-100">
                                                                    <h6 class="mb-0 ">${notification.title}</h6>
                                                                    <div class="d-flex justify-content-between align-items-center">
                                                                        <p class="mb-0">${notification.content}</p>
                                                                        <small class="float-right font-size-12">${notification.createdAt}</small>
                                                                    </div>
                                                                </div>
                                                            </div>
                                                        </a>
                                                    </c:if>
                                                </c:forEach>
                                            </c:when>
                                            <c:otherwise>
                                                <div class="text-sm-center mx-auto">
                                                    Hiện tại không có thông báo nào.
                                                </div>
                                            </c:otherwise>
                                        </c:choose>

                                    </div>
                                </div>
                            </div>
                        </li>
                        <!--
                        <li class="nav-item dropdown">
                            <a href="#" class="dropdown-toggle" id="mail-drop" data-bs-toggle="dropdown" aria-haspopup="true" aria-expanded="false">
                                <i class="ri-mail-line"></i>
                            </a>
                            <div class="sub-drop dropdown-menu" aria-labelledby="mail-drop">
                                <div class="card shadow-none m-0">
                                    <div class="card-header d-flex justify-content-between bg-primary">
                                        <div class="header-title bg-primary">
                                            <h5 class="mb-0 text-white">All Message</h5>
                                        </div>
                                        <small class="badge bg-light text-dark">4</small>
                                    </div>
                                    <div class="card-body p-0 ">
                                        <a href="#" class="iq-sub-card">
                                            <div class="d-flex  align-items-center">
                                                <div class="">
                                                    <img class="avatar-40 rounded" src="images/user/01.jpg" alt="">
                                                </div>
                                                <div class=" w-100 ms-3">
                                                    <h6 class="mb-0 ">Bni Emma Watson</h6>
                                                    <small class="float-left font-size-12">13 Jun</small>
                                                </div>
                                            </div>
                                        </a>
                                        <a href="#" class="iq-sub-card">
                                            <div class="d-flex align-items-center">
                                                <div class="">
                                                    <img class="avatar-40 rounded" src="images/user/02.jpg" alt="">
                                                </div>
                                                <div class="ms-3">
                                                    <h6 class="mb-0 ">Lorem Ipsum Watson</h6>
                                                    <small class="float-left font-size-12">20 Apr</small>
                                                </div>
                                            </div>
                                        </a>
                                        <a href="#" class="iq-sub-card">
                                            <div class="d-flex align-items-center">
                                                <div class="">
                                                    <img class="avatar-40 rounded" src="images/user/03.jpg" alt="">
                                                </div>
                                                <div class="ms-3">
                                                    <h6 class="mb-0 ">Why do we use it?</h6>
                                                    <small class="float-left font-size-12">30 Jun</small>
                                                </div>
                                            </div>
                                        </a>
                                        <a href="#" class="iq-sub-card">
                                            <div class="d-flex align-items-center">
                                                <div class="">
                                                    <img class="avatar-40 rounded" src="images/user/04.jpg" alt="">
                                                </div>
                                                <div class="ms-3">
                                                    <h6 class="mb-0 ">Variations Passages</h6>
                                                    <small class="float-left font-size-12">12 Sep</small>
                                                </div>
                                            </div>
                                        </a>
                                        <a href="#" class="iq-sub-card">
                                            <div class="d-flex align-items-center">
                                                <div class="">
                                                    <img class="avatar-40 rounded" src="images/user/05.jpg" alt="">
                                                </div>
                                                <div class="ms-3">
                                                    <h6 class="mb-0 ">Lorem Ipsum generators</h6>
                                                    <small class="float-left font-size-12">5 Dec</small>
                                                </div>
                                            </div>
                                        </a>
                                    </div>
                                </div>
                            </div>
                        </li>
                        -->
                        <li class="nav-item dropdown">
                            <a href="#" class="   d-flex align-items-center dropdown-toggle" id="drop-down-arrow"
                               data-bs-toggle="dropdown" aria-haspopup="true" aria-expanded="false">
                                <img src="${requestScope["user"]["avatar"]}" class="img-fluid rounded-circle me-3"
                                     alt="user">
                                <div class="caption">
                                    <h6 class="mb-0 line-height">${requestScope["user"]["firstName"]} ${requestScope["user"]["lastName"]}</h6>
                                </div>
                            </a>
                            <div class="sub-drop dropdown-menu caption-menu" aria-labelledby="drop-down-arrow">
                                <div class="card shadow-none m-0">
                                    <div class="card-header  bg-primary">
                                        <div class="header-title">
                                            <h5 class="mb-0 text-white">Xin
                                                chào ${requestScope["user"]["firstName"]} ${requestScope["user"]["lastName"]}</h5>
                                        </div>
                                    </div>
                                    <div class="card-body p-0 ">
                                        <a href="profile" class="iq-sub-card iq-bg-primary-hover">
                                            <div class="d-flex align-items-center">
                                                <div class="rounded card-icon bg-soft-primary">
                                                    <i class="ri-file-user-line"></i>
                                                </div>
                                                <div class="ms-3">
                                                    <h6 class="mb-0 ">Hồ sơ</h6>
                                                    <p class="mb-0 font-size-12">Xem thông tin cá nhân của bạn.</p>
                                                </div>
                                            </div>
                                        </a>
                                        <a href="profile-edit" class="iq-sub-card iq-bg-warning-hover">
                                            <div class="d-flex align-items-center">
                                                <div class="rounded card-icon bg-soft-warning">
                                                    <i class="ri-profile-line"></i>
                                                </div>
                                                <div class="ms-3">
                                                    <h6 class="mb-0 ">Chỉnh sửa hồ sơ</h6>
                                                    <p class="mb-0 font-size-12">Chỉnh sửa thông tin cá nhân của
                                                        bạn.</p>
                                                </div>
                                            </div>
                                        </a>

                                        <div class="d-inline-block w-100 text-center p-3">
                                            <a class="btn btn-danger iq-sign-btn" href="auth/sign-out" role="button">Đăng
                                                xuất<i class="ri-login-box-line ms-2"></i></a>
                                        </div>
                                    </div>
                                </div>
                            </div>
                        </li>
                    </ul>
                </div>
            </nav>
        </div>
    </div>

    <div class="right-sidebar-mini right-sidebar">
        <div class="right-sidebar-panel p-0">
            <div class="card shadow-none">
                <div class="card-body p-0">
                    <div class="media-height p-3" data-scrollbar="init">
                        <div class="d-flex align-items-center mb-4">
                            <div class="iq-profile-avatar status-online">
                                <img class="rounded-circle avatar-50" src="images/user/01.jpg" alt="">
                            </div>
                            <div class="ms-3">
                                <h6 class="mb-0">Anna Sthesia</h6>
                                <p class="mb-0">Just Now</p>
                            </div>
                        </div>
                        <div class="d-flex align-items-center mb-4">
                            <div class="iq-profile-avatar status-online">
                                <img class="rounded-circle avatar-50" src="images/user/02.jpg" alt="">
                            </div>
                            <div class="ms-3">
                                <h6 class="mb-0">Paul Molive</h6>
                                <p class="mb-0">Admin</p>
                            </div>
                        </div>
                        <div class="d-flex align-items-center mb-4">
                            <div class="iq-profile-avatar status-online">
                                <img class="rounded-circle avatar-50" src="images/user/03.jpg" alt="">
                            </div>
                            <div class="ms-3">
                                <h6 class="mb-0">Anna Mull</h6>
                                <p class="mb-0">Admin</p>
                            </div>
                        </div>
                        <div class="d-flex align-items-center mb-4">
                            <div class="iq-profile-avatar status-online">
                                <img class="rounded-circle avatar-50" src="images/user/04.jpg" alt="">
                            </div>
                            <div class="ms-3">
                                <h6 class="mb-0">Paige Turner</h6>
                                <p class="mb-0">Admin</p>
                            </div>
                        </div>
                        <div class="d-flex align-items-center mb-4">
                            <div class="iq-profile-avatar status-online">
                                <img class="rounded-circle avatar-50" src="images/user/11.jpg" alt="">
                            </div>
                            <div class="ms-3">
                                <h6 class="mb-0">Bob Frapples</h6>
                                <p class="mb-0">Admin</p>
                            </div>
                        </div>
                        <div class="d-flex align-items-center mb-4">
                            <div class="iq-profile-avatar status-online">
                                <img class="rounded-circle avatar-50" src="images/user/02.jpg" alt="">
                            </div>
                            <div class="ms-3">
                                <h6 class="mb-0">Barb Ackue</h6>
                                <p class="mb-0">Admin</p>
                            </div>
                        </div>
                        <div class="d-flex align-items-center mb-4">
                            <div class="iq-profile-avatar status-online">
                                <img class="rounded-circle avatar-50" src="images/user/03.jpg" alt="">
                            </div>
                            <div class="ms-3">
                                <h6 class="mb-0">Greta Life</h6>
                                <p class="mb-0">Admin</p>
                            </div>
                        </div>
                        <div class="d-flex align-items-center mb-4">
                            <div class="iq-profile-avatar status-away">
                                <img class="rounded-circle avatar-50" src="images/user/12.jpg" alt="">
                            </div>
                            <div class="ms-3">
                                <h6 class="mb-0">Ira Membrit</h6>
                                <p class="mb-0">Admin</p>
                            </div>
                        </div>
                        <div class="d-flex align-items-center mb-4">
                            <div class="iq-profile-avatar status-away">
                                <img class="rounded-circle avatar-50" src="images/user/01.jpg" alt="">
                            </div>
                            <div class="ms-3">
                                <h6 class="mb-0">Pete Sariya</h6>
                                <p class="mb-0">Admin</p>
                            </div>
                        </div>
                        <div class="d-flex align-items-center">
                            <div class="iq-profile-avatar">
                                <img class="rounded-circle avatar-50" src="images/user/02.jpg" alt="">
                            </div>
                            <div class="ms-3">
                                <h6 class="mb-0">Monty Carlo</h6>
                                <p class="mb-0">Admin</p>
                            </div>
                        </div>
                    </div>
                    <div class="right-sidebar-toggle bg-primary text-white mt-3">
                        <i class="ri-arrow-left-line side-left-icon"></i>
                        <i class="ri-arrow-right-line side-right-icon"><span
                                class="ms-3 d-inline-block">Close Menu</span></i>
                    </div>
                </div>
            </div>
        </div>
    </div>

    <div id="content-page" class="content-page">
        <div class="container">
            <div class="row">
                <div class="col-lg-8 row m-0 p-0">
                    <div class="col-sm-12">
                        <div id="post-modal-data" class="card card-block card-stretch card-height">
                            <div class="card-header d-flex justify-content-between">
                                <div class="header-title">
                                    <h4 class="card-title">Tạo bài đăng mới</h4>
                                </div>
                            </div>
                            <div class="card-body">
                                <div class="d-flex align-items-center">
                                    <div class="user-img">
                                        <img src="${requestScope["user"]["avatar"]}" alt="userimg" class="avatar-60 rounded-circle">
                                    </div>
                                    <form class="post-text ms-3 w-100 " action="post/create">
                                        <input id="postInput" type="text" class="form-control rounded"
                                               placeholder="Bạn đang nghĩ gì..." style="border:none;">
                                    </form>
                                </div>
                                <hr>
                                <ul class=" post-opt-block d-flex list-inline m-0 p-0 flex-wrap">
                                    <li class="me-3 mb-md-0 mb-2">
                                        <a href="post/create" class="btn btn-soft-primary">
                                            <img src="images/small/07.png" alt="icon" class="img-fluid me-2"> Ảnh/Video
                                        </a>
                                    </li>
                                </ul>
                            </div>
                        </div>
                    </div>
                    <c:choose>
                        <c:when test="${not empty posts}">
                            <c:forEach var="post" items="${posts}">
                                <c:if test="${not empty post}">
                                    <div class="col-sm-12">
                                        <div class="card card-block card-stretch card-height">
                                            <div class="card-body">
                                                <div class="user-post-data">
                                                    <div class="d-flex justify-content-between">
                                                        <div class="me-3">
                                                            <img class="rounded-circle img-fluid"
                                                                 src=${post.user.avatar} alt="">
                                                        </div>
                                                        <div class="w-100">
                                                            <div class="d-flex justify-content-between">
                                                                <div class="">
                                                                    <h5 class="mb-0 d-inline-block">
                                                                        <a class="text-black-50"
                                                                           href="profile/${post.user.id}">${post.user.firstName} ${post.user.lastName}</a>
                                                                    </h5>
                                                                    <span class="mb-0 d-inline-block"></span>
                                                                    <p class="mb-0 text-primary">${post.createdAt}</p>
                                                                </div>
                                                                <div class="card-post-toolbar">
                                                                </div>
                                                            </div>
                                                        </div>
                                                    </div>
                                                </div>
                                                <div class="mt-3">
                                                    <p>${post.content}</p>
                                                </div>
                                                <div class="user-post">
                                                    <!--
                                                    <div class="d-grid grid-rows-2 grid-flow-col gap-3">
                                                        <div class="row-span-2 row-span-md-1">
                                                            <img src="images/page-img/p2.jpg" alt="post-image" class="img-fluid rounded w-100">
                                                        </div>
                                                        <div class="row-span-1">
                                                            <img src="images/page-img/p1.jpg" alt="post-image" class="img-fluid rounded w-100">
                                                        </div>
                                                        <div class="row-span-1 ">
                                                            <img src="images/page-img/p3.jpg" alt="post-image" class="img-fluid rounded w-100">
                                                        </div>
                                                    </div>
                                                    -->
                                                </div>
                                                <div class="comment-area mt-3">
                                                    <div class="d-flex justify-content-between align-items-center flex-wrap">
                                                        <div class="like-block position-relative d-flex align-items-center">
                                                            <div class="d-flex align-items-center">
                                                                <div class="like-data">
                                                                    <c:choose>
                                                                        <c:when test="${not empty post.likes}">
                                                                            <c:forEach var="like" items="${post.likes}">
                                                                                <c:if test="${like.user.id eq requestScope['user']['id']}">
                                                                                    <div class="like-button">
                                                                                        <a href="post/${post.id}/unlike?redirect=/home">
                                                                                            <button type="button"
                                                                                                    class="btn btn-link text-primary">
                                                                                                <i class="far fa-thumbs-up"></i>
                                                                                            </button>
                                                                                        </a>
                                                                                    </div>
                                                                                </c:if>
                                                                            </c:forEach>
                                                                        </c:when>
                                                                        <c:otherwise>
                                                                            <div class="like-button">
                                                                                <a href="post/${post.id}/like?redirect=/home">
                                                                                    <button type="button"
                                                                                            class="btn btn-link text-secondary">
                                                                                        <i class="far fa-thumbs-up"></i>
                                                                                    </button>
                                                                                </a>
                                                                            </div>
                                                                        </c:otherwise>
                                                                    </c:choose>
                                                                </div>
                                                                <div class="total-like-block ms-1 me-3">
                                                                    <div class="dropdown">
                                                                    <span class="dropdown-toggle"
                                                                          data-bs-toggle="dropdown" aria-haspopup="true"
                                                                          aria-expanded="false" role="button">
                                                                    ${fn:length(post.likes)} lượt thích
                                                                    </span>
                                                                        <c:if test="${not empty post.likes}">
                                                                            <div class="dropdown-menu">
                                                                                <c:forEach var="like"
                                                                                           items="${post.likes}">
                                                                                    <c:if test="${not empty like}">
                                                                                        <a class="dropdown-item"
                                                                                           href="profile/${like.user.id}">${like.user.firstName} ${like.user.lastName}</a>
                                                                                    </c:if>
                                                                                </c:forEach>
                                                                            </div>
                                                                        </c:if>
                                                                    </div>
                                                                </div>
                                                            </div>
                                                            <div class="total-comment-block">
                                                                <div class="dropdown">
                                                                <span class="dropdown-toggle" data-bs-toggle="dropdown"
                                                                      aria-haspopup="true" aria-expanded="false"
                                                                      role="button">
                                                                        ${fn:length(post.comments)} lượt bình luận
                                                                </span>
                                                                </div>
                                                            </div>
                                                        </div>
                                                        <div class="share-block d-flex align-items-center feather-icon mt-2 mt-md-0">
                                                            <a href="javascript:void();" data-bs-toggle="offcanvas"
                                                               data-bs-target="#share-btn" aria-controls="share-btn"><i
                                                                    class="ri-share-line"></i>
                                                                <span class="ms-1">Chia sẻ</span></a>
                                                        </div>
                                                    </div>
                                                    <hr>
                                                    <ul class="post-comments list-inline p-0 m-0">
                                                        <c:forEach var="comment" items="${post.comments}">
                                                            <c:if test="${not empty comment}">
                                                                <li class="mb-2">
                                                                    <div class="d-flex">
                                                                        <div class="user-img">
                                                                            <img src="${comment.user.avatar}"
                                                                                 alt="userimg"
                                                                                 class="avatar-35 rounded-circle img-fluid">
                                                                        </div>
                                                                        <div class="comment-data-block ms-3">
                                                                            <div class="d-flex gap-md-1">
                                                                                <div class="fw-bold">${comment.user.firstName} ${comment.user.lastName}</div>
                                                                                <div class="d-flex flex-wrap align-items-center comment-activity fs-6">
                                                                                    <small>${comment.createdAt}</small>
                                                                                </div>
                                                                            </div>
                                                                            <p class="mb-0">${comment.content}</p>
                                                                        </div>
                                                                    </div>
                                                                </li>
                                                            </c:if>
                                                        </c:forEach>
                                                    </ul>
                                                    <form class="comment-text d-flex align-items-center mt-3">
                                                        <input id="commentInput" type="text"
                                                               class="form-control rounded"
                                                               placeholder="Enter Your Comment">
                                                        <!--
                                                        <div class="comment-attagement d-flex">
                                                            <a href="javascript:void();"><i class="ri-link me-3"></i></a>
                                                            <a href="javascript:void();"><i class="ri-user-smile-line me-3"></i></a>
                                                            <a href="javascript:void();"><i class="ri-camera-line me-3"></i></a>
                                                        </div>
                                                        -->
                                                    </form>
                                                </div>
                                            </div>
                                        </div>
                                    </div>
                                </c:if>
                            </c:forEach>
                        </c:when>
                        <c:otherwise>
                            <div class="text-sm-center mx-auto">
                                Bảng tin của bạn hiện tại không có bài đăng nào.
                            </div>
                        </c:otherwise>
                    </c:choose>
                </div>
                <div class="col-lg-4">
                    <div class="card">
                        <div class="card-header d-flex justify-content-between">
                            <div class="header-title">
                                <h4 class="card-title">Stories</h4>
                            </div>
                        </div>
                        <div class="card-body">
                            <ul class="media-story list-inline m-0 p-0">
                                <li class="d-flex mb-3 align-items-center">
                                    <i class="ri-add-line"></i>
                                    <div class="stories-data ms-3">
                                        <h5>Creat Your Story</h5>
                                        <p class="mb-0">time to story</p>
                                    </div>
                                </li>
                                <li class="d-flex mb-3 align-items-center active">
                                    <img src="images/page-img/s2.jpg" alt="story-img" class="rounded-circle img-fluid">
                                    <div class="stories-data ms-3">
                                        <h5>Anna Mull</h5>
                                        <p class="mb-0">1 hour ago</p>
                                    </div>
                                </li>
                                <li class="d-flex mb-3 align-items-center">
                                    <img src="images/page-img/s3.jpg" alt="story-img" class="rounded-circle img-fluid">
                                    <div class="stories-data ms-3">
                                        <h5>Ira Membrit</h5>
                                        <p class="mb-0">4 hour ago</p>
                                    </div>
                                </li>
                                <li class="d-flex align-items-center">
                                    <img src="images/page-img/s1.jpg" alt="story-img" class="rounded-circle img-fluid">
                                    <div class="stories-data ms-3">
                                        <h5>Bob Frapples</h5>
                                        <p class="mb-0">9 hour ago</p>
                                    </div>
                                </li>
                            </ul>
                            <a href="#" class="btn btn-primary d-block mt-3">See All</a>
                        </div>
                    </div>
                    <div class="card">
                        <div class="card-header d-flex justify-content-between">
                            <div class="header-title">
                                <h4 class="card-title">Events</h4>
                            </div>
                            <div class="card-header-toolbar d-flex align-items-center">
                                <div class="dropdown">
                                    <div class="dropdown-toggle" id="dropdownMenuButton" data-bs-toggle="dropdown"
                                         aria-expanded="false" role="button">
                                        <i class="ri-more-fill h4"></i>
                                    </div>
                                    <div class="dropdown-menu dropdown-menu-right" aria-labelledby="dropdownMenuButton"
                                         style="">
                                        <a class="dropdown-item" href="#"><i class="ri-eye-fill me-2"></i>View</a>
                                        <a class="dropdown-item" href="#"><i class="ri-delete-bin-6-fill me-2"></i>Delete</a>
                                        <a class="dropdown-item" href="#"><i class="ri-pencil-fill me-2"></i>Edit</a>
                                        <a class="dropdown-item" href="#"><i class="ri-printer-fill me-2"></i>Print</a>
                                        <a class="dropdown-item" href="#"><i class="ri-file-download-fill me-2"></i>Download</a>
                                    </div>
                                </div>
                            </div>
                        </div>
                        <div class="card-body">
                            <ul class="media-story list-inline m-0 p-0">
                                <li class="d-flex mb-4 align-items-center ">
                                    <img src="images/page-img/s4.jpg" alt="story-img" class="rounded-circle img-fluid">
                                    <div class="stories-data ms-3">
                                        <h5>Web Workshop</h5>
                                        <p class="mb-0">1 hour ago</p>
                                    </div>
                                </li>
                                <li class="d-flex align-items-center">
                                    <img src="images/page-img/s5.jpg" alt="story-img" class="rounded-circle img-fluid">
                                    <div class="stories-data ms-3">
                                        <h5>Fun Events and Festivals</h5>
                                        <p class="mb-0">1 hour ago</p>
                                    </div>
                                </li>
                            </ul>
                        </div>
                    </div>
                    <div class="card">
                        <div class="card-header d-flex justify-content-between">
                            <div class="header-title">
                                <h4 class="card-title">Upcoming Birthday</h4>
                            </div>
                        </div>
                        <div class="card-body">
                            <ul class="media-story list-inline m-0 p-0">
                                <li class="d-flex mb-4 align-items-center">
                                    <img src="images/user/01.jpg" alt="story-img" class="rounded-circle img-fluid">
                                    <div class="stories-data ms-3">
                                        <h5>Anna Sthesia</h5>
                                        <p class="mb-0">Today</p>
                                    </div>
                                </li>
                                <li class="d-flex align-items-center">
                                    <img src="images/user/02.jpg" alt="story-img" class="rounded-circle img-fluid">
                                    <div class="stories-data ms-3">
                                        <h5>Paul Molive</h5>
                                        <p class="mb-0">Tomorrow</p>
                                    </div>
                                </li>
                            </ul>
                        </div>
                    </div>
                    <div class="card">
                        <div class="card-header d-flex justify-content-between">
                            <div class="header-title">
                                <h4 class="card-title">Suggested Pages</h4>
                            </div>
                            <div class="card-header-toolbar d-flex align-items-center">
                                <div class="dropdown">
                                    <div class="dropdown-toggle" id="dropdownMenuButton01" data-bs-toggle="dropdown"
                                         aria-expanded="false" role="button">
                                        <i class="ri-more-fill h4"></i>
                                    </div>
                                    <div class="dropdown-menu dropdown-menu-right"
                                         aria-labelledby="dropdownMenuButton01">
                                        <a class="dropdown-item" href="#"><i class="ri-eye-fill me-2"></i>View</a>
                                        <a class="dropdown-item" href="#"><i class="ri-delete-bin-6-fill me-2"></i>Delete</a>
                                        <a class="dropdown-item" href="#"><i class="ri-pencil-fill me-2"></i>Edit</a>
                                        <a class="dropdown-item" href="#"><i class="ri-printer-fill me-2"></i>Print</a>
                                        <a class="dropdown-item" href="#"><i class="ri-file-download-fill me-2"></i>Download</a>
                                    </div>
                                </div>
                            </div>
                        </div>
                        <div class="card-body">
                            <ul class="suggested-page-story m-0 p-0 list-inline">
                                <li class="mb-3">
                                    <div class="d-flex align-items-center mb-3">
                                        <img src="images/page-img/42.png" alt="story-img"
                                             class="rounded-circle img-fluid avatar-50">
                                        <div class="stories-data ms-3">
                                            <h5>Iqonic Studio</h5>
                                            <p class="mb-0">Lorem Ipsum</p>
                                        </div>
                                    </div>
                                    <img src="images/small/img-1.jpg" class="img-fluid rounded" alt="Responsive image">
                                    <div class="mt-3"><a href="#" class="btn d-block"><i
                                            class="ri-thumb-up-line me-2"></i> Like Page</a></div>
                                </li>
                                <li class="">
                                    <div class="d-flex align-items-center mb-3">
                                        <img src="images/page-img/42.png" alt="story-img"
                                             class="rounded-circle img-fluid avatar-50">
                                        <div class="stories-data ms-3">
                                            <h5>Cakes & Bakes </h5>
                                            <p class="mb-0">Lorem Ipsum</p>
                                        </div>
                                    </div>
                                    <img src="images/small/img-2.jpg" class="img-fluid rounded" alt="Responsive image">
                                    <div class="mt-3"><a href="#" class="btn d-block"><i
                                            class="ri-thumb-up-line me-2"></i> Like Page</a></div>
                                </li>
                            </ul>
                        </div>
                    </div>
                </div>
            </div>
        </div>
    </div>
</div>
<!-- Wrapper End-->
<footer class="iq-footer bg-white">
    <div class="container-fluid">
        <div class="row">
            <div class="col-lg-6">
                <ul class="list-inline mb-0">
                    <li class="list-inline-item"><a href="privacy-policy">Privacy Policy</a></li>
                    <li class="list-inline-item"><a href="terms-of-service">Terms of Use</a></li>
                </ul>
            </div>
            <div class="col-lg-6 d-flex justify-content-end gap-md-1">
                Copyright 2024 <a href="#"> SocialX </a> All Rights Reserved.
            </div>
        </div>
    </div>
</footer>    <!-- Backend Bundle JavaScript -->
<script src="scripts/libs.min.js"></script>
<!-- slider JavaScript -->
<script src="scripts/slider.js"></script>
<!-- masonry JavaScript -->
<script src="scripts/masonry.pkgd.min.js"></script>
<!-- SweetAlert JavaScript -->
<script src="scripts/enchanter.js"></script>
<!-- SweetAlert JavaScript -->
<script src="scripts/sweetalert.js"></script>
<!-- app JavaScript -->
<script src="scripts/charts/weather-chart.js"></script>
<script src="scripts/app.js"></script>
<script src="vendor/vanillajs-datepicker/dist/scripts/datepicker.min.js"></script>
<script src="scripts/lottie.js"></script>
<script>
    document.getElementById("postInput").addEventListener("click", function () {
        window.location.href = "post/create";
    });
</script>

<!-- offcanvas start -->

<div class="offcanvas offcanvas-bottom share-offcanvas" tabindex="-1" id="share-btn" aria-labelledby="shareBottomLabel">
    <div class="offcanvas-header">
        <h5 class="offcanvas-title" id="shareBottomLabel">Share</h5>
        <button type="button" class="btn-close text-reset" data-bs-dismiss="offcanvas" aria-label="Close"></button>
    </div>
    <div class="offcanvas-body small">
        <div class="d-flex flex-wrap align-items-center">
            <div class="text-center me-3 mb-3">
                <img src="images/icon/08.png" class="img-fluid rounded mb-2" alt="">
                <h6>Facebook</h6>
            </div>
            <div class="text-center me-3 mb-3">
                <img src="images/icon/09.png" class="img-fluid rounded mb-2" alt="">
                <h6>Twitter</h6>
            </div>
            <div class="text-center me-3 mb-3">
                <img src="images/icon/10.png" class="img-fluid rounded mb-2" alt="">
                <h6>Instagram</h6>
            </div>
            <div class="text-center me-3 mb-3">
                <img src="images/icon/11.png" class="img-fluid rounded mb-2" alt="">
                <h6>Google Plus</h6>
            </div>
            <div class="text-center me-3 mb-3">
                <img src="images/icon/13.png" class="img-fluid rounded mb-2" alt="">
                <h6>In</h6>
            </div>
            <div class="text-center me-3 mb-3">
                <img src="images/icon/12.png" class="img-fluid rounded mb-2" alt="">
                <h6>YouTube</h6>
            </div>
        </div>
    </div>
</div>
</body>
</html>
