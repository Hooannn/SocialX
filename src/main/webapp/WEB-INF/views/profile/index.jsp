<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>

<!doctype html>
<html lang="en">
<head>
    <base href="${pageContext.request.contextPath}/"/>
    <meta charset="utf-8">
    <meta name="viewport" content="width=device-width, initial-scale=1, shrink-to-fit=no">
    <title>SocialX | Trang cá nhân</title>

    <link rel="shortcut icon" href="images/favicon.ico"/>
    <link rel="stylesheet" href="css/libs.min.css">
    <link rel="stylesheet" href="css/global.css">
    <link rel="stylesheet" href="css/socialv.css?v=4.0.0">
    <link rel="stylesheet" href="css/overwrite/profile-page.css">
    <link rel="stylesheet" href="vendor/@fortawesome/fontawesome-free/css/all.min.css">
    <link rel="stylesheet" href="vendor/remixicon/fonts/remixicon.css">
    <link rel="stylesheet" href="vendor/vanillajs-datepicker/dist/css/datepicker.min.css">
    <link rel="stylesheet" href="vendor/font-awesome-line-awesome/css/all.min.css">
    <link rel="stylesheet" href="vendor/line-awesome/dist/line-awesome/css/line-awesome.min.css">
    <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/toastr.js/latest/toastr.min.css">

</head>
<body class="  ">
<!-- loader Start -->
<div id="loading">
    <div id="loading-center"></div>
</div>
<!-- loader END -->
<!-- Wrapper Start -->
<div class="wrapper">
    <div class="iq-sidebar sidebar-default ">
        <div id="sidebar-scrollbar">
            <nav class="iq-sidebar-menu">
                <ul id="iq-sidebar-toggle" class="iq-menu">
                    <li class="">
                        <a href="home" class=" ">
                            <i class="las la-newspaper"></i><span>Bảng tin</span>
                        </a>
                    </li>
                    <li class="${isCurrentUser ? "active": ""}">
                        <a href="profile" class=" ">
                            <i class="las la-user"></i><span>Trang cá nhân</span>
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
                <%-- App logo --%>
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

                <%-- Search box --%>
                <div class="iq-search-bar device-search">
                    <form action="explore" method="get" class="searchbox">
                        <button class="bg-transparent border-0 search-link d-flex align-items-center justify-content-center"
                                style="width: 25px; height: 25px; top: 50%; transform: translateY(-50%);"
                                href="#">
                            <i class="ri-search-line"></i>
                        </button>
                        <input spellcheck="false" name="query" type="text" class="text search-input"
                               placeholder="Tìm kiếm...">
                    </form>
                </div>

                <%-- Responsive menu burger--%>
                <button class="navbar-toggler" type="button" data-bs-toggle="collapse"
                        data-bs-target="#navbarSupportedContent" aria-controls="navbarSupportedContent"
                        aria-label="Toggle navigation">
                    <i class="ri-menu-3-line"></i>
                </button>

                <%-- Nav buttons and drop down menus --%>
                <div class="collapse navbar-collapse" id="navbarSupportedContent">
                    <ul class="navbar-nav ms-auto navbar-list">
                        <li>
                            <a href="home" class="d-flex align-items-center">
                                <i class="ri-home-line"></i>
                            </a>
                        </li>

                        <%-- Friend requests dropdown --%>
                        <li class="nav-item dropdown">
                            <c:if test="${not empty friendRequests}">
                                <div class="position-absolute translate-middle text-white bg-danger rounded-circle text-center"
                                     style="top: 60%; left: 20%; width: 20px; height: 20px; line-height: normal !important;">
                                    <small>${fn:length(friendRequests)}</small>
                                </div>
                            </c:if>
                            <a href="#" class="dropdown-toggle" id="group-drop" data-bs-toggle="dropdown"
                               aria-haspopup="true" aria-expanded="false">
                                <i class="ri-group-line"></i>
                            </a>
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
                                                                <a href="profile/${user.id}">
                                                                    <div class="d-flex align-items-center">
                                                                        <img class="avatar-40 rounded"
                                                                             src="${user.avatar}"
                                                                             alt="">
                                                                        <div class="ms-3">
                                                                            <h6 class="mb-0 ">${user.firstName} ${user.lastName}</h6>
                                                                            <p class="mb-0 created-at">${user.createdAt}</p>
                                                                        </div>
                                                                    </div>
                                                                </a>
                                                                <div class="d-flex align-items-center">
                                                                    <a href="friend/accept/${user.id}?redirect=/profile/${targetUser.id}"
                                                                       class="me-3 btn btn-primary rounded">Đồng ý</a>
                                                                    <a href="friend/decline/${user.id}?redirect=/profile/${targetUser.id}"
                                                                       class="btn btn-secondary rounded">Xoá</a>
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
                                    </div>
                                </div>
                            </div>
                        </li>

                        <%-- Notifications dropdown --%>
                        <li class="nav-item dropdown">
                            <c:if test="${unreadNotifications > 0}">
                                <div class="position-absolute translate-middle text-white bg-danger rounded-circle text-center"
                                     style="top: 60%; left: 20%; width: 20px; height: 20px; line-height: normal !important;">
                                    <small>${unreadNotifications}</small>
                                </div>
                            </c:if>
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
                                        <small class="badge  bg-light text-dark">${unreadNotifications}</small>
                                    </div>
                                    <div class="card-body p-0">
                                        <c:choose>
                                            <c:when test="${not empty notifications}">
                                                <c:forEach var="notification" items="${notifications}">
                                                    <c:if test="${not empty notification}">
                                                        <a href="notification/${notification.id}/read"
                                                           class="iq-sub-card">
                                                            <div class="d-flex align-items-center gap-md-1">
                                                                <div class="">
                                                                    <img class="avatar-40 rounded"
                                                                         src="${notification.imageUrl}" alt="">
                                                                </div>
                                                                <div class="ms-3 w-100">
                                                                    <h6 class="mb-0 ">${notification.title}</h6>
                                                                    <div class="d-flex flex-column">
                                                                        <p class="mb-0">${notification.content}</p>
                                                                        <small class="float-right font-size-12 created-at">${notification.createdAt}</small>
                                                                    </div>
                                                                </div>
                                                                <c:if test="${!notification.status}">
                                                                    <div class="rounded-circle bg-danger"
                                                                         style="aspect-ratio: 1/1; width: 10px"
                                                                    ></div>
                                                                </c:if>
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

                        <%-- Peronal navigation dropdown --%>
                        <li class="nav-item dropdown">
                            <a href="#" class="d-flex align-items-center dropdown-toggle" id="drop-down-arrow"
                               data-bs-toggle="dropdown" aria-haspopup="true" aria-expanded="false">
                                <img src="${requestScope["user"]["avatar"]}" class="img-fluid rounded-circle me-1"
                                     alt="user">
                                <div class="caption">
                                    <h6 class="mb-0 line-height">${requestScope["user"]["lastName"]} ${requestScope["user"]["firstName"]}</h6>
                                </div>
                            </a>
                            <div class="sub-drop dropdown-menu caption-menu" aria-labelledby="drop-down-arrow">
                                <div class="card shadow-none m-0">
                                    <div class="card-header  bg-primary">
                                        <div class="header-title">
                                            <h5 class="mb-0 text-white">
                                                Xin
                                                chào ${requestScope["user"]["lastName"]} ${requestScope["user"]["firstName"]}
                                            </h5>
                                        </div>
                                    </div>
                                    <div class="card-body p-0 ">
                                        <a href="profile" class="iq-sub-card iq-bg-primary-hover">
                                            <div class="d-flex align-items-center">
                                                <div class="rounded card-icon bg-soft-primary">
                                                    <i class="ri-file-user-line"></i>
                                                </div>
                                                <div class="ms-3">
                                                    <h6 class="mb-0 ">Trang cá nhân</h6>
                                                    <p class="mb-0 font-size-12">Xem thông tin cá nhân của bạn.</p>
                                                </div>
                                            </div>
                                        </a>
                                        <a href="profile/edit" class="iq-sub-card iq-bg-warning-hover">
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
                                            <a class="btn btn-danger iq-sign-btn" href="auth/sign-out" role="button">
                                                Đăng xuất<i class="ri-login-box-line ms-2"></i>
                                            </a>
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

    <div id="content-page" class="content-page">
        <div class="container">
            <div class="row">
                <%-- Profile background and tabs --%>
                <div class="col-sm-12">
                    <div class="card">
                        <div class="card-body profile-page p-0">
                            <div class="profile-header">
                                <div class="position-relative">
                                    <img src="${targetUser.coverImage}" alt="profile-bg" class="rounded"
                                         style="max-height: 250px; width: 100%; object-fit: cover">
                                    <c:if test="${isCurrentUser == true}">
                                        <ul class="header-nav list-inline d-flex flex-wrap justify-end p-0 m-0 z-1">
                                            <li><a href="profile/edit"><i class="ri-pencil-line"></i></a></li>
                                        </ul>
                                    </c:if>
                                </div>
                                <div class="user-detail text-center mb-3">
                                    <div class="profile-img">
                                        <img src="${targetUser.avatar}" alt="profile-img" class="avatar-130 img-fluid"/>
                                    </div>
                                    <div class="profile-detail">
                                        <h3 class="">${targetUser.fullName}</h3>
                                    </div>
                                </div>
                                <div class="profile-info p-3 d-flex align-items-center justify-content-between position-relative">
                                    <div class="add-friend-btn-wrapper">
                                        <c:if test="${isCurrentUser != true}">
                                            <c:choose>
                                                <c:when test="${friendStatus == 'NOT_FRIENDS'}">
                                                    <a href="friend/send-request/${targetUser.id}?redirect=/profile/${targetUser.id}">
                                                        <button class="btn btn-primary add-friend-btn">Kết bạn</button>
                                                    </a>
                                                </c:when>
                                                <c:when test="${friendStatus == 'ARE_FRIENDS'}">
                                                    <a href="friend/unfriend/${targetUser.id}?redirect=/profile/${targetUser.id}">
                                                        <button class="btn add-friend-btn danger">Hủy kết bạn
                                                        </button>
                                                    </a>
                                                </c:when>
                                                <c:when test="${friendStatus == 'PENDING_SENT_REQUEST'}">
                                                    <a href="friend/cancel-request/${targetUser.id}?redirect=/profile/${targetUser.id}">
                                                        <button class="btn add-friend-btn danger">Hủy yêu cầu
                                                        </button>
                                                    </a>
                                                </c:when>
                                                <c:otherwise>
                                                    <a href="friend/accept/${targetUser.id}?redirect=/profile/${targetUser.id}">
                                                        <button class="btn btn-primary add-friend-btn">Đồng ý</button>
                                                    </a>
                                                </c:otherwise>
                                            </c:choose>
                                        </c:if>
                                    </div>
                                    <div class="social-info">
                                        <ul class="social-data-block d-flex align-items-center justify-content-between list-inline p-0 m-0">
                                            <li class="text-center ps-3">
                                                <h6>Bài viết</h6>
                                                <p class="mb-0">${not empty posts ? fn:length(posts): 0}</p>
                                            </li>
                                            <li class="text-center ps-3">
                                                <h6>Bạn bè</h6>
                                                <p class="mb-0">${not empty friends ? fn:length(friends): 0}</p>
                                            </li>
                                            <li class="text-center ps-3">
                                                <h6>Ảnh</h6>
                                                <p class="mb-0">
                                                    <c:set var="imageCounter" value="0"/>
                                                    <c:if test="${not empty posts}">
                                                        <c:forEach var="post" items="${posts}">
                                                            <c:if test="${not empty post.files}">
                                                                <c:forEach var="file" items="${post.files}">
                                                                    <c:if test="${not fn:contains(file.mimeType, 'video')}">
                                                                        <c:set var="imageCounter"
                                                                               value="${imageCounter + 1}"/>
                                                                    </c:if>
                                                                </c:forEach>
                                                            </c:if>
                                                        </c:forEach>
                                                    </c:if>
                                                    ${imageCounter}
                                                </p>
                                            </li>
                                        </ul>
                                    </div>
                                </div>
                            </div>
                        </div>
                    </div>

                    <div class="card">
                        <div class="card-body p-0">
                            <div class="user-tabing">
                                <ul class="nav nav-pills d-flex align-items-center justify-content-center profile-feed-items p-0 m-0">
                                    <li class="nav-item col-12 col-sm-3 p-0">
                                        <a class="nav-link active" href="#pills-timeline-tab" data-bs-toggle="pill"
                                           data-bs-target="#timeline" role="button">Dòng thời gian</a>
                                    </li>
                                    <li class="nav-item col-12 col-sm-3 p-0">
                                        <a class="nav-link" href="#pills-about-tab" data-bs-toggle="pill"
                                           data-bs-target="#about" role="button">Giới thiệu</a>
                                    </li>
                                    <li class="nav-item col-12 col-sm-3 p-0">
                                        <a class="nav-link" href="#pills-friends-tab" data-bs-toggle="pill"
                                           data-bs-target="#friends" role="button">Bạn bè</a>
                                    </li>
                                    <li class="nav-item col-12 col-sm-3 p-0">
                                        <a class="nav-link" href="#pills-photos-tab" data-bs-toggle="pill"
                                           data-bs-target="#photos" role="button">Ảnh và video</a>
                                    </li>
                                </ul>
                            </div>
                        </div>
                    </div>
                </div>

                <%-- Widgets --%>
                <div class="col-sm-12">
                    <div class="tab-content">
                        <%-- Timeline tab pane --%>
                        <div class="tab-pane fade show active" id="timeline" role="tabpanel">
                            <div class="card-body p-0">
                                <div class="row">
                                    <%-- Small widgets - left side --%>
                                    <div class="col-lg-4">
                                        <div class="card">
                                            <div class="card-header d-flex justify-content-between">
                                                <div class="header-title">
                                                    <h4 class="card-title">Ảnh</h4>
                                                </div>
                                            </div>
                                            <div class="card-body">
                                                <ul class="profile-img-gallary p-0 m-0 list-unstyled grid-3-cols">
                                                    <c:set var="counter" value="0"/>
                                                    <c:if test="${not empty posts}">
                                                        <c:forEach var="post" items="${posts}">
                                                            <c:if test="${not empty post.files}">
                                                                <c:forEach var="file" items="${post.files}">
                                                                    <c:if test="${counter < 9 && not fn:contains(file.mimeType, 'video')}">
                                                                        <li class="">
                                                                            <a href="${file.fileUrl}" target="_blank">
                                                                                <img src="${file.fileUrl}"
                                                                                     alt="gallary-image"
                                                                                     class="img-fluid widget-image"/>
                                                                            </a>
                                                                        </li>
                                                                        <c:set var="counter" value="${counter + 1}"/>
                                                                    </c:if>
                                                                </c:forEach>
                                                            </c:if>
                                                        </c:forEach>
                                                    </c:if>
                                                </ul>
                                            </div>
                                        </div>

                                        <div class="card">
                                            <div class="card-header d-flex justify-content-between">
                                                <div class="header-title">
                                                    <h4 class="card-title">Bạn bè</h4>
                                                </div>
                                            </div>
                                            <div class="card-body">
                                                <ul class="profile-img-gallary p-0 m-0 list-unstyled grid-3-cols">
                                                    <c:if test="${not empty friends}">
                                                        <c:forEach var="friend" items="${friends}" begin="0" end="8">
                                                            <li class="">
                                                                <a href="profile/${friend.id}">
                                                                    <img src=${friend.avatar} alt="gallary-image"
                                                                         class="img-fluid widget-image"/>
                                                                </a>
                                                                <h6 class="mt-2 text-center truncate-1">${friend.lastName} ${friend.firstName}</h6>
                                                            </li>
                                                        </c:forEach>
                                                    </c:if>
                                                </ul>
                                            </div>
                                        </div>
                                    </div>

                                    <%-- Add post widget, User posts - right side --%>
                                    <div class="col-lg-8">
                                        <%-- Add post widget for current user --%>
                                        <c:if test="${isCurrentUser}">
                                            <div id="post-modal-data" class="card">
                                                <div class="card-header d-flex justify-content-between">
                                                    <div class="header-title">
                                                        <h4 class="card-title">Tạo bài đăng mới</h4>
                                                    </div>
                                                </div>
                                                <div class="card-body">
                                                    <div class="d-flex align-items-center">
                                                        <div class="user-img">
                                                            <img src="${requestScope["user"]["avatar"]}" alt="userimg"
                                                                 class="avatar-60 rounded-circle">
                                                        </div>
                                                        <form class="post-text ms-3 w-100 " action="post/create">
                                                            <input spellcheck="false" id="postInput" type="text"
                                                                   class="form-control rounded"
                                                                   placeholder="Bạn đang nghĩ gì..."
                                                                   style="border:none;">
                                                        </form>
                                                    </div>
                                                    <hr>
                                                    <ul class=" post-opt-block d-flex list-inline m-0 p-0 flex-wrap">
                                                        <li class="me-3 mb-md-0 mb-2">
                                                            <a href="post/create" class="btn btn-soft-primary">
                                                                <img src="images/small/07.png" alt="icon"
                                                                     class="img-fluid me-2"> Ảnh/Video
                                                            </a>
                                                        </li>
                                                    </ul>
                                                </div>
                                            </div>
                                        </c:if>

                                        <%-- Posts --%>
                                        <c:choose>
                                            <c:when test="${not empty posts}">
                                                <c:forEach var="post" items="${posts}">
                                                    <c:if test="${not empty post}">
                                                        <div class="card">
                                                            <div class="card-body">
                                                                    <%-- User data, timestamp --%>
                                                                <div class="user-post-data">
                                                                    <div class="modal fade"
                                                                         id="deletePostModal_${post.id}"
                                                                         tabindex="-1"
                                                                         aria-labelledby="exampleModalLabel"
                                                                         aria-hidden="true">
                                                                        <div class="modal-dialog">
                                                                            <div class="modal-content">
                                                                                <div class="modal-header">
                                                                                    <h1 class="modal-title fs-5"
                                                                                        id="exampleModalLabel">
                                                                                        Xoá bài viết</h1>
                                                                                    <button type="button"
                                                                                            class="btn-close"
                                                                                            data-bs-dismiss="modal"
                                                                                            aria-label="Close"></button>
                                                                                </div>
                                                                                <div class="modal-body">
                                                                                    Thao tác này không thể hoàn tác. Bạn
                                                                                    có chắc chắn
                                                                                    muốn xoá bài viết này không?
                                                                                </div>
                                                                                <div class="modal-footer">
                                                                                    <button type="button" class="btn"
                                                                                            data-bs-dismiss="modal">Huỷ
                                                                                    </button>
                                                                                    <form method="post"
                                                                                          action="post/${post.id}/delete">
                                                                                        <button type="submit"
                                                                                                class="btn btn-danger">
                                                                                            Xác nhận
                                                                                        </button>
                                                                                    </form>
                                                                                </div>
                                                                            </div>
                                                                        </div>
                                                                    </div>
                                                                    <div class="d-flex justify-content-between">
                                                                        <div class="me-3">
                                                                            <img class="rounded-circle avatar-50 object-fit-cover ratio-1x1"
                                                                                 style="object-fit: cover"
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
                                                                                    <p class="mb-0 text-primary created-at">${post.createdAt}</p>
                                                                                </div>
                                                                                <c:if test="${post.user.id == user.id}">
                                                                                    <div class="card-post-toolbar">
                                                                                        <div class="dropdown">
                                                                                            <span class="dropdown-toggle"
                                                                                                  data-bs-toggle="dropdown"
                                                                                                  aria-haspopup="true"
                                                                                                  aria-expanded="false"
                                                                                                  role="button">
                                                                                                <i class="ri-more-fill"></i>
                                                                                            </span>
                                                                                            <div class="dropdown-menu m-0 p-0">
                                                                                                <a class="dropdown-item p-3"
                                                                                                   href="post/${post.id}/edit">
                                                                                                    <div class="d-flex align-items-top">
                                                                                                        <div class="h4">
                                                                                                            <i class="ri-save-line"></i>
                                                                                                        </div>
                                                                                                        <div class="data ms-2">
                                                                                                            <h6>Chỉnh
                                                                                                                sửa</h6>
                                                                                                            <p class="mb-0">
                                                                                                                Chỉnh
                                                                                                                sửa
                                                                                                                nội dung
                                                                                                                bài
                                                                                                                viết</p>
                                                                                                        </div>
                                                                                                    </div>
                                                                                                </a>
                                                                                                <a class="dropdown-item p-3"
                                                                                                   type="button"
                                                                                                   data-bs-toggle="modal"
                                                                                                   data-bs-target="#deletePostModal_${post.id}">
                                                                                                    <div class="d-flex align-items-top">
                                                                                                        <i class="ri-close-circle-line h4"></i>
                                                                                                        <div class="data ms-2">
                                                                                                            <h6>Xoá</h6>
                                                                                                            <p class="mb-0">
                                                                                                                Xoá bài
                                                                                                                viết
                                                                                                                khỏi hệ
                                                                                                                thống</p>
                                                                                                        </div>
                                                                                                    </div>
                                                                                                </a>
                                                                                            </div>
                                                                                        </div>
                                                                                    </div>
                                                                                </c:if>
                                                                            </div>
                                                                        </div>
                                                                    </div>
                                                                </div>

                                                                    <%-- Title and text content --%>
                                                                <div>
                                                                    <h5 class="my-2">${post.title}</h5>
                                                                    <textarea readonly
                                                                              class="auto-resize p-0 border-0 w-100 overflow-hidden"
                                                                              style="color: #777d74; resize: none">${post.content}</textarea>
                                                                </div>

                                                                    <%-- Images and videos --%>
                                                                <c:if test="${not empty post.files}">
                                                                    <div class="grid">
                                                                        <div class="grid-sizer"></div>
                                                                        <c:forEach var="file" items="${post.files}">
                                                                            <c:if test="${not empty file}">
                                                                                <c:choose>
                                                                                    <c:when test="${fn:contains(file.mimeType, 'video')}">
                                                                                        <div class="grid-item">
                                                                                            <div class="grid-item-content-wrapper">
                                                                                                <video controls
                                                                                                       class="rounded">
                                                                                                    <source src="${file.fileUrl}"
                                                                                                            type="video/mp4">
                                                                                                    Your browser does
                                                                                                    not
                                                                                                    support the video
                                                                                                    tag.
                                                                                                </video>
                                                                                            </div>
                                                                                        </div>
                                                                                    </c:when>
                                                                                    <c:otherwise>
                                                                                        <div class="grid-item">
                                                                                            <div class="grid-item-content-wrapper">
                                                                                                <a href="${file.fileUrl}"
                                                                                                   target="_blank">
                                                                                                    <img src="${file.fileUrl}"
                                                                                                         alt="post-image"
                                                                                                         class="rounded">
                                                                                                </a>
                                                                                            </div>
                                                                                        </div>
                                                                                    </c:otherwise>
                                                                                </c:choose>
                                                                            </c:if>
                                                                        </c:forEach>
                                                                    </div>
                                                                </c:if>

                                                                    <%-- Likes and comment box --%>
                                                                <div class="comment-area mt-3">
                                                                    <div class="d-flex justify-content-between align-items-center flex-wrap">
                                                                        <div class="like-block position-relative d-flex align-items-center">
                                                                            <div class="d-flex align-items-center">
                                                                                <div class="like-data">
                                                                                    <c:choose>
                                                                                        <c:when test="${not empty post.likes}">
                                                                                            <c:forEach var="like"
                                                                                                       items="${post.likes}">
                                                                                                <c:if test="${like.user.id eq requestScope['user']['id']}">
                                                                                                    <div class="like-button">
                                                                                                        <a href="post/${post.id}/unlike?redirect=/profile/${targetUser.id}">
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
                                                                                                <a href="post/${post.id}/like?redirect=/profile/${targetUser.id}">
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
                                                                                        <span
                                                                                                class="dropdown-toggle"
                                                                                                data-bs-toggle="dropdown"
                                                                                                aria-haspopup="true"
                                                                                                aria-expanded="false"
                                                                                                role="button"
                                                                                        >
                                                                                            ${fn:length(post.likes)} lượt thích
                                                                                        </span>
                                                                                        <c:if test="${not empty post.likes}">
                                                                                            <div class="dropdown-menu">
                                                                                                <c:forEach var="like"
                                                                                                           items="${post.likes}">
                                                                                                    <c:if test="${not empty like}">
                                                                                                        <a class="dropdown-item"
                                                                                                           href="profile/${like.user.id}">
                                                                                                                ${like.user.firstName} ${like.user.lastName}
                                                                                                        </a>
                                                                                                    </c:if>
                                                                                                </c:forEach>
                                                                                            </div>
                                                                                        </c:if>
                                                                                    </div>
                                                                                </div>
                                                                            </div>
                                                                            <div class="total-comment-block">
                                                                                <a href="post/${post.id}"
                                                                                   class="w-100 text-black-50">
                                                                                        ${fn:length(post.comments)} lượt
                                                                                    bình luận
                                                                                </a>
                                                                            </div>
                                                                        </div>
                                                                        <div class="share-block d-flex align-items-center feather-icon mt-2 mt-md-0">
                                                                            <a href="javascript:void();"
                                                                               data-bs-toggle="offcanvas"
                                                                               data-bs-target="#share-btn"
                                                                               aria-controls="share-btn">
                                                                                <i class="ri-share-line"></i>
                                                                                <span class="ms-1">Chia sẻ</span>
                                                                            </a>
                                                                        </div>
                                                                    </div>
                                                                    <hr>
                                                                    <ul class="post-comments list-inline p-0 m-0">
                                                                        <c:forEach var="comment"
                                                                                   items="${post.comments}">
                                                                            <c:if test="${not empty comment}">
                                                                                <li class="mb-2 d-flex align-items-start justify-content-between">
                                                                                    <div class="modal fade"
                                                                                         id="deleteCommentModal_${comment.id}"
                                                                                         tabindex="-1"
                                                                                         aria-labelledby="exampleModalLabel"
                                                                                         aria-hidden="true">
                                                                                        <div class="modal-dialog">
                                                                                            <div class="modal-content">
                                                                                                <div class="modal-header">
                                                                                                    <h1 class="modal-title fs-5"
                                                                                                        id="exampleModalLabel1">
                                                                                                        Xoá bình
                                                                                                        luận</h1>
                                                                                                    <button type="button"
                                                                                                            class="btn-close"
                                                                                                            data-bs-dismiss="modal"
                                                                                                            aria-label="Close"></button>
                                                                                                </div>
                                                                                                <div class="modal-body">
                                                                                                    Thao tác này không
                                                                                                    thể hoàn tác. Bạn có
                                                                                                    chắc chắn muốn xoá
                                                                                                    bình
                                                                                                    luận này không?
                                                                                                </div>
                                                                                                <div class="modal-footer">
                                                                                                    <button type="button"
                                                                                                            class="btn"
                                                                                                            data-bs-dismiss="modal">
                                                                                                        Huỷ
                                                                                                    </button>
                                                                                                    <form method="post"
                                                                                                          action="post/${post.id}/comment/${comment.id}/delete">
                                                                                                        <button type="submit"
                                                                                                                class="btn btn-danger">
                                                                                                            Xác nhận
                                                                                                        </button>
                                                                                                    </form>
                                                                                                </div>
                                                                                            </div>
                                                                                        </div>
                                                                                    </div>
                                                                                    <div class="modal fade"
                                                                                         id="editCommentModal_${comment.id}"
                                                                                         tabindex="-1"
                                                                                         aria-labelledby="exampleModalLabel"
                                                                                         aria-hidden="true">
                                                                                        <div class="modal-dialog">
                                                                                            <div class="modal-content">
                                                                                                <form action="post/${post.id}/comment/${comment.id}/edit"
                                                                                                      method="post">
                                                                                                    <div class="modal-header">
                                                                                                        <h1 class="modal-title fs-5"
                                                                                                            id="exampleModalLabel2">
                                                                                                            Chỉnh
                                                                                                            sửa
                                                                                                            bình
                                                                                                            luận</h1>
                                                                                                        <button type="reset"
                                                                                                                class="btn-close"
                                                                                                                data-bs-dismiss="modal"
                                                                                                                aria-label="Close"></button>
                                                                                                    </div>
                                                                                                    <div class="modal-body">
                                                                                                        <textarea
                                                                                                                spellcheck="false"
                                                                                                                class="form-control"
                                                                                                                name="content"
                                                                                                                rows="3">${comment.content}</textarea>
                                                                                                    </div>
                                                                                                    <div class="modal-footer">
                                                                                                        <button type="reset"
                                                                                                                class="btn"
                                                                                                                data-bs-dismiss="modal">
                                                                                                            Huỷ
                                                                                                        </button>
                                                                                                        <button type="submit"
                                                                                                                class="btn btn-primary">
                                                                                                            Xác nhận
                                                                                                        </button>
                                                                                                    </div>
                                                                                                </form>
                                                                                            </div>
                                                                                        </div>
                                                                                    </div>
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
                                                                                                    <small class="created-at">${comment.createdAt}</small>
                                                                                                </div>
                                                                                            </div>
                                                                                            <p class="mb-0">${comment.content}</p>
                                                                                        </div>
                                                                                    </div>
                                                                                    <c:if test="${comment.user.id == user.id || post.user.id == user.id}">
                                                                                        <div class="card-post-toolbar">
                                                                                            <div class="dropdown">
                                                                                                <span class="dropdown-toggle"
                                                                                                      data-bs-toggle="dropdown"
                                                                                                      aria-haspopup="true"
                                                                                                      aria-expanded="false"
                                                                                                      role="button">
                                                                                                    <i class="ri-more-fill"></i>
                                                                                                </span>
                                                                                                <div class="dropdown-menu m-0 p-0">
                                                                                                    <c:if test="${comment.user.id == user.id}">
                                                                                                        <a class="dropdown-item p-3"
                                                                                                           type="button"
                                                                                                           data-bs-toggle="modal"
                                                                                                           data-bs-target="#editCommentModal_${comment.id}">
                                                                                                            <div class="d-flex align-items-top">
                                                                                                                <div class="h4">
                                                                                                                    <i class="ri-save-line"></i>
                                                                                                                </div>
                                                                                                                <div class="data ms-2">
                                                                                                                    <h6>
                                                                                                                        Chỉnh
                                                                                                                        sửa</h6>
                                                                                                                    <p class="mb-0">
                                                                                                                        Chỉnh
                                                                                                                        sửa
                                                                                                                        nội
                                                                                                                        dung
                                                                                                                        bình
                                                                                                                        luận</p>
                                                                                                                </div>
                                                                                                            </div>
                                                                                                        </a>
                                                                                                    </c:if>
                                                                                                    <a class="dropdown-item p-3"
                                                                                                       type="button"
                                                                                                       data-bs-toggle="modal"
                                                                                                       data-bs-target="#deleteCommentModal_${comment.id}">
                                                                                                        <div class="d-flex align-items-top">
                                                                                                            <i class="ri-close-circle-line h4"></i>
                                                                                                            <div class="data ms-2">
                                                                                                                <h6>
                                                                                                                    Xoá</h6>
                                                                                                                <p class="mb-0">
                                                                                                                    Xoá
                                                                                                                    bình
                                                                                                                    luận
                                                                                                                    khỏi
                                                                                                                    hệ
                                                                                                                    thống</p>
                                                                                                            </div>
                                                                                                        </div>
                                                                                                    </a>
                                                                                                </div>
                                                                                            </div>
                                                                                        </div>
                                                                                    </c:if>
                                                                                </li>
                                                                            </c:if>
                                                                        </c:forEach>
                                                                    </ul>
                                                                    <form class="comment-text d-flex align-items-center mt-3">
                                                                        <a href="post/${post.id}" class="w-100">
                                                                            <input spellcheck="false" type="text"
                                                                                   class="form-control rounded"
                                                                                   placeholder="Bình luận về bài viết này...">
                                                                        </a>
                                                                    </form>
                                                                </div>
                                                            </div>
                                                        </div>
                                                    </c:if>
                                                </c:forEach>
                                            </c:when>
                                            <c:otherwise>
                                                <c:if test="${isCurrentUser}">
                                                    <div class="text-sm-center mx-auto">
                                                        Trang cá nhân của bạn hiện tại không có bài đăng nào.
                                                    </div>
                                                </c:if>
                                                <c:if test="${!isCurrentUser}">
                                                    <div class="text-sm-center mx-auto">
                                                        Trang cá nhân của ${targetUser.fullName} hiện tại không có bài
                                                        đăng nào.
                                                    </div>
                                                </c:if>
                                            </c:otherwise>
                                        </c:choose>
                                    </div>
                                </div>
                            </div>
                        </div>

                        <%-- About tab pane --%>
                        <div class="tab-pane fade" id="about" role="tabpanel">
                            <div class="card mh-300">
                                <div class="card-body">
                                    <div class="row">
                                        <div class="col-md-3">
                                            <ul class="nav nav-pills basic-info-items list-inline d-block p-0 m-0">
                                                <li>
                                                    <a class="nav-link active" href="#v-pills-basicinfo-tab"
                                                       data-bs-toggle="pill" data-bs-target="#v-pills-basicinfo-tab"
                                                       role="button">Thông tin cá nhân</a>
                                                </li>
                                                <li>
                                                    <a class="nav-link" href="#v-pills-details-tab"
                                                       data-bs-toggle="pill" data-bs-target="#v-pills-contact-tab"
                                                       role="button">Thông tin liên hệ</a>
                                                </li>
                                            </ul>
                                        </div>
                                        <div class="col-md-9 ps-4">
                                            <div class="tab-content">
                                                <div class="tab-pane fade active show" id="v-pills-basicinfo-tab"
                                                     role="tabpanel" aria-labelledby="v-pills-basicinfo-tab">
                                                    <h4>Thông tin cá nhân</h4>
                                                    <hr>
                                                    <div class="row">
                                                        <div class="col-3">
                                                            <h6>Họ</h6>
                                                        </div>
                                                        <div class="col-9">
                                                            <p class="mb-0">
                                                                ${targetUser.lastName}
                                                            </p>
                                                        </div>
                                                        <div class="col-3">
                                                            <h6>Tên</h6>
                                                        </div>
                                                        <div class="col-9">
                                                            <p class="mb-0">
                                                                ${targetUser.firstName}
                                                            </p>
                                                        </div>
                                                        <div class="col-3">
                                                            <h6>Ngày sinh</h6>
                                                        </div>
                                                        <div class="col-9">
                                                            <p class="mb-0">
                                                                ${not empty targetUser.dateOfBirth ? targetUser.formattedBirthday : "Chưa được cập nhật"}
                                                            </p>
                                                        </div>
                                                        <div class="col-3">
                                                            <h6>Giới tính</h6>
                                                        </div>
                                                        <div class="col-9">
                                                            <p class="mb-0">${targetUser.sex ? "Nữ": "Nam"}</p>
                                                        </div>
                                                    </div>
                                                </div>
                                                <div class="tab-pane fade" id="v-pills-contact-tab" role="tabpanel"
                                                     aria-labelledby="v-pills-details-tab">
                                                    <h4>Thông tin liên hệ</h4>
                                                    <hr>
                                                    <div class="row">
                                                        <div class="col-3">
                                                            <h6>Email</h6>
                                                        </div>
                                                        <div class="col-9">
                                                            <p class="mb-0">${targetUser.email}</p>
                                                        </div>
                                                        <div class="col-3">
                                                            <h6>Địa chỉ</h6>
                                                        </div>
                                                        <div class="col-9">
                                                            <p class="mb-0">
                                                                ${not empty targetUser.address ? targetUser.address : "Chưa được cập nhật"}
                                                            </p>
                                                        </div>
                                                        <div class="col-3">
                                                            <h6>Ngày tạo</h6>
                                                        </div>
                                                        <div class="col-9">
                                                            <p class="mb-0">
                                                                ${targetUser.formattedCreatedAt}
                                                            </p>
                                                        </div>
                                                    </div>
                                                </div>
                                            </div>
                                        </div>
                                    </div>
                                </div>
                            </div>
                        </div>

                        <%-- Friends tab pane --%>
                        <div class="tab-pane fade" id="friends" role="tabpanel">
                            <div class="card">
                                <div class="card-body">
                                    <h2>Bạn bè</h2>
                                    <div class="friend-list-tab mt-2">
                                        <ul class="nav nav-pills d-flex align-items-center justify-content-left friend-list-items p-0 mb-2">
                                            <li>
                                                <a class="nav-link active" data-bs-toggle="pill"
                                                   href="#pill-all-friends" data-bs-target="#all-feinds">Tất cả bạn bẻ
                                                    của ${isCurrentUser ? "bạn": targetUser.firstName}</a>
                                            </li>
                                        </ul>
                                        <div class="tab-content">
                                            <div class="tab-pane fade active show" id="all-friends" role="tabpanel">
                                                <div class="card-body p-0">
                                                    <div class="row">
                                                        <c:if test="${not empty friends}">
                                                            <c:forEach var="tabFriend" items="${friends}">
                                                                <div class="col-md-6 col-lg-6 mb-3">
                                                                    <div class="iq-friendlist-block">
                                                                        <div class="d-flex align-items-center justify-content-between">
                                                                            <div class="d-flex align-items-center">
                                                                                <a href="#">
                                                                                    <div class="friends-tab-avatar-wrapper">
                                                                                        <img src="${tabFriend.avatar}"
                                                                                             alt="profile-img"
                                                                                             class="img-fluid">
                                                                                    </div>
                                                                                </a>
                                                                                <div class="friend-info ms-3">
                                                                                    <h5 class="mw-180">${tabFriend.lastName} ${tabFriend.firstName}</h5>
                                                                                </div>
                                                                            </div>
                                                                            <div class="card-header-toolbar d-flex align-items-center">
                                                                                <a href="profile/${tabFriend.id}">
                                                                                    <span class="btn btn-secondary me-2"
                                                                                          aria-expanded="true"
                                                                                          role="button">
                                                                                        <i class="ri-check-line me-1 text-white"></i> Xem
                                                                                    </span>
                                                                                    <div class="dropdown-menu dropdown-menu-right"
                                                                                         aria-labelledby="dropdownMenuButton01"></div>
                                                                                </a>
                                                                            </div>
                                                                        </div>
                                                                    </div>
                                                                </div>
                                                            </c:forEach>
                                                        </c:if>
                                                    </div>
                                                </div>
                                            </div>
                                        </div>
                                    </div>
                                </div>
                            </div>
                        </div>

                        <%-- My photos tab pane --%>
                        <div class="tab-pane fade" id="photos" role="tabpanel">
                            <div class="card">
                                <div class="card-body">
                                    <h2>Ảnh và video</h2>
                                    <div class="friend-list-tab mt-2">
                                        <ul class="nav nav-pills d-flex align-items-center justify-content-left friend-list-items p-0 mb-2">
                                            <li>
                                                <a class="nav-link active" data-bs-toggle="pill"
                                                   href="#pill-photosofyou" data-bs-target="#photosofyou">Ảnh
                                                    của ${isCurrentUser ? "bạn": targetUser.firstName}</a>
                                            </li>
                                            <li>
                                                <a class="nav-link" data-bs-toggle="pill" href="#pill-your-photos"
                                                   data-bs-target="#your-photos">Video
                                                    của ${isCurrentUser ? "bạn": targetUser.firstName}</a>
                                            </li>
                                        </ul>
                                        <div class="tab-content">
                                            <div class="tab-pane fade active show" id="photosofyou" role="tabpanel">
                                                <div class="card-body p-0">
                                                    <div class="d-grid gap-2 d-grid-template-1fr-13">
                                                        <c:if test="${not empty posts}">
                                                            <c:forEach var="post" items="${posts}">
                                                                <c:if test="${not empty post.files}">
                                                                    <c:forEach var="file" items="${post.files}">
                                                                        <c:if test="${not fn:contains(file.mimeType, 'video')}">
                                                                            <div class="photos-tab-content-wrapper">
                                                                                <div class="user-images position-relative overflow-hidden photos-tab-image-wrapper">
                                                                                    <a href="${file.fileUrl}"
                                                                                       target="_blank">
                                                                                        <div class="photos-tab-image-inner-wrapper rounded overflow-hidden">
                                                                                            <img src="${file.fileUrl}"
                                                                                                 class="img-fluid rounded"
                                                                                                 alt="Responsive image">
                                                                                        </div>
                                                                                    </a>
                                                                                    <div class="image-hover-data">
                                                                                        <div class="product-elements-icon">
                                                                                            <ul class="d-flex align-items-center m-0 p-0 list-inline">
                                                                                                <li>
                                                                                                    <a href="post/${post.id}"
                                                                                                       class="pe-3 text-white"> ${fn:length(post.likes)}
                                                                                                        <i class="ri-thumb-up-line"></i>
                                                                                                    </a>
                                                                                                </li>
                                                                                                <li>
                                                                                                    <a href="post/${post.id}"
                                                                                                       class="pe-3 text-white"> ${fn:length(post.comments)}
                                                                                                        <i class="ri-chat-3-line"></i>
                                                                                                    </a>
                                                                                                </li>
                                                                                            </ul>
                                                                                        </div>
                                                                                    </div>
                                                                                    <c:if test="${isCurrentUser}">
                                                                                        <a href="post/${post.id}/edit"
                                                                                           class="image-edit-btn"
                                                                                           data-bs-toggle="tooltip"
                                                                                           data-bs-placement="top"
                                                                                           title=""
                                                                                           data-bs-original-title="Chỉnh sửa bài viết"><i
                                                                                                class="ri-edit-2-fill"></i>
                                                                                        </a>
                                                                                    </c:if>
                                                                                </div>
                                                                            </div>
                                                                        </c:if>
                                                                    </c:forEach>
                                                                </c:if>
                                                            </c:forEach>
                                                        </c:if>
                                                    </div>
                                                </div>
                                            </div>
                                            <div class="tab-pane fade" id="your-photos" role="tabpanel">
                                                <div class="card-body p-0">
                                                    <div class="d-grid gap-2 d-grid-template-1fr-13 ">
                                                        <c:if test="${not empty posts}">
                                                            <c:forEach var="post" items="${posts}">
                                                                <c:if test="${not empty post.files}">
                                                                    <c:forEach var="file" items="${post.files}">
                                                                        <c:if test="${fn:contains(file.mimeType, 'video')}">
                                                                            <div class="photos-tab-content-wrapper">
                                                                                <div class="user-images position-relative overflow-hidden photos-tab-image-wrapper">
                                                                                    <div class="photos-tab-image-inner-wrapper rounded overflow-hidden">
                                                                                        <video class="rounded">
                                                                                            <source src="${file.fileUrl}"
                                                                                                    type="video/mp4">
                                                                                            Your browser does not
                                                                                            support the video tag.
                                                                                        </video>
                                                                                    </div>
                                                                                    <div class="image-hover-data">
                                                                                        <div class="product-elements-icon">
                                                                                            <ul class="d-flex align-items-center m-0 p-0 list-inline">
                                                                                                <li>
                                                                                                    <a href="post/${post.id}"
                                                                                                       class="pe-3 text-white"> ${fn:length(post.likes)}
                                                                                                        <i class="ri-thumb-up-line"></i>
                                                                                                    </a>
                                                                                                </li>
                                                                                                <li>
                                                                                                    <a href="post/${post.id}"
                                                                                                       class="pe-3 text-white"> ${fn:length(post.comments)}
                                                                                                        <i class="ri-chat-3-line"></i>
                                                                                                    </a>
                                                                                                </li>
                                                                                            </ul>
                                                                                        </div>
                                                                                    </div>
                                                                                    <div class="photos-tab-play-btn">
                                                                                        <a href="${file.fileUrl}"
                                                                                           target="_blank">
                                                                                            <img src="images/play-button-icon.png"
                                                                                                 alt=""/>
                                                                                        </a>
                                                                                    </div>
                                                                                    <c:if test="${isCurrentUser}">
                                                                                        <a href="post/${post.id}/edit"
                                                                                           class="image-edit-btn"
                                                                                           data-bs-toggle="tooltip"
                                                                                           data-bs-placement="top"
                                                                                           title=""
                                                                                           data-bs-original-title="Chỉnh sửa bài viết"><i
                                                                                                class="ri-edit-2-fill"></i>
                                                                                        </a>
                                                                                    </c:if>
                                                                                </div>
                                                                            </div>
                                                                        </c:if>
                                                                    </c:forEach>
                                                                </c:if>
                                                            </c:forEach>
                                                        </c:if>
                                                    </div>
                                                </div>
                                            </div>
                                        </div>
                                    </div>
                                </div>
                            </div>
                        </div>
                    </div>
                </div>
            </div>
        </div>
    </div>
</div>
<!-- Wrapper End-->

<!-- Backend Bundle JavaScript -->
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
<script src="vendor/vanillajs-datepicker/dist/js/datepicker.min.js"></script>
<script src="scripts/lottie.js"></script>
<script src="https://cdn.jsdelivr.net/npm/dayjs@1/dayjs.min.js"></script>
<script src="https://cdn.jsdelivr.net/npm/dayjs@1/plugin/relativeTime.js"></script>
<script src="https://cdn.jsdelivr.net/npm/dayjs@1/locale/vi.js"></script>
<script src="scripts/dateFormat.js"></script>
<!-- Toast handle script -->
<script src="https://cdnjs.cloudflare.com/ajax/libs/toastr.js/latest/toastr.min.js"></script>
<script>
    var errorMessage = '<%= request.getAttribute("errorMessage") %>';
    var successMessage = '<%= request.getAttribute("successMessage") %>';
</script>
<script src="scripts/toastHandler.js"></script>
<!-- -->
<!-- Masonry Script -->
<script src="https://unpkg.com/masonry-layout@4/dist/masonry.pkgd.min.js"></script>
<script src="https://unpkg.com/imagesloaded@5/imagesloaded.pkgd.min.js"></script>
<script>
    var grid = document.querySelector('.grid');
    var msnry = new Masonry(grid, {
        itemSelector: '.grid-item',
        columnWidth: '.grid-sizer',
        percentPosition: true
    });
    imagesLoaded(grid).on('progress', function () {
        msnry.layout();
    });
</script>
<!-- -->
<script>
    document.getElementById("postInput").addEventListener("click", function () {
        window.location.href = "post/create";
    });
</script>
<script>
    function autoResizeTextarea(textarea) {
        textarea.style.height = 'auto';
        textarea.style.height = textarea.scrollHeight + 'px';
    }

    const textareas = document.querySelectorAll('textarea.auto-resize');

    textareas.forEach(textarea => {
        autoResizeTextarea(textarea);

        textarea.addEventListener('input', function () {
            autoResizeTextarea(this);
        });
    });
</script>
</body>
</html>
