<%--
  Created by IntelliJ IDEA.
  User: nguyenduckhaihoan
  Date: 03/04/2024
  Time: 21:16
  To change this template use File | Settings | File Templates.
--%>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib uri="http://java.sun.com/jstl/core_rt" prefix="c" %>
<%@ taglib uri="http://java.sun.com/jstl/fmt_rt" prefix="f" %>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>
<%@ taglib uri="http://www.springframework.org/tags/form" prefix="form" %>
<!doctype html>
<html lang="en">
<head>
    <base href="${pageContext.request.contextPath}/"/>
    <meta charset="utf-8">
    <meta name="viewport" content="width=device-width, initial-scale=1, shrink-to-fit=no">
    <title>SocialX | Tạo bài đăng</title>

    <link rel="shortcut icon" href="images/favicon.ico"/>
    <link rel="stylesheet" href="css/libs.min.css">
    <link rel="stylesheet" href="css/global.css">
    <link rel="stylesheet" href="css/socialv.css?v=4.0.0">
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
                            <c:if test="${not empty friendRequests}">
                                <div class="position-absolute translate-middle text-white bg-danger rounded-circle text-center"
                                     style="top: 60%; left: 20%; width: 20px; height: 20px; line-height: normal !important;">
                                    <small>${fn:length(friendRequests)}</small>
                                </div>
                            </c:if>
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
                                                                        <p class="mb-0 created-at">${user.createdAt}</p>
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

    <div class="container">
        <div class="col-sm-12 my-4">
            <div class="card card-block card-stretch card-height">
                <div class="card-body">
                    <div class="user-post-data">
                        <div class="modal fade" id="exampleModal" tabindex="-1" aria-labelledby="exampleModalLabel"
                             aria-hidden="true">
                            <div class="modal-dialog">
                                <div class="modal-content">
                                    <div class="modal-header">
                                        <h1 class="modal-title fs-5" id="exampleModalLabel">Xoá bài viết</h1>
                                        <button type="button" class="btn-close" data-bs-dismiss="modal"
                                                aria-label="Close"></button>
                                    </div>
                                    <div class="modal-body">
                                        Thao tác này không thể hoàn tác. Bạn có chắc chắn muốn xoá bài viết này không?
                                    </div>
                                    <div class="modal-footer">
                                        <button type="button" class="btn" data-bs-dismiss="modal">Huỷ
                                        </button>
                                        <button type="button" class="btn btn-danger">Xác nhận</button>
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
                                                <span class="dropdown-toggle" data-bs-toggle="dropdown"
                                                      aria-haspopup="true"
                                                      aria-expanded="false" role="button">
                                                    <i class="ri-more-fill"></i>
                                                </span>
                                                <div class="dropdown-menu m-0 p-0">
                                                    <a class="dropdown-item p-3" href="post/${post.id}/edit">
                                                        <div class="d-flex align-items-top">
                                                            <div class="h4">
                                                                <i class="ri-save-line"></i>
                                                            </div>
                                                            <div class="data ms-2">
                                                                <h6>Chỉnh sửa</h6>
                                                                <p class="mb-0">Chỉnh sửa nội dung bài viết</p>
                                                            </div>
                                                        </div>
                                                    </a>
                                                    <a class="dropdown-item p-3" type="button" data-bs-toggle="modal"
                                                       data-bs-target="#exampleModal">
                                                        <div class="d-flex align-items-top">
                                                            <i class="ri-close-circle-line h4"></i>
                                                            <div class="data ms-2">
                                                                <h6>Xoá</h6>
                                                                <p class="mb-0">Xoá bài viết khỏi hệ thống</p>
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
                    <div>
                        <h5 class="my-2">${post.title}</h5>
                        <p>${post.content}</p>
                    </div>
                    <c:if test="${not empty post.files}">
                        <div class="grid">
                            <div class="grid-sizer"></div>
                            <c:forEach var="file" items="${post.files}">
                                <c:if test="${not empty file}">
                                    <c:choose>
                                        <c:when test="${fn:contains(file.mimeType, 'mp4') or fn:contains(file.mimeType, 'mp3')}">
                                            <div class="grid-item">
                                                <video controls class="rounded">
                                                    <source src="${file.fileUrl}" type="video/mp4">
                                                    Your browser does not support the video tag.
                                                </video>
                                            </div>
                                        </c:when>
                                        <c:otherwise>
                                            <div class="grid-item">
                                                <a href="${file.fileUrl}" target="_blank">
                                                    <img src="${file.fileUrl}"
                                                         alt="post-image"
                                                         class="rounded">
                                                </a>
                                            </div>
                                        </c:otherwise>
                                    </c:choose>
                                </c:if>
                            </c:forEach>
                        </div>
                    </c:if>

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
                                                            <a href="post/${post.id}/unlike?redirect=/post/${post.id}">
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
                                                    <a href="post/${post.id}/like?redirect=/post/${post.id}">
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
                                    ${fn:length(post.comments)} lượt bình luận
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
                                                        <small class="created-at">${comment.createdAt}</small>
                                                    </div>
                                                </div>
                                                <p class="mb-0">${comment.content}</p>
                                            </div>
                                        </div>
                                    </li>
                                </c:if>
                            </c:forEach>
                        </ul>
                        <form class="comment-text d-flex align-items-center mt-3 gap-2" action="post/${post.id}/comment"
                              method="post">
                            <input type="hidden" name="authorId" value="${post.user.id}">
                            <input type="text"
                                   class="form-control rounded"
                                   name="content"
                                   placeholder="Bình luận về bài viết này...">
                            <button class="btn btn-primary h-100">
                                <i class="fas fa-paper-plane"></i>
                            </button>
                        </form>
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
                    <li class="list-inline-item"><a href="content/privacy-policy">Chính sách bảo mật</a></li>
                    <li class="list-inline-item"><a href="content/terms">Điều khoản sử dụng</a></li>
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
