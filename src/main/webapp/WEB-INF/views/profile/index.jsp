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
    <link rel="stylesheet" href="css/socialv.css?v=4.0.0">
    <link rel="stylesheet" href="css/overwrite/profile-page.css">
    <link rel="stylesheet" href="vendor/@fortawesome/fontawesome-free/css/all.min.css">
    <link rel="stylesheet" href="vendor/remixicon/fonts/remixicon.css">
    <link rel="stylesheet" href="vendor/vanillajs-datepicker/dist/css/datepicker.min.css">
    <link rel="stylesheet" href="vendor/font-awesome-line-awesome/css/all.min.css">
    <link rel="stylesheet" href="vendor/line-awesome/dist/line-awesome/css/line-awesome.min.css">
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
                    <li class="active">
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
                    <form action="#" class="searchbox">
                        <a class="search-link" href="#"><i class="ri-search-line"></i></a>
                        <input type="text" class="text search-input" placeholder="Search here...">
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
                                                                <a href="/profile/${user.id}">
                                                                    <div class="d-flex align-items-center">
                                                                        <img class="avatar-40 rounded" src="${user.avatar}"
                                                                             alt="">
                                                                        <div class="ms-3">
                                                                            <h6 class="mb-0 ">${user.firstName} ${user.lastName}</h6>
                                                                            <p class="mb-0">${user.createdAt}</p>
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

                                        <div class="text-center">
                                            <a href="#" class=" btn text-primary">Xem tất cả</a>
                                        </div>
                                    </div>
                                </div>
                            </div>
                        </li>
                        <li class="nav-item dropdown">
                            <c:if test="${not empty notifications}">
                                <div class="position-absolute translate-middle text-white bg-danger rounded-circle text-center"
                                     style="top: 60%; left: 20%; width: 20px; height: 20px; line-height: normal !important;">
                                    <small>${fn:length(notifications)}</small>
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

    <div id="content-page" class="content-page">
        <div class="container">
            <div class="row">
                <%-- Profile background and tabs --%>
                <div class="col-sm-12">
                    <div class="card">
                        <div class="card-body profile-page p-0">
                            <div class="profile-header">
                                <div class="position-relative">
                                    <img src="images/page-img/profile-bg1.jpg" alt="profile-bg"
                                         class="rounded img-fluid">
                                    <ul class="header-nav list-inline d-flex flex-wrap justify-end p-0 m-0">
                                        <li><a href="#"><i class="ri-pencil-line"></i></a></li>
                                        <li><a href="#"><i class="ri-settings-4-line"></i></a></li>
                                    </ul>
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
                                    <div class="social-links">
                                        <c:if test="${isCurrentUser != true}">
                                            <button class="btn btn-primary add-friend-btn">
                                                <c:choose>
                                                    <c:when test="${friendStatus == 'NOT_FRIENDS'}">
                                                        <a>Kết bạn</a>
                                                    </c:when>
                                                    <c:when test="${friendStatus == 'ARE_FRIENDS'}">
                                                        <a>Hủy kết bạn</a>
                                                    </c:when>
                                                    <c:when test="${friendStatus == 'PENDING_SENT_REQUEST'}">
                                                        <a>Hủy yêu cầu</a>
                                                    </c:when>
                                                    <c:otherwise>
                                                        <a>Đồng ý</a>
                                                    </c:otherwise>
                                                </c:choose>
                                            </button>
                                        </c:if>
                                    </div>
                                    <div class="social-info">
                                        <ul class="social-data-block d-flex align-items-center justify-content-between list-inline p-0 m-0">
                                            <li class="text-center ps-3">
                                                <h6>Posts</h6>
                                                <p class="mb-0">690</p>
                                            </li>
                                            <li class="text-center ps-3">
                                                <h6>Followers</h6>
                                                <p class="mb-0">206</p>
                                            </li>
                                            <li class="text-center ps-3">
                                                <h6>Following</h6>
                                                <p class="mb-0">100</p>
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
                                           data-bs-target="#timeline" role="button">Timeline</a>
                                    </li>
                                    <li class="nav-item col-12 col-sm-3 p-0">
                                        <a class="nav-link" href="#pills-about-tab" data-bs-toggle="pill"
                                           data-bs-target="#about" role="button">About</a>
                                    </li>
                                    <li class="nav-item col-12 col-sm-3 p-0">
                                        <a class="nav-link" href="#pills-friends-tab" data-bs-toggle="pill"
                                           data-bs-target="#friends" role="button">Friends</a>
                                    </li>
                                    <li class="nav-item col-12 col-sm-3 p-0">
                                        <a class="nav-link" href="#pills-photos-tab" data-bs-toggle="pill"
                                           data-bs-target="#photos" role="button">Photos</a>
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
                                            <div class="card-body">
                                                <a href="#"><span
                                                        class="badge badge-pill bg-primary font-weight-normal ms-auto me-1"><i
                                                        class="ri-star-line"></i></span> 27 Items for yoou</a>
                                            </div>
                                        </div>
                                        <div class="card">
                                            <div class="card-header d-flex justify-content-between">
                                                <div class="header-title">
                                                    <h4 class="card-title">Life Event</h4>
                                                </div>
                                                <div class="card-header-toolbar d-flex align-items-center">
                                                    <p class="m-0"><a href="javacsript:void();"> Create </a></p>
                                                </div>
                                            </div>
                                            <div class="card-body">
                                                <div class="row">
                                                    <div class="col-sm-12">
                                                        <div class="event-post position-relative">
                                                            <a href="#"><img src="images/page-img/07.jpg"
                                                                             alt="gallary-image"
                                                                             class="img-fluid rounded"></a>
                                                            <div class="job-icon-position">
                                                                <div class="job-icon bg-primary p-2 d-inline-block rounded-circle">
                                                                    <i class="ri-briefcase-line text-white"></i></div>
                                                            </div>
                                                            <div class="card-body text-center p-2">
                                                                <h5>Started New Job at Apple</h5>
                                                                <p>January 24, 2019</p>
                                                            </div>
                                                        </div>
                                                    </div>
                                                    <div class="col-sm-12">
                                                        <div class="event-post position-relative">
                                                            <a href="#"><img src="images/page-img/06.jpg"
                                                                             alt="gallary-image"
                                                                             class="img-fluid rounded"></a>
                                                            <div class="job-icon-position">
                                                                <div class="job-icon bg-primary p-2 d-inline-block rounded-circle">
                                                                    <i class="ri-briefcase-line text-white"></i></div>
                                                            </div>
                                                            <div class="card-body text-center p-2">
                                                                <h5>Freelance Photographer</h5>
                                                                <p class="mb-0">January 24, 2019</p>
                                                            </div>
                                                        </div>
                                                    </div>
                                                </div>
                                            </div>
                                        </div>
                                        <div class="card">
                                            <div class="card-header d-flex justify-content-between">
                                                <div class="header-title">
                                                    <h4 class="card-title">Photos</h4>
                                                </div>
                                                <div class="card-header-toolbar d-flex align-items-center">
                                                    <p class="m-0"><a href="javacsript:void();">Add Photo </a></p>
                                                </div>
                                            </div>
                                            <div class="card-body">
                                                <ul class="profile-img-gallary p-0 m-0 list-unstyled">
                                                    <li class=""><a href="#"><img src="images/page-img/g1.jpg"
                                                                                  alt="gallary-image"
                                                                                  class="img-fluid"/></a></li>
                                                    <li class=""><a href="#"><img src="images/page-img/g2.jpg"
                                                                                  alt="gallary-image"
                                                                                  class="img-fluid"/></a></li>
                                                    <li class=""><a href="#"><img src="images/page-img/g3.jpg"
                                                                                  alt="gallary-image"
                                                                                  class="img-fluid"/></a></li>
                                                    <li class=""><a href="#"><img src="images/page-img/g4.jpg"
                                                                                  alt="gallary-image"
                                                                                  class="img-fluid"/></a></li>
                                                    <li class=""><a href="#"><img src="images/page-img/g5.jpg"
                                                                                  alt="gallary-image"
                                                                                  class="img-fluid"/></a></li>
                                                    <li class=""><a href="#"><img src="images/page-img/g6.jpg"
                                                                                  alt="gallary-image"
                                                                                  class="img-fluid"/></a></li>
                                                    <li class=""><a href="#"><img src="images/page-img/g7.jpg"
                                                                                  alt="gallary-image"
                                                                                  class="img-fluid"/></a></li>
                                                    <li class=""><a href="#"><img src="images/page-img/g8.jpg"
                                                                                  alt="gallary-image"
                                                                                  class="img-fluid"/></a></li>
                                                    <li class=""><a href="#"><img src="images/page-img/g9.jpg"
                                                                                  alt="gallary-image"
                                                                                  class="img-fluid"/></a></li>
                                                </ul>
                                            </div>
                                        </div>
                                        <div class="card">
                                            <div class="card-header d-flex justify-content-between">
                                                <div class="header-title">
                                                    <h4 class="card-title">Friends</h4>
                                                </div>
                                                <div class="card-header-toolbar d-flex align-items-center">
                                                    <p class="m-0"><a href="javacsript:void();">Add New </a></p>
                                                </div>
                                            </div>
                                            <div class="card-body">
                                                <ul class="profile-img-gallary p-0 m-0 list-unstyled">
                                                    <li class="">
                                                        <a href="#">
                                                            <img src="images/user/05.jpg" alt="gallary-image"
                                                                 class="img-fluid"/></a>
                                                        <h6 class="mt-2 text-center">Anna Rexia</h6>
                                                    </li>
                                                    <li class="">
                                                        <a href="#"><img src="images/user/06.jpg"
                                                                         alt="gallary-image" class="img-fluid"/></a>
                                                        <h6 class="mt-2 text-center">Tara Zona</h6>
                                                    </li>
                                                    <li class="">
                                                        <a href="#"><img src="images/user/07.jpg"
                                                                         alt="gallary-image" class="img-fluid"/></a>
                                                        <h6 class="mt-2 text-center">Polly Tech</h6>
                                                    </li>
                                                    <li class="">
                                                        <a href="#"><img src="images/user/08.jpg"
                                                                         alt="gallary-image" class="img-fluid"/></a>
                                                        <h6 class="mt-2 text-center">Bill Emia</h6>
                                                    </li>
                                                    <li class="">
                                                        <a href="#"><img src="images/user/09.jpg"
                                                                         alt="gallary-image" class="img-fluid"/></a>
                                                        <h6 class="mt-2 text-center">Moe Fugga</h6>
                                                    </li>
                                                    <li class="">
                                                        <a href="#"><img src="images/user/10.jpg"
                                                                         alt="gallary-image" class="img-fluid"/></a>
                                                        <h6 class="mt-2 text-center">Hal Appeno </h6>
                                                    </li>
                                                    <li class="">
                                                        <a href="#"><img src="images/user/07.jpg"
                                                                         alt="gallary-image" class="img-fluid"/></a>
                                                        <h6 class="mt-2 text-center">Zack Lee</h6>
                                                    </li>
                                                    <li class="">
                                                        <a href="#"><img src="images/user/06.jpg"
                                                                         alt="gallary-image" class="img-fluid"/></a>
                                                        <h6 class="mt-2 text-center">Terry Aki</h6>
                                                    </li>
                                                    <li class="">
                                                        <a href="#"><img src="images/user/05.jpg"
                                                                         alt="gallary-image" class="img-fluid"/></a>
                                                        <h6 class="mt-2 text-center">Greta Life</h6>
                                                    </li>
                                                </ul>
                                            </div>
                                        </div>
                                    </div>

                                    <%-- Add post widget, User posts - right side --%>
                                    <div class="col-lg-8">
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

                                                                <%-- Title and text content --%>
                                                                <div>
                                                                    <h5 class="my-2">${post.title}</h5>
                                                                    <p>${post.content}</p>
                                                                </div>

                                                                <%-- Images --%>
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

                                                                <%-- Likes and comment box --%>
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
                                                                                        <span
                                                                                                class="dropdown-toggle" data-bs-toggle="dropdown"
                                                                                                aria-haspopup="true" aria-expanded="false" role="button"
                                                                                        >
                                                                                            ${fn:length(post.likes)} lượt thích
                                                                                        </span>
                                                                                        <c:if test="${not empty post.likes}">
                                                                                            <div class="dropdown-menu">
                                                                                                <c:forEach var="like" items="${post.likes}">
                                                                                                    <c:if test="${not empty like}">
                                                                                                        <a class="dropdown-item" href="profile/${like.user.id}">
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
                                                                                <a href="post/${post.id}" class="w-100 text-black-50">
                                                                                        ${fn:length(post.comments)} lượt bình luận
                                                                                </a>
                                                                            </div>
                                                                        </div>
                                                                        <div class="share-block d-flex align-items-center feather-icon mt-2 mt-md-0">
                                                                            <a href="javascript:void();" data-bs-toggle="offcanvas" data-bs-target="#share-btn" aria-controls="share-btn">
                                                                                <i class="ri-share-line"></i>
                                                                                <span class="ms-1">Chia sẻ</span>
                                                                            </a>
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
                                                                        <a href="post/${post.id}" class="w-100">
                                                                            <input type="text"
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
                                                        Trang cá nhân của ${targetUser.fullName} hiện tại không có bài đăng nào.
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
                            <div class="card">
                                <div class="card-body">
                                    <div class="row">
                                        <div class="col-md-3">
                                            <ul class="nav nav-pills basic-info-items list-inline d-block p-0 m-0">
                                                <li>
                                                    <a class="nav-link active" href="#v-pills-basicinfo-tab"
                                                       data-bs-toggle="pill" data-bs-target="#v-pills-basicinfo-tab"
                                                       role="button">Contact and Basic Info</a>
                                                </li>
                                                <li>
                                                    <a class="nav-link" href="#v-pills-family-tab" data-bs-toggle="pill"
                                                       data-bs-target="#v-pills-family" role="button">Family and
                                                        Relationship</a>
                                                </li>
                                                <li>
                                                    <a class="nav-link" href="#v-pills-work-tab" data-bs-toggle="pill"
                                                       data-bs-target="#v-pills-work-tab" role="button">Work and
                                                        Education</a>
                                                </li>
                                                <li>
                                                    <a class="nav-link" href="#v-pills-lived-tab" data-bs-toggle="pill"
                                                       data-bs-target="#v-pills-lived-tab" role="button">Places You've
                                                        Lived</a>
                                                </li>
                                                <li>
                                                    <a class="nav-link" href="#v-pills-details-tab"
                                                       data-bs-toggle="pill" data-bs-target="#v-pills-details-tab"
                                                       role="button">Details About You</a>
                                                </li>
                                            </ul>
                                        </div>
                                        <div class="col-md-9 ps-4">
                                            <div class="tab-content">
                                                <div class="tab-pane fade active show" id="v-pills-basicinfo-tab"
                                                     role="tabpanel" aria-labelledby="v-pills-basicinfo-tab">
                                                    <h4>Contact Information</h4>
                                                    <hr>
                                                    <div class="row">
                                                        <div class="col-3">
                                                            <h6>Email</h6>
                                                        </div>
                                                        <div class="col-9">
                                                            <p class="mb-0">Bnijohn@gmail.com</p>
                                                        </div>
                                                        <div class="col-3">
                                                            <h6>Mobile</h6>
                                                        </div>
                                                        <div class="col-9">
                                                            <p class="mb-0">(001) 4544 565 456</p>
                                                        </div>
                                                        <div class="col-3">
                                                            <h6>Address</h6>
                                                        </div>
                                                        <div class="col-9">
                                                            <p class="mb-0">United States of America</p>
                                                        </div>
                                                    </div>
                                                    <h4 class="mt-3">Websites and Social Links</h4>
                                                    <hr>
                                                    <div class="row">
                                                        <div class="col-3">
                                                            <h6>Website</h6>
                                                        </div>
                                                        <div class="col-9">
                                                            <p class="mb-0">www.bootstrap.com</p>
                                                        </div>
                                                        <div class="col-3">
                                                            <h6>Social Link</h6>
                                                        </div>
                                                        <div class="col-9">
                                                            <p class="mb-0">www.bootstrap.com</p>
                                                        </div>
                                                    </div>
                                                    <h4 class="mt-3">Basic Information</h4>
                                                    <hr>
                                                    <div class="row">
                                                        <div class="col-3">
                                                            <h6>Birth Date</h6>
                                                        </div>
                                                        <div class="col-9">
                                                            <p class="mb-0">24 January</p>
                                                        </div>
                                                        <div class="col-3">
                                                            <h6>Birth Year</h6>
                                                        </div>
                                                        <div class="col-9">
                                                            <p class="mb-0">1994</p>
                                                        </div>
                                                        <div class="col-3">
                                                            <h6>Gender</h6>
                                                        </div>
                                                        <div class="col-9">
                                                            <p class="mb-0">Female</p>
                                                        </div>
                                                        <div class="col-3">
                                                            <h6>interested in</h6>
                                                        </div>
                                                        <div class="col-9">
                                                            <p class="mb-0">Designing</p>
                                                        </div>
                                                        <div class="col-3">
                                                            <h6>language</h6>
                                                        </div>
                                                        <div class="col-9">
                                                            <p class="mb-0">English, French</p>
                                                        </div>
                                                    </div>
                                                </div>
                                                <div class="tab-pane fade" id="v-pills-family" role="tabpanel">
                                                    <h4 class="mb-3">Relationship</h4>
                                                    <ul class="suggestions-lists m-0 p-0">
                                                        <li class="d-flex mb-4 align-items-center">
                                                            <div class="user-img img-fluid"><i class="ri-add-fill"></i>
                                                            </div>
                                                            <div class="media-support-info ms-3">
                                                                <h6>Add Your Relationship Status</h6>
                                                            </div>
                                                        </li>
                                                    </ul>
                                                    <h4 class="mt-3 mb-3">Family Members</h4>
                                                    <ul class="suggestions-lists m-0 p-0">
                                                        <li class="d-flex mb-4 align-items-center">
                                                            <div class="user-img img-fluid"><i class="ri-add-fill"></i>
                                                            </div>
                                                            <div class="media-support-info ms-3">
                                                                <h6>Add Family Members</h6>
                                                            </div>
                                                        </li>
                                                        <li class="d-flex mb-4 align-items-center justify-content-between">
                                                            <div class="user-img img-fluid"><img
                                                                    src="images/user/01.jpg" alt="story-img"
                                                                    class="rounded-circle avatar-40"></div>
                                                            <div class="w-100">
                                                                <div class="d-flex justify-content-between">
                                                                    <div class="ms-3">
                                                                        <h6>Paul Molive</h6>
                                                                        <p class="mb-0">Brothe</p>
                                                                    </div>
                                                                    <div class="edit-relation"><a href="#"><i
                                                                            class="ri-edit-line me-2"></i>Edit</a></div>
                                                                </div>
                                                            </div>
                                                        </li>
                                                        <li class="d-flex justify-content-between mb-4  align-items-center">
                                                            <div class="user-img img-fluid"><img
                                                                    src="images/user/02.jpg" alt="story-img"
                                                                    class="rounded-circle avatar-40"></div>
                                                            <div class="w-100">
                                                                <div class="d-flex flex-wrap justify-content-between">
                                                                    <div class=" ms-3">
                                                                        <h6>Anna Mull</h6>
                                                                        <p class="mb-0">Sister</p>
                                                                    </div>
                                                                    <div class="edit-relation"><a href="#"><i
                                                                            class="ri-edit-line me-2"></i>Edit</a></div>
                                                                </div>
                                                            </div>
                                                        </li>
                                                        <li class="d-flex mb-4 align-items-center justify-content-between">
                                                            <div class="user-img img-fluid"><img
                                                                    src="images/user/03.jpg" alt="story-img"
                                                                    class="rounded-circle avatar-40"></div>
                                                            <div class="w-100">
                                                                <div class="d-flex justify-content-between">
                                                                    <div class="ms-3">
                                                                        <h6>Paige Turner</h6>
                                                                        <p class="mb-0">Cousin</p>
                                                                    </div>
                                                                    <div class="edit-relation"><a href="#"><i
                                                                            class="ri-edit-line me-2"></i>Edit</a></div>
                                                                </div>
                                                            </div>
                                                        </li>
                                                    </ul>
                                                </div>
                                                <div class="tab-pane fade" id="v-pills-work-tab" role="tabpanel"
                                                     aria-labelledby="v-pills-work-tab">
                                                    <h4 class="mb-3">Work</h4>
                                                    <ul class="suggestions-lists m-0 p-0">
                                                        <li class="d-flex justify-content-between mb-4  align-items-center">
                                                            <div class="user-img img-fluid"><i class="ri-add-fill"></i>
                                                            </div>
                                                            <div class="ms-3">
                                                                <h6>Add Work Place</h6>
                                                            </div>
                                                        </li>
                                                        <li class="d-flex mb-4 align-items-center justify-content-between">
                                                            <div class="user-img img-fluid"><img
                                                                    src="images/user/01.jpg" alt="story-img"
                                                                    class="rounded-circle avatar-40"></div>
                                                            <div class="w-100">
                                                                <div class="d-flex justify-content-between">
                                                                    <div class="ms-3">
                                                                        <h6>Themeforest</h6>
                                                                        <p class="mb-0">Web Designer</p>
                                                                    </div>
                                                                    <div class="edit-relation"><a href="#"><i
                                                                            class="ri-edit-line me-2"></i>Edit</a></div>
                                                                </div>
                                                            </div>
                                                        </li>
                                                        <li class="d-flex mb-4 align-items-center justify-content-between">
                                                            <div class="user-img img-fluid"><img
                                                                    src="images/user/02.jpg" alt="story-img"
                                                                    class="rounded-circle avatar-40"></div>
                                                            <div class="w-100">
                                                                <div class="d-flex flex-wrap justify-content-between">
                                                                    <div class="ms-3">
                                                                        <h6>iqonicdesign</h6>
                                                                        <p class="mb-0">Web Developer</p>
                                                                    </div>
                                                                    <div class="edit-relation"><a href="#"><i
                                                                            class="ri-edit-line me-2"></i>Edit</a></div>
                                                                </div>
                                                            </div>
                                                        </li>
                                                        <li class="d-flex mb-4 align-items-center justify-content-between">
                                                            <div class="user-img img-fluid"><img
                                                                    src="images/user/03.jpg" alt="story-img"
                                                                    class="rounded-circle avatar-40"></div>
                                                            <div class="w-100">
                                                                <div class="d-flex flex-wrap justify-content-between">
                                                                    <div class="ms-3">
                                                                        <h6>W3school</h6>
                                                                        <p class="mb-0">Designer</p>
                                                                    </div>
                                                                    <div class="edit-relation"><a href="#"><i
                                                                            class="ri-edit-line me-2"></i>Edit</a></div>
                                                                </div>
                                                            </div>
                                                        </li>
                                                    </ul>
                                                    <h4 class="mb-3">Professional Skills</h4>
                                                    <ul class="suggestions-lists m-0 p-0">
                                                        <li class="d-flex mb-4 align-items-center">
                                                            <div class="user-img img-fluid"><i class="ri-add-fill"></i>
                                                            </div>
                                                            <div class="ms-3">
                                                                <h6>Add Professional Skills</h6>
                                                            </div>
                                                        </li>
                                                    </ul>
                                                    <h4 class="mt-3 mb-3">College</h4>
                                                    <ul class="suggestions-lists m-0 p-0">
                                                        <li class="d-flex mb-4 align-items-center">
                                                            <div class="user-img img-fluid"><i class="ri-add-fill"></i>
                                                            </div>
                                                            <div class="ms-3">
                                                                <h6>Add College</h6>
                                                            </div>
                                                        </li>
                                                        <li class="d-flex mb-4 align-items-center">
                                                            <div class="user-img img-fluid"><img
                                                                    src="images/user/01.jpg" alt="story-img"
                                                                    class="rounded-circle avatar-40"></div>
                                                            <div class="w-100">
                                                                <div class="d-flex flex-wrap justify-content-between">
                                                                    <div class="ms-3">
                                                                        <h6>Lorem ipsum</h6>
                                                                        <p class="mb-0">USA</p>
                                                                    </div>
                                                                    <div class="edit-relation"><a href="#"><i
                                                                            class="ri-edit-line me-2"></i>Edit</a></div>
                                                                </div>
                                                            </div>
                                                        </li>
                                                    </ul>
                                                </div>
                                                <div class="tab-pane fade" id="v-pills-lived-tab" role="tabpanel"
                                                     aria-labelledby="v-pills-lived-tab">
                                                    <h4 class="mb-3">Current City and Hometown</h4>
                                                    <ul class="suggestions-lists m-0 p-0">
                                                        <li class="d-flex mb-4 align-items-center justify-content-between">
                                                            <div class="user-img img-fluid"><img
                                                                    src="images/user/01.jpg" alt="story-img"
                                                                    class="rounded-circle avatar-40"></div>
                                                            <div class="w-100">
                                                                <div class="d-flex flex-wrap justify-content-between">
                                                                    <div class="ms-3">
                                                                        <h6>Georgia</h6>
                                                                        <p class="mb-0">Georgia State</p>
                                                                    </div>
                                                                    <div class="edit-relation"><a href="#"><i
                                                                            class="ri-edit-line me-2"></i>Edit</a></div>
                                                                </div>
                                                            </div>
                                                        </li>
                                                        <li class="d-flex mb-4 align-items-center justify-content-between">
                                                            <div class="user-img img-fluid"><img
                                                                    src="images/user/02.jpg" alt="story-img"
                                                                    class="rounded-circle avatar-40"></div>
                                                            <div class="w-100">
                                                                <div class="d-flex flex-wrap justify-content-between">
                                                                    <div class="ms-3">
                                                                        <h6>Atlanta</h6>
                                                                        <p class="mb-0">Atlanta City</p>
                                                                    </div>
                                                                    <div class="edit-relation"><a href="#"><i
                                                                            class="ri-edit-line me-2"></i>Edit</a></div>
                                                                </div>
                                                            </div>
                                                        </li>
                                                    </ul>
                                                    <h4 class="mt-3 mb-3">Other Places Lived</h4>
                                                    <ul class="suggestions-lists m-0 p-0">
                                                        <li class="d-flex mb-4 align-items-center">
                                                            <div class="user-img img-fluid"><i class="ri-add-fill"></i>
                                                            </div>
                                                            <div class="ms-3">
                                                                <h6>Add Place</h6>
                                                            </div>
                                                        </li>
                                                    </ul>
                                                </div>
                                                <div class="tab-pane fade" id="v-pills-details-tab" role="tabpanel"
                                                     aria-labelledby="v-pills-details-tab">
                                                    <h4 class="mb-3">About You</h4>
                                                    <p>Hi, I’m Bni, I’m 26 and I work as a Web Designer for the
                                                        iqonicdesign.</p>
                                                    <h4 class="mt-3 mb-3">Other Name</h4>
                                                    <p>Bini Rock</p>
                                                    <h4 class="mt-3 mb-3">Favorite Quotes</h4>
                                                    <p>Lorem Ipsum is simply dummy text of the printing and typesetting
                                                        industry. Lorem Ipsum has been the industry's standard dummy
                                                        text ever since the 1500s</p>
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
                                    <h2>Friends</h2>
                                    <div class="friend-list-tab mt-2">
                                        <ul class="nav nav-pills d-flex align-items-center justify-content-left friend-list-items p-0 mb-2">
                                            <li>
                                                <a class="nav-link active" data-bs-toggle="pill"
                                                   href="#pill-all-friends" data-bs-target="#all-feinds">All Friends</a>
                                            </li>
                                            <li>
                                                <a class="nav-link" data-bs-toggle="pill" href="#pill-recently-add"
                                                   data-bs-target="#recently-add">Recently Added</a>
                                            </li>
                                            <li>
                                                <a class="nav-link" data-bs-toggle="pill" href="#pill-closefriends"
                                                   data-bs-target="#closefriends"> Close friends</a>
                                            </li>
                                            <li>
                                                <a class="nav-link" data-bs-toggle="pill" href="#pill-home"
                                                   data-bs-target="#home-town"> Home/Town</a>
                                            </li>
                                            <li>
                                                <a class="nav-link" data-bs-toggle="pill" href="#pill-following"
                                                   data-bs-target="#following">Following</a>
                                            </li>
                                        </ul>
                                        <div class="tab-content">
                                            <div class="tab-pane fade active show" id="all-friends" role="tabpanel">
                                                <div class="card-body p-0">
                                                    <div class="row">
                                                        <div class="col-md-6 col-lg-6 mb-3">
                                                            <div class="iq-friendlist-block">
                                                                <div class="d-flex align-items-center justify-content-between">
                                                                    <div class="d-flex align-items-center">
                                                                        <a href="#">
                                                                            <img src="images/user/05.jpg"
                                                                                 alt="profile-img" class="img-fluid">
                                                                        </a>
                                                                        <div class="friend-info ms-3">
                                                                            <h5>Petey Cruiser</h5>
                                                                            <p class="mb-0">15 friends</p>
                                                                        </div>
                                                                    </div>
                                                                    <div class="card-header-toolbar d-flex align-items-center">
                                                                        <div class="dropdown">
                                                   <span class="dropdown-toggle btn btn-secondary me-2"
                                                         id="dropdownMenuButton01" data-bs-toggle="dropdown"
                                                         aria-expanded="true" role="button">
                                                   <i class="ri-check-line me-1 text-white"></i> Friend
                                                   </span>
                                                                            <div class="dropdown-menu dropdown-menu-right"
                                                                                 aria-labelledby="dropdownMenuButton01">
                                                                                <a class="dropdown-item" href="#">Get
                                                                                    Notification</a>
                                                                                <a class="dropdown-item" href="#">Close
                                                                                    Friend</a>
                                                                                <a class="dropdown-item" href="#">Unfollow</a>
                                                                                <a class="dropdown-item" href="#">Unfriend</a>
                                                                                <a class="dropdown-item"
                                                                                   href="#">Block</a>
                                                                            </div>
                                                                        </div>
                                                                    </div>
                                                                </div>
                                                            </div>
                                                        </div>
                                                        <div class="col-md-6 col-lg-6 mb-3">
                                                            <div class="iq-friendlist-block">
                                                                <div class="d-flex align-items-center justify-content-between">
                                                                    <div class="d-flex align-items-center">
                                                                        <a href="#">
                                                                            <img src="images/user/06.jpg"
                                                                                 alt="profile-img" class="img-fluid">
                                                                        </a>
                                                                        <div class="friend-info ms-3">
                                                                            <h5>Anna Sthesia</h5>
                                                                            <p class="mb-0">50 friends</p>
                                                                        </div>
                                                                    </div>
                                                                    <div class="card-header-toolbar d-flex align-items-center">
                                                                        <div class="dropdown">
                                                   <span class="dropdown-toggle btn btn-secondary me-2"
                                                         id="dropdownMenuButton02" data-bs-toggle="dropdown"
                                                         aria-expanded="true" role="button">
                                                   <i class="ri-check-line me-1 text-white"></i> Friend
                                                   </span>
                                                                            <div class="dropdown-menu dropdown-menu-right"
                                                                                 aria-labelledby="dropdownMenuButton02">
                                                                                <a class="dropdown-item" href="#">Get
                                                                                    Notification</a>
                                                                                <a class="dropdown-item" href="#">Close
                                                                                    Friend</a>
                                                                                <a class="dropdown-item" href="#">Unfollow</a>
                                                                                <a class="dropdown-item" href="#">Unfriend</a>
                                                                                <a class="dropdown-item"
                                                                                   href="#">Block</a>
                                                                            </div>
                                                                        </div>
                                                                    </div>
                                                                </div>
                                                            </div>
                                                        </div>
                                                        <div class="col-md-6 col-lg-6 mb-3">
                                                            <div class="iq-friendlist-block">
                                                                <div class="d-flex align-items-center justify-content-between">
                                                                    <div class="d-flex align-items-center">
                                                                        <a href="#">
                                                                            <img src="images/user/07.jpg"
                                                                                 alt="profile-img" class="img-fluid">
                                                                        </a>
                                                                        <div class="friend-info ms-3">
                                                                            <h5>Paul Molive</h5>
                                                                            <p class="mb-0">10 friends</p>
                                                                        </div>
                                                                    </div>
                                                                    <div class="card-header-toolbar d-flex align-items-center">
                                                                        <div class="dropdown">
                                                   <span class="dropdown-toggle btn btn-secondary me-2"
                                                         id="dropdownMenuButton03" data-bs-toggle="dropdown"
                                                         aria-expanded="true" role="button">
                                                   <i class="ri-check-line me-1 text-white"></i> Friend
                                                   </span>
                                                                            <div class="dropdown-menu dropdown-menu-right"
                                                                                 aria-labelledby="dropdownMenuButton03">
                                                                                <a class="dropdown-item" href="#">Get
                                                                                    Notification</a>
                                                                                <a class="dropdown-item" href="#">Close
                                                                                    Friend</a>
                                                                                <a class="dropdown-item" href="#">Unfollow</a>
                                                                                <a class="dropdown-item" href="#">Unfriend</a>
                                                                                <a class="dropdown-item"
                                                                                   href="#">Block</a>
                                                                            </div>
                                                                        </div>
                                                                    </div>
                                                                </div>
                                                            </div>
                                                        </div>
                                                        <div class="col-md-6 col-lg-6 mb-3">
                                                            <div class="iq-friendlist-block">
                                                                <div class="d-flex align-items-center justify-content-between">
                                                                    <div class="d-flex align-items-center">
                                                                        <a href="#">
                                                                            <img src="images/user/08.jpg"
                                                                                 alt="profile-img" class="img-fluid">
                                                                        </a>
                                                                        <div class="friend-info ms-3">
                                                                            <h5>Gail Forcewind</h5>
                                                                            <p class="mb-0">20 friends</p>
                                                                        </div>
                                                                    </div>
                                                                    <div class="card-header-toolbar d-flex align-items-center">
                                                                        <div class="dropdown">
                                                   <span class="dropdown-toggle btn btn-secondary me-2"
                                                         id="dropdownMenuButton04" data-bs-toggle="dropdown"
                                                         aria-expanded="true" role="button">
                                                   <i class="ri-check-line me-1 text-white"></i> Friend
                                                   </span>
                                                                            <div class="dropdown-menu dropdown-menu-right"
                                                                                 aria-labelledby="dropdownMenuButton04">
                                                                                <a class="dropdown-item" href="#">Get
                                                                                    Notification</a>
                                                                                <a class="dropdown-item" href="#">Close
                                                                                    Friend</a>
                                                                                <a class="dropdown-item" href="#">Unfollow</a>
                                                                                <a class="dropdown-item" href="#">Unfriend</a>
                                                                                <a class="dropdown-item"
                                                                                   href="#">Block</a>
                                                                            </div>
                                                                        </div>
                                                                    </div>
                                                                </div>
                                                            </div>
                                                        </div>
                                                        <div class="col-md-6 col-lg-6 mb-3">
                                                            <div class="iq-friendlist-block">
                                                                <div class="d-flex align-items-center justify-content-between">
                                                                    <div class="d-flex align-items-center">
                                                                        <a href="#">
                                                                            <img src="images/user/09.jpg"
                                                                                 alt="profile-img" class="img-fluid">
                                                                        </a>
                                                                        <div class="friend-info ms-3">
                                                                            <h5>Paige Turner</h5>
                                                                            <p class="mb-0">12 friends</p>
                                                                        </div>
                                                                    </div>
                                                                    <div class="card-header-toolbar d-flex align-items-center">
                                                                        <div class="dropdown">
                                                   <span class="dropdown-toggle btn btn-secondary me-2"
                                                         id="dropdownMenuButton05" data-bs-toggle="dropdown"
                                                         aria-expanded="true" role="button">
                                                   <i class="ri-check-line me-1 text-white"></i> Friend
                                                   </span>
                                                                            <div class="dropdown-menu dropdown-menu-right"
                                                                                 aria-labelledby="dropdownMenuButton05">
                                                                                <a class="dropdown-item" href="#">Get
                                                                                    Notification</a>
                                                                                <a class="dropdown-item" href="#">Close
                                                                                    Friend</a>
                                                                                <a class="dropdown-item" href="#">Unfollow</a>
                                                                                <a class="dropdown-item" href="#">Unfriend</a>
                                                                                <a class="dropdown-item"
                                                                                   href="#">Block</a>
                                                                            </div>
                                                                        </div>
                                                                    </div>
                                                                </div>
                                                            </div>
                                                        </div>
                                                        <div class="col-md-6 col-lg-6 mb-3">
                                                            <div class="iq-friendlist-block">
                                                                <div class="d-flex align-items-center justify-content-between">
                                                                    <div class="d-flex align-items-center">
                                                                        <a href="#">
                                                                            <img src="images/user/10.jpg"
                                                                                 alt="profile-img" class="img-fluid">
                                                                        </a>
                                                                        <div class="friend-info ms-3">
                                                                            <h5>b Frapples</h5>
                                                                            <p class="mb-0">6 friends</p>
                                                                        </div>
                                                                    </div>
                                                                    <div class="card-header-toolbar d-flex align-items-center">
                                                                        <div class="dropdown">
                                                   <span class="dropdown-toggle btn btn-secondary me-2"
                                                         id="dropdownMenuButton06" data-bs-toggle="dropdown"
                                                         aria-expanded="true" role="button">
                                                   <i class="ri-check-line me-1 text-white"></i> Friend
                                                   </span>
                                                                            <div class="dropdown-menu dropdown-menu-right"
                                                                                 aria-labelledby="dropdownMenuButton06">
                                                                                <a class="dropdown-item" href="#">Get
                                                                                    Notification</a>
                                                                                <a class="dropdown-item" href="#">Close
                                                                                    Friend</a>
                                                                                <a class="dropdown-item" href="#">Unfollow</a>
                                                                                <a class="dropdown-item" href="#">Unfriend</a>
                                                                                <a class="dropdown-item"
                                                                                   href="#">Block</a>
                                                                            </div>
                                                                        </div>
                                                                    </div>
                                                                </div>
                                                            </div>
                                                        </div>
                                                        <div class="col-md-6 col-lg-6 mb-3">
                                                            <div class="iq-friendlist-block">
                                                                <div class="d-flex align-items-center justify-content-between">
                                                                    <div class="d-flex align-items-center">
                                                                        <a href="#">
                                                                            <img src="images/user/13.jpg"
                                                                                 alt="profile-img" class="img-fluid">
                                                                        </a>
                                                                        <div class="friend-info ms-3">
                                                                            <h5>Walter Melon</h5>
                                                                            <p class="mb-0">30 friends</p>
                                                                        </div>
                                                                    </div>
                                                                    <div class="card-header-toolbar d-flex align-items-center">
                                                                        <div class="dropdown">
                                                   <span class="dropdown-toggle btn btn-secondary me-2"
                                                         id="dropdownMenuButton07" data-bs-toggle="dropdown"
                                                         aria-expanded="true" role="button">
                                                   <i class="ri-check-line me-1 text-white"></i> Friend
                                                   </span>
                                                                            <div class="dropdown-menu dropdown-menu-right"
                                                                                 aria-labelledby="dropdownMenuButton07">
                                                                                <a class="dropdown-item" href="#">Get
                                                                                    Notification</a>
                                                                                <a class="dropdown-item" href="#">Close
                                                                                    Friend</a>
                                                                                <a class="dropdown-item" href="#">Unfollow</a>
                                                                                <a class="dropdown-item" href="#">Unfriend</a>
                                                                                <a class="dropdown-item"
                                                                                   href="#">Block</a>
                                                                            </div>
                                                                        </div>
                                                                    </div>
                                                                </div>
                                                            </div>
                                                        </div>
                                                        <div class="col-md-6 col-lg-6 mb-3">
                                                            <div class="iq-friendlist-block">
                                                                <div class="d-flex align-items-center justify-content-between">
                                                                    <div class="d-flex align-items-center">
                                                                        <a href="#">
                                                                            <img src="images/user/14.jpg"
                                                                                 alt="profile-img" class="img-fluid">
                                                                        </a>
                                                                        <div class="friend-info ms-3">
                                                                            <h5>Barb Ackue</h5>
                                                                            <p class="mb-0">14 friends</p>
                                                                        </div>
                                                                    </div>
                                                                    <div class="card-header-toolbar d-flex align-items-center">
                                                                        <div class="dropdown">
                                                   <span class="dropdown-toggle btn btn-secondary me-2"
                                                         id="dropdownMenuButton08" data-bs-toggle="dropdown"
                                                         aria-expanded="true" role="button">
                                                   <i class="ri-check-line me-1 text-white"></i> Friend
                                                   </span>
                                                                            <div class="dropdown-menu dropdown-menu-right"
                                                                                 aria-labelledby="dropdownMenuButton08">
                                                                                <a class="dropdown-item" href="#">Get
                                                                                    Notification</a>
                                                                                <a class="dropdown-item" href="#">Close
                                                                                    Friend</a>
                                                                                <a class="dropdown-item" href="#">Unfollow</a>
                                                                                <a class="dropdown-item" href="#">Unfriend</a>
                                                                                <a class="dropdown-item"
                                                                                   href="#">Block</a>
                                                                            </div>
                                                                        </div>
                                                                    </div>
                                                                </div>
                                                            </div>
                                                        </div>
                                                        <div class="col-md-6 col-lg-6 mb-3">
                                                            <div class="iq-friendlist-block">
                                                                <div class="d-flex align-items-center justify-content-between">
                                                                    <div class="d-flex align-items-center">
                                                                        <a href="#">
                                                                            <img src="images/user/15.jpg"
                                                                                 alt="profile-img" class="img-fluid">
                                                                        </a>
                                                                        <div class="friend-info ms-3">
                                                                            <h5>Buck Kinnear</h5>
                                                                            <p class="mb-0">16 friends</p>
                                                                        </div>
                                                                    </div>
                                                                    <div class="card-header-toolbar d-flex align-items-center">
                                                                        <div class="dropdown">
                                                   <span class="dropdown-toggle btn btn-secondary me-2"
                                                         id="dropdownMenuButton09" data-bs-toggle="dropdown"
                                                         aria-expanded="true" role="button">
                                                   <i class="ri-check-line me-1 text-white"></i> Friend
                                                   </span>
                                                                            <div class="dropdown-menu dropdown-menu-right"
                                                                                 aria-labelledby="dropdownMenuButton09">
                                                                                <a class="dropdown-item" href="#">Get
                                                                                    Notification</a>
                                                                                <a class="dropdown-item" href="#">Close
                                                                                    Friend</a>
                                                                                <a class="dropdown-item" href="#">Unfollow</a>
                                                                                <a class="dropdown-item" href="#">Unfriend</a>
                                                                                <a class="dropdown-item"
                                                                                   href="#">Block</a>
                                                                            </div>
                                                                        </div>
                                                                    </div>
                                                                </div>
                                                            </div>
                                                        </div>
                                                        <div class="col-md-6 col-lg-6 mb-3">
                                                            <div class="iq-friendlist-block">
                                                                <div class="d-flex align-items-center justify-content-between">
                                                                    <div class="d-flex align-items-center">
                                                                        <a href="#">
                                                                            <img src="images/user/16.jpg"
                                                                                 alt="profile-img" class="img-fluid">
                                                                        </a>
                                                                        <div class="friend-info ms-3">
                                                                            <h5>Ira Membrit</h5>
                                                                            <p class="mb-0">22 friends</p>
                                                                        </div>
                                                                    </div>
                                                                    <div class="card-header-toolbar d-flex align-items-center">
                                                                        <div class="dropdown">
                                                   <span class="dropdown-toggle btn btn-secondary me-2"
                                                         id="dropdownMenuButton10" data-bs-toggle="dropdown"
                                                         aria-expanded="true" role="button">
                                                   <i class="ri-check-line me-1 text-white"></i> Friend
                                                   </span>
                                                                            <div class="dropdown-menu dropdown-menu-right"
                                                                                 aria-labelledby="dropdownMenuButton10">
                                                                                <a class="dropdown-item" href="#">Get
                                                                                    Notification</a>
                                                                                <a class="dropdown-item" href="#">Close
                                                                                    Friend</a>
                                                                                <a class="dropdown-item" href="#">Unfollow</a>
                                                                                <a class="dropdown-item" href="#">Unfriend</a>
                                                                                <a class="dropdown-item"
                                                                                   href="#">Block</a>
                                                                            </div>
                                                                        </div>
                                                                    </div>
                                                                </div>
                                                            </div>
                                                        </div>
                                                        <div class="col-md-6 col-lg-6 mb-3">
                                                            <div class="iq-friendlist-block">
                                                                <div class="d-flex align-items-center justify-content-between">
                                                                    <div class="d-flex align-items-center">
                                                                        <a href="#">
                                                                            <img src="images/user/17.jpg"
                                                                                 alt="profile-img" class="img-fluid">
                                                                        </a>
                                                                        <div class="friend-info ms-3">
                                                                            <h5>Shonda Leer</h5>
                                                                            <p class="mb-0">10 friends</p>
                                                                        </div>
                                                                    </div>
                                                                    <div class="card-header-toolbar d-flex align-items-center">
                                                                        <div class="dropdown">
                                                   <span class="dropdown-toggle btn btn-secondary me-2"
                                                         id="dropdownMenuButton11" data-bs-toggle="dropdown"
                                                         aria-expanded="true" role="button">
                                                   <i class="ri-check-line me-1 text-white"></i> Friend
                                                   </span>
                                                                            <div class="dropdown-menu dropdown-menu-right"
                                                                                 aria-labelledby="dropdownMenuButton11">
                                                                                <a class="dropdown-item" href="#">Get
                                                                                    Notification</a>
                                                                                <a class="dropdown-item" href="#">Close
                                                                                    Friend</a>
                                                                                <a class="dropdown-item" href="#">Unfollow</a>
                                                                                <a class="dropdown-item" href="#">Unfriend</a>
                                                                                <a class="dropdown-item"
                                                                                   href="#">Block</a>
                                                                            </div>
                                                                        </div>
                                                                    </div>
                                                                </div>
                                                            </div>
                                                        </div>
                                                        <div class="col-md-6 col-lg-6 mb-3">
                                                            <div class="iq-friendlist-block">
                                                                <div class="d-flex align-items-center justify-content-between">
                                                                    <div class="d-flex align-items-center">
                                                                        <a href="#">
                                                                            <img src="images/user/18.jpg"
                                                                                 alt="profile-img" class="img-fluid">
                                                                        </a>
                                                                        <div class="friend-info ms-3">
                                                                            <h5>ock Lee</h5>
                                                                            <p class="mb-0">18 friends</p>
                                                                        </div>
                                                                    </div>
                                                                    <div class="card-header-toolbar d-flex align-items-center">
                                                                        <div class="dropdown">
                                                   <span class="dropdown-toggle btn btn-secondary me-2"
                                                         id="dropdownMenuButton12" data-bs-toggle="dropdown"
                                                         aria-expanded="true" role="button">
                                                   <i class="ri-check-line me-1 text-white"></i> Friend
                                                   </span>
                                                                            <div class="dropdown-menu dropdown-menu-right"
                                                                                 aria-labelledby="dropdownMenuButton12">
                                                                                <a class="dropdown-item" href="#">Get
                                                                                    Notification</a>
                                                                                <a class="dropdown-item" href="#">Close
                                                                                    Friend</a>
                                                                                <a class="dropdown-item" href="#">Unfollow</a>
                                                                                <a class="dropdown-item" href="#">Unfriend</a>
                                                                                <a class="dropdown-item"
                                                                                   href="#">Block</a>
                                                                            </div>
                                                                        </div>
                                                                    </div>
                                                                </div>
                                                            </div>
                                                        </div>
                                                        <div class="col-md-6 col-lg-6 mb-3">
                                                            <div class="iq-friendlist-block">
                                                                <div class="d-flex align-items-center justify-content-between">
                                                                    <div class="d-flex align-items-center">
                                                                        <a href="#">
                                                                            <img src="images/user/19.jpg"
                                                                                 alt="profile-img" class="img-fluid">
                                                                        </a>
                                                                        <div class="friend-info ms-3">
                                                                            <h5>Maya Didas</h5>
                                                                            <p class="mb-0">40 friends</p>
                                                                        </div>
                                                                    </div>
                                                                    <div class="card-header-toolbar d-flex align-items-center">
                                                                        <div class="dropdown">
                                                   <span class="dropdown-toggle btn btn-secondary me-2"
                                                         id="dropdownMenuButton13" data-bs-toggle="dropdown"
                                                         aria-expanded="true" role="button">
                                                   <i class="ri-check-line me-1 text-white"></i> Friend
                                                   </span>
                                                                            <div class="dropdown-menu dropdown-menu-right"
                                                                                 aria-labelledby="dropdownMenuButton13">
                                                                                <a class="dropdown-item" href="#">Get
                                                                                    Notification</a>
                                                                                <a class="dropdown-item" href="#">Close
                                                                                    Friend</a>
                                                                                <a class="dropdown-item" href="#">Unfollow</a>
                                                                                <a class="dropdown-item" href="#">Unfriend</a>
                                                                                <a class="dropdown-item"
                                                                                   href="#">Block</a>
                                                                            </div>
                                                                        </div>
                                                                    </div>
                                                                </div>
                                                            </div>
                                                        </div>
                                                        <div class="col-md-6 col-lg-6 mb-3">
                                                            <div class="iq-friendlist-block">
                                                                <div class="d-flex align-items-center justify-content-between">
                                                                    <div class="d-flex align-items-center">
                                                                        <a href="#">
                                                                            <img src="images/user/05.jpg"
                                                                                 alt="profile-img" class="img-fluid">
                                                                        </a>
                                                                        <div class="friend-info ms-3">
                                                                            <h5>Rick O'Shea</h5>
                                                                            <p class="mb-0">50 friends</p>
                                                                        </div>
                                                                    </div>
                                                                    <div class="card-header-toolbar d-flex align-items-center">
                                                                        <div class="dropdown">
                                                   <span class="dropdown-toggle btn btn-secondary me-2"
                                                         id="dropdownMenuButton14" data-bs-toggle="dropdown"
                                                         aria-expanded="true" role="button">
                                                   <i class="ri-check-line me-1 text-white"></i> Friend
                                                   </span>
                                                                            <div class="dropdown-menu dropdown-menu-right"
                                                                                 aria-labelledby="dropdownMenuButton14">
                                                                                <a class="dropdown-item" href="#">Get
                                                                                    Notification</a>
                                                                                <a class="dropdown-item" href="#">Close
                                                                                    Friend</a>
                                                                                <a class="dropdown-item" href="#">Unfollow</a>
                                                                                <a class="dropdown-item" href="#">Unfriend</a>
                                                                                <a class="dropdown-item"
                                                                                   href="#">Block</a>
                                                                            </div>
                                                                        </div>
                                                                    </div>
                                                                </div>
                                                            </div>
                                                        </div>
                                                        <div class="col-md-6 col-lg-6 mb-3">
                                                            <div class="iq-friendlist-block">
                                                                <div class="d-flex align-items-center justify-content-between">
                                                                    <div class="d-flex align-items-center">
                                                                        <a href="#">
                                                                            <img src="images/user/06.jpg"
                                                                                 alt="profile-img" class="img-fluid">
                                                                        </a>
                                                                        <div class="friend-info ms-3">
                                                                            <h5>Pete Sariya</h5>
                                                                            <p class="mb-0">5 friends</p>
                                                                        </div>
                                                                    </div>
                                                                    <div class="card-header-toolbar d-flex align-items-center">
                                                                        <div class="dropdown">
                                                   <span class="dropdown-toggle btn btn-secondary me-2"
                                                         id="dropdownMenuButton15" data-bs-toggle="dropdown"
                                                         aria-expanded="true" role="button">
                                                   <i class="ri-check-line me-1 text-white"></i> Friend
                                                   </span>
                                                                            <div class="dropdown-menu dropdown-menu-right"
                                                                                 aria-labelledby="dropdownMenuButton15">
                                                                                <a class="dropdown-item" href="#">Get
                                                                                    Notification</a>
                                                                                <a class="dropdown-item" href="#">Close
                                                                                    Friend</a>
                                                                                <a class="dropdown-item" href="#">Unfollow</a>
                                                                                <a class="dropdown-item" href="#">Unfriend</a>
                                                                                <a class="dropdown-item"
                                                                                   href="#">Block</a>
                                                                            </div>
                                                                        </div>
                                                                    </div>
                                                                </div>
                                                            </div>
                                                        </div>
                                                        <div class="col-md-6 col-lg-6 mb-3">
                                                            <div class="iq-friendlist-block">
                                                                <div class="d-flex align-items-center justify-content-between">
                                                                    <div class="d-flex align-items-center">
                                                                        <a href="#">
                                                                            <img src="images/user/07.jpg"
                                                                                 alt="profile-img" class="img-fluid">
                                                                        </a>
                                                                        <div class="friend-info ms-3">
                                                                            <h5>Monty Carlo</h5>
                                                                            <p class="mb-0">2 friends</p>
                                                                        </div>
                                                                    </div>
                                                                    <div class="card-header-toolbar d-flex align-items-center">
                                                                        <div class="dropdown">
                                                   <span class="dropdown-toggle btn btn-secondary me-2"
                                                         id="dropdownMenuButton16" data-bs-toggle="dropdown"
                                                         aria-expanded="true" role="button">
                                                   <i class="ri-check-line me-1 text-white"></i> Friend
                                                   </span>
                                                                            <div class="dropdown-menu dropdown-menu-right"
                                                                                 aria-labelledby="dropdownMenuButton16">
                                                                                <a class="dropdown-item" href="#">Get
                                                                                    Notification</a>
                                                                                <a class="dropdown-item" href="#">Close
                                                                                    Friend</a>
                                                                                <a class="dropdown-item" href="#">Unfollow</a>
                                                                                <a class="dropdown-item" href="#">Unfriend</a>
                                                                                <a class="dropdown-item"
                                                                                   href="#">Block</a>
                                                                            </div>
                                                                        </div>
                                                                    </div>
                                                                </div>
                                                            </div>
                                                        </div>
                                                        <div class="col-md-6 col-lg-6 mb-3">
                                                            <div class="iq-friendlist-block">
                                                                <div class="d-flex align-items-center justify-content-between">
                                                                    <div class="d-flex align-items-center">
                                                                        <a href="#">
                                                                            <img src="images/user/08.jpg"
                                                                                 alt="profile-img" class="img-fluid">
                                                                        </a>
                                                                        <div class="friend-info ms-3">
                                                                            <h5>Sal Monella</h5>
                                                                            <p class="mb-0">0 friends</p>
                                                                        </div>
                                                                    </div>
                                                                    <div class="card-header-toolbar d-flex align-items-center">
                                                                        <div class="dropdown">
                                                   <span class="dropdown-toggle btn btn-secondary me-2"
                                                         id="dropdownMenuButton17" data-bs-toggle="dropdown"
                                                         aria-expanded="true" role="button">
                                                   <i class="ri-check-line me-1 text-white"></i> Friend
                                                   </span>
                                                                            <div class="dropdown-menu dropdown-menu-right"
                                                                                 aria-labelledby="dropdownMenuButton17">
                                                                                <a class="dropdown-item" href="#">Get
                                                                                    Notification</a>
                                                                                <a class="dropdown-item" href="#">Close
                                                                                    Friend</a>
                                                                                <a class="dropdown-item" href="#">Unfollow</a>
                                                                                <a class="dropdown-item" href="#">Unfriend</a>
                                                                                <a class="dropdown-item"
                                                                                   href="#">Block</a>
                                                                            </div>
                                                                        </div>
                                                                    </div>
                                                                </div>
                                                            </div>
                                                        </div>
                                                        <div class="col-md-6 col-lg-6 mb-3">
                                                            <div class="iq-friendlist-block">
                                                                <div class="d-flex align-items-center justify-content-between">
                                                                    <div class="d-flex align-items-center">
                                                                        <a href="#">
                                                                            <img src="images/user/09.jpg"
                                                                                 alt="profile-img" class="img-fluid">
                                                                        </a>
                                                                        <div class="friend-info ms-3">
                                                                            <h5>Sue Vaneer</h5>
                                                                            <p class="mb-0">25 friends</p>
                                                                        </div>
                                                                    </div>
                                                                    <div class="card-header-toolbar d-flex align-items-center">
                                                                        <div class="dropdown">
                                                   <span class="dropdown-toggle btn btn-secondary me-2"
                                                         id="dropdownMenuButton18" data-bs-toggle="dropdown"
                                                         aria-expanded="true" role="button">
                                                   <i class="ri-check-line me-1 text-white"></i> Friend
                                                   </span>
                                                                            <div class="dropdown-menu dropdown-menu-right"
                                                                                 aria-labelledby="dropdownMenuButton18">
                                                                                <a class="dropdown-item" href="#">Get
                                                                                    Notification</a>
                                                                                <a class="dropdown-item" href="#">Close
                                                                                    Friend</a>
                                                                                <a class="dropdown-item" href="#">Unfollow</a>
                                                                                <a class="dropdown-item" href="#">Unfriend</a>
                                                                                <a class="dropdown-item"
                                                                                   href="#">Block</a>
                                                                            </div>
                                                                        </div>
                                                                    </div>
                                                                </div>
                                                            </div>
                                                        </div>
                                                        <div class="col-md-6 col-lg-6 mb-3">
                                                            <div class="iq-friendlist-block">
                                                                <div class="d-flex align-items-center justify-content-between">
                                                                    <div class="d-flex align-items-center">
                                                                        <a href="#">
                                                                            <img src="images/user/10.jpg"
                                                                                 alt="profile-img" class="img-fluid">
                                                                        </a>
                                                                        <div class="friend-info ms-3">
                                                                            <h5>Cliff Hanger</h5>
                                                                            <p class="mb-0">18 friends</p>
                                                                        </div>
                                                                    </div>
                                                                    <div class="card-header-toolbar d-flex align-items-center">
                                                                        <div class="dropdown">
                                                   <span class="dropdown-toggle btn btn-secondary me-2"
                                                         id="dropdownMenuButton19" data-bs-toggle="dropdown"
                                                         aria-expanded="true" role="button">
                                                   <i class="ri-check-line me-1 text-white"></i> Friend
                                                   </span>
                                                                            <div class="dropdown-menu dropdown-menu-right"
                                                                                 aria-labelledby="dropdownMenuButton19">
                                                                                <a class="dropdown-item" href="#">Get
                                                                                    Notification</a>
                                                                                <a class="dropdown-item" href="#">Close
                                                                                    Friend</a>
                                                                                <a class="dropdown-item" href="#">Unfollow</a>
                                                                                <a class="dropdown-item" href="#">Unfriend</a>
                                                                                <a class="dropdown-item"
                                                                                   href="#">Block</a>
                                                                            </div>
                                                                        </div>
                                                                    </div>
                                                                </div>
                                                            </div>
                                                        </div>
                                                        <div class="col-md-6 col-lg-6 mb-3">
                                                            <div class="iq-friendlist-block">
                                                                <div class="d-flex align-items-center justify-content-between">
                                                                    <div class="d-flex align-items-center">
                                                                        <a href="#">
                                                                            <img src="images/user/05.jpg"
                                                                                 alt="profile-img" class="img-fluid">
                                                                        </a>
                                                                        <div class="friend-info ms-3">
                                                                            <h5>Barb Dwyer</h5>
                                                                            <p class="mb-0">23 friends</p>
                                                                        </div>
                                                                    </div>
                                                                    <div class="card-header-toolbar d-flex align-items-center">
                                                                        <div class="dropdown">
                                                   <span class="dropdown-toggle btn btn-secondary me-2"
                                                         id="dropdownMenuButton20" data-bs-toggle="dropdown"
                                                         aria-expanded="true" role="button">
                                                   <i class="ri-check-line me-1 text-white"></i> Friend
                                                   </span>
                                                                            <div class="dropdown-menu dropdown-menu-right"
                                                                                 aria-labelledby="dropdownMenuButton20">
                                                                                <a class="dropdown-item" href="#">Get
                                                                                    Notification</a>
                                                                                <a class="dropdown-item" href="#">Close
                                                                                    Friend</a>
                                                                                <a class="dropdown-item" href="#">Unfollow</a>
                                                                                <a class="dropdown-item" href="#">Unfriend</a>
                                                                                <a class="dropdown-item"
                                                                                   href="#">Block</a>
                                                                            </div>
                                                                        </div>
                                                                    </div>
                                                                </div>
                                                            </div>
                                                        </div>
                                                        <div class="col-md-6 col-lg-6 mb-3">
                                                            <div class="iq-friendlist-block">
                                                                <div class="d-flex align-items-center justify-content-between">
                                                                    <div class="d-flex align-items-center">
                                                                        <a href="#">
                                                                            <img src="images/user/06.jpg"
                                                                                 alt="profile-img" class="img-fluid">
                                                                        </a>
                                                                        <div class="friend-info ms-3">
                                                                            <h5>Terry Aki</h5>
                                                                            <p class="mb-0">8 friends</p>
                                                                        </div>
                                                                    </div>
                                                                    <div class="card-header-toolbar d-flex align-items-center">
                                                                        <div class="dropdown">
                                                   <span class="dropdown-toggle btn btn-secondary me-2"
                                                         id="dropdownMenuButton21" data-bs-toggle="dropdown"
                                                         aria-expanded="true" role="button">
                                                   <i class="ri-check-line me-1 text-white"></i> Friend
                                                   </span>
                                                                            <div class="dropdown-menu dropdown-menu-right"
                                                                                 aria-labelledby="dropdownMenuButton21">
                                                                                <a class="dropdown-item" href="#">Get
                                                                                    Notification</a>
                                                                                <a class="dropdown-item" href="#">Close
                                                                                    Friend</a>
                                                                                <a class="dropdown-item" href="#">Unfollow</a>
                                                                                <a class="dropdown-item" href="#">Unfriend</a>
                                                                                <a class="dropdown-item"
                                                                                   href="#">Block</a>
                                                                            </div>
                                                                        </div>
                                                                    </div>
                                                                </div>
                                                            </div>
                                                        </div>
                                                        <div class="col-md-6 col-lg-6 mb-3">
                                                            <div class="iq-friendlist-block">
                                                                <div class="d-flex align-items-center justify-content-between">
                                                                    <div class="d-flex align-items-center">
                                                                        <a href="#">
                                                                            <img src="images/user/13.jpg"
                                                                                 alt="profile-img" class="img-fluid">
                                                                        </a>
                                                                        <div class="friend-info ms-3">
                                                                            <h5>Cory Ander</h5>
                                                                            <p class="mb-0">7 friends</p>
                                                                        </div>
                                                                    </div>
                                                                    <div class="card-header-toolbar d-flex align-items-center">
                                                                        <div class="dropdown">
                                                   <span class="dropdown-toggle btn btn-secondary me-2"
                                                         id="dropdownMenuButton22" data-bs-toggle="dropdown"
                                                         aria-expanded="true" role="button">
                                                   <i class="ri-check-line me-1 text-white"></i> Friend
                                                   </span>
                                                                            <div class="dropdown-menu dropdown-menu-right"
                                                                                 aria-labelledby="dropdownMenuButton22">
                                                                                <a class="dropdown-item" href="#">Get
                                                                                    Notification</a>
                                                                                <a class="dropdown-item" href="#">Close
                                                                                    Friend</a>
                                                                                <a class="dropdown-item" href="#">Unfollow</a>
                                                                                <a class="dropdown-item" href="#">Unfriend</a>
                                                                                <a class="dropdown-item"
                                                                                   href="#">Block</a>
                                                                            </div>
                                                                        </div>
                                                                    </div>
                                                                </div>
                                                            </div>
                                                        </div>
                                                        <div class="col-md-6 col-lg-6 mb-3">
                                                            <div class="iq-friendlist-block">
                                                                <div class="d-flex align-items-center justify-content-between">
                                                                    <div class="d-flex align-items-center">
                                                                        <a href="#">
                                                                            <img src="images/user/14.jpg"
                                                                                 alt="profile-img" class="img-fluid">
                                                                        </a>
                                                                        <div class="friend-info ms-3">
                                                                            <h5>Robin Banks</h5>
                                                                            <p class="mb-0">14 friends</p>
                                                                        </div>
                                                                    </div>
                                                                    <div class="card-header-toolbar d-flex align-items-center">
                                                                        <div class="dropdown">
                                                   <span class="dropdown-toggle btn btn-secondary me-2"
                                                         id="dropdownMenuButton23" data-bs-toggle="dropdown"
                                                         aria-expanded="true" role="button">
                                                   <i class="ri-check-line me-1 text-white"></i> Friend
                                                   </span>
                                                                            <div class="dropdown-menu dropdown-menu-right"
                                                                                 aria-labelledby="dropdownMenuButton23">
                                                                                <a class="dropdown-item" href="#">Get
                                                                                    Notification</a>
                                                                                <a class="dropdown-item" href="#">Close
                                                                                    Friend</a>
                                                                                <a class="dropdown-item" href="#">Unfollow</a>
                                                                                <a class="dropdown-item" href="#">Unfriend</a>
                                                                                <a class="dropdown-item"
                                                                                   href="#">Block</a>
                                                                            </div>
                                                                        </div>
                                                                    </div>
                                                                </div>
                                                            </div>
                                                        </div>
                                                        <div class="col-md-6 col-lg-6 mb-3">
                                                            <div class="iq-friendlist-block">
                                                                <div class="d-flex align-items-center justify-content-between">
                                                                    <div class="d-flex align-items-center">
                                                                        <a href="#">
                                                                            <img src="images/user/15.jpg"
                                                                                 alt="profile-img" class="img-fluid">
                                                                        </a>
                                                                        <div class="friend-info ms-3">
                                                                            <h5>Jimmy Changa</h5>
                                                                            <p class="mb-0">10 friends</p>
                                                                        </div>
                                                                    </div>
                                                                    <div class="card-header-toolbar d-flex align-items-center">
                                                                        <div class="dropdown">
                                                   <span class="dropdown-toggle btn btn-secondary me-2"
                                                         id="dropdownMenuButton24" data-bs-toggle="dropdown"
                                                         aria-expanded="true" role="button">
                                                   <i class="ri-check-line me-1 text-white"></i> Friend
                                                   </span>
                                                                            <div class="dropdown-menu dropdown-menu-right"
                                                                                 aria-labelledby="dropdownMenuButton24">
                                                                                <a class="dropdown-item" href="#">Get
                                                                                    Notification</a>
                                                                                <a class="dropdown-item" href="#">Close
                                                                                    Friend</a>
                                                                                <a class="dropdown-item" href="#">Unfollow</a>
                                                                                <a class="dropdown-item" href="#">Unfriend</a>
                                                                                <a class="dropdown-item"
                                                                                   href="#">Block</a>
                                                                            </div>
                                                                        </div>
                                                                    </div>
                                                                </div>
                                                            </div>
                                                        </div>
                                                        <div class="col-md-6 col-lg-6 mb-3">
                                                            <div class="iq-friendlist-block">
                                                                <div class="d-flex align-items-center justify-content-between">
                                                                    <div class="d-flex align-items-center">
                                                                        <a href="#">
                                                                            <img src="images/user/16.jpg"
                                                                                 alt="profile-img" class="img-fluid">
                                                                        </a>
                                                                        <div class="friend-info ms-3">
                                                                            <h5>Barry Wine</h5>
                                                                            <p class="mb-0">18 friends</p>
                                                                        </div>
                                                                    </div>
                                                                    <div class="card-header-toolbar d-flex align-items-center">
                                                                        <div class="dropdown">
                                                   <span class="dropdown-toggle btn btn-secondary me-2"
                                                         id="dropdownMenuButton25" data-bs-toggle="dropdown"
                                                         aria-expanded="true" role="button">
                                                   <i class="ri-check-line me-1 text-white"></i> Friend
                                                   </span>
                                                                            <div class="dropdown-menu dropdown-menu-right"
                                                                                 aria-labelledby="dropdownMenuButton25">
                                                                                <a class="dropdown-item" href="#">Get
                                                                                    Notification</a>
                                                                                <a class="dropdown-item" href="#">Close
                                                                                    Friend</a>
                                                                                <a class="dropdown-item" href="#">Unfollow</a>
                                                                                <a class="dropdown-item" href="#">Unfriend</a>
                                                                                <a class="dropdown-item"
                                                                                   href="#">Block</a>
                                                                            </div>
                                                                        </div>
                                                                    </div>
                                                                </div>
                                                            </div>
                                                        </div>
                                                        <div class="col-md-6 col-lg-6 mb-3">
                                                            <div class="iq-friendlist-block">
                                                                <div class="d-flex align-items-center justify-content-between">
                                                                    <div class="d-flex align-items-center">
                                                                        <a href="#">
                                                                            <img src="images/user/17.jpg"
                                                                                 alt="profile-img" class="img-fluid">
                                                                        </a>
                                                                        <div class="friend-info ms-3">
                                                                            <h5>Poppa Cherry</h5>
                                                                            <p class="mb-0">16 friends</p>
                                                                        </div>
                                                                    </div>
                                                                    <div class="card-header-toolbar d-flex align-items-center">
                                                                        <div class="dropdown">
                                                   <span class="dropdown-toggle btn btn-secondary me-2"
                                                         id="dropdownMenuButton26" data-bs-toggle="dropdown"
                                                         aria-expanded="true" role="button">
                                                   <i class="ri-check-line me-1 text-white"></i> Friend
                                                   </span>
                                                                            <div class="dropdown-menu dropdown-menu-right"
                                                                                 aria-labelledby="dropdownMenuButton26">
                                                                                <a class="dropdown-item" href="#">Get
                                                                                    Notification</a>
                                                                                <a class="dropdown-item" href="#">Close
                                                                                    Friend</a>
                                                                                <a class="dropdown-item" href="#">Unfollow</a>
                                                                                <a class="dropdown-item" href="#">Unfriend</a>
                                                                                <a class="dropdown-item"
                                                                                   href="#">Block</a>
                                                                            </div>
                                                                        </div>
                                                                    </div>
                                                                </div>
                                                            </div>
                                                        </div>
                                                        <div class="col-md-6 col-lg-6 mb-3">
                                                            <div class="iq-friendlist-block">
                                                                <div class="d-flex align-items-center justify-content-between">
                                                                    <div class="d-flex align-items-center">
                                                                        <a href="#">
                                                                            <img src="images/user/18.jpg"
                                                                                 alt="profile-img" class="img-fluid">
                                                                        </a>
                                                                        <div class="friend-info ms-3">
                                                                            <h5>Zack Lee</h5>
                                                                            <p class="mb-0">33 friends</p>
                                                                        </div>
                                                                    </div>
                                                                    <div class="card-header-toolbar d-flex align-items-center">
                                                                        <div class="dropdown">
                                                   <span class="dropdown-toggle btn btn-secondary me-2"
                                                         id="dropdownMenuButton27" data-bs-toggle="dropdown"
                                                         aria-expanded="true" role="button">
                                                   <i class="ri-check-line me-1 text-white"></i> Friend
                                                   </span>
                                                                            <div class="dropdown-menu dropdown-menu-right"
                                                                                 aria-labelledby="dropdownMenuButton27">
                                                                                <a class="dropdown-item" href="#">Get
                                                                                    Notification</a>
                                                                                <a class="dropdown-item" href="#">Close
                                                                                    Friend</a>
                                                                                <a class="dropdown-item" href="#">Unfollow</a>
                                                                                <a class="dropdown-item" href="#">Unfriend</a>
                                                                                <a class="dropdown-item"
                                                                                   href="#">Block</a>
                                                                            </div>
                                                                        </div>
                                                                    </div>
                                                                </div>
                                                            </div>
                                                        </div>
                                                        <div class="col-md-6 col-lg-6 mb-3">
                                                            <div class="iq-friendlist-block">
                                                                <div class="d-flex align-items-center justify-content-between">
                                                                    <div class="d-flex align-items-center">
                                                                        <a href="#">
                                                                            <img src="images/user/19.jpg"
                                                                                 alt="profile-img" class="img-fluid">
                                                                        </a>
                                                                        <div class="friend-info ms-3">
                                                                            <h5>Don Stairs</h5>
                                                                            <p class="mb-0">15 friends</p>
                                                                        </div>
                                                                    </div>
                                                                    <div class="card-header-toolbar d-flex align-items-center">
                                                                        <div class="dropdown">
                                                   <span class="dropdown-toggle btn btn-secondary me-2"
                                                         id="dropdownMenuButton28" data-bs-toggle="dropdown"
                                                         aria-expanded="true" role="button">
                                                   <i class="ri-check-line me-1 text-white"></i> Friend
                                                   </span>
                                                                            <div class="dropdown-menu dropdown-menu-right"
                                                                                 aria-labelledby="dropdownMenuButton28">
                                                                                <a class="dropdown-item" href="#">Get
                                                                                    Notification</a>
                                                                                <a class="dropdown-item" href="#">Close
                                                                                    Friend</a>
                                                                                <a class="dropdown-item" href="#">Unfollow</a>
                                                                                <a class="dropdown-item" href="#">Unfriend</a>
                                                                                <a class="dropdown-item"
                                                                                   href="#">Block</a>
                                                                            </div>
                                                                        </div>
                                                                    </div>
                                                                </div>
                                                            </div>
                                                        </div>
                                                        <div class="col-md-6 col-lg-6 mb-3">
                                                            <div class="iq-friendlist-block">
                                                                <div class="d-flex align-items-center justify-content-between">
                                                                    <div class="d-flex align-items-center">
                                                                        <a href="#">
                                                                            <img src="images/user/05.jpg"
                                                                                 alt="profile-img" class="img-fluid">
                                                                        </a>
                                                                        <div class="friend-info ms-3">
                                                                            <h5>Peter Pants</h5>
                                                                            <p class="mb-0">12 friends</p>
                                                                        </div>
                                                                    </div>
                                                                    <div class="card-header-toolbar d-flex align-items-center">
                                                                        <div class="dropdown">
                                                   <span class="dropdown-toggle btn btn-secondary me-2"
                                                         id="dropdownMenuButton29" data-bs-toggle="dropdown"
                                                         aria-expanded="true" role="button">
                                                   <i class="ri-check-line me-1 text-white"></i> Friend
                                                   </span>
                                                                            <div class="dropdown-menu dropdown-menu-right"
                                                                                 aria-labelledby="dropdownMenuButton29">
                                                                                <a class="dropdown-item" href="#">Get
                                                                                    Notification</a>
                                                                                <a class="dropdown-item" href="#">Close
                                                                                    Friend</a>
                                                                                <a class="dropdown-item" href="#">Unfollow</a>
                                                                                <a class="dropdown-item" href="#">Unfriend</a>
                                                                                <a class="dropdown-item"
                                                                                   href="#">Block</a>
                                                                            </div>
                                                                        </div>
                                                                    </div>
                                                                </div>
                                                            </div>
                                                        </div>
                                                        <div class="col-md-6 col-lg-6 mb-3">
                                                            <div class="iq-friendlist-block">
                                                                <div class="d-flex align-items-center justify-content-between">
                                                                    <div class="d-flex align-items-center">
                                                                        <a href="#">
                                                                            <img src="images/user/06.jpg"
                                                                                 alt="profile-img" class="img-fluid">
                                                                        </a>
                                                                        <div class="friend-info ms-3">
                                                                            <h5>Hal Appeno </h5>
                                                                            <p class="mb-0">13 friends</p>
                                                                        </div>
                                                                    </div>
                                                                    <div class="card-header-toolbar d-flex align-items-center">
                                                                        <div class="dropdown">
                                                   <span class="dropdown-toggle btn btn-secondary me-2"
                                                         id="dropdownMenuButton30" data-bs-toggle="dropdown"
                                                         aria-expanded="true" role="button">
                                                   <i class="ri-check-line me-1 text-white"></i> Friend
                                                   </span>
                                                                            <div class="dropdown-menu dropdown-menu-right"
                                                                                 aria-labelledby="dropdownMenuButton30">
                                                                                <a class="dropdown-item" href="#">Get
                                                                                    Notification</a>
                                                                                <a class="dropdown-item" href="#">Close
                                                                                    Friend</a>
                                                                                <a class="dropdown-item" href="#">Unfollow</a>
                                                                                <a class="dropdown-item" href="#">Unfriend</a>
                                                                                <a class="dropdown-item"
                                                                                   href="#">Block</a>
                                                                            </div>
                                                                        </div>
                                                                    </div>
                                                                </div>
                                                            </div>
                                                        </div>
                                                    </div>
                                                </div>
                                            </div>
                                            <div class="tab-pane fade" id="recently-add" role="tabpanel">
                                                <div class="card-body p-0">
                                                    <div class="row">
                                                        <div class="col-md-6 col-lg-6 mb-3">
                                                            <div class="iq-friendlist-block">
                                                                <div class="d-flex align-items-center justify-content-between">
                                                                    <div class="d-flex align-items-center">
                                                                        <a href="#">
                                                                            <img src="images/user/07.jpg"
                                                                                 alt="profile-img" class="img-fluid">
                                                                        </a>
                                                                        <div class="friend-info ms-3">
                                                                            <h5>Otto Matic</h5>
                                                                            <p class="mb-0">4 friends</p>
                                                                        </div>
                                                                    </div>
                                                                    <div class="card-header-toolbar d-flex align-items-center">
                                                                        <div class="dropdown">
                                                   <span class="dropdown-toggle btn btn-secondary me-2"
                                                         id="dropdownMenuButton31" data-bs-toggle="dropdown"
                                                         aria-expanded="true" role="button">
                                                   <i class="ri-check-line me-1 text-white"></i> Friend
                                                   </span>
                                                                            <div class="dropdown-menu dropdown-menu-right"
                                                                                 aria-labelledby="dropdownMenuButton31">
                                                                                <a class="dropdown-item" href="#">Get
                                                                                    Notification</a>
                                                                                <a class="dropdown-item" href="#">Close
                                                                                    Friend</a>
                                                                                <a class="dropdown-item" href="#">Unfollow</a>
                                                                                <a class="dropdown-item" href="#">Unfriend</a>
                                                                                <a class="dropdown-item"
                                                                                   href="#">Block</a>
                                                                            </div>
                                                                        </div>
                                                                    </div>
                                                                </div>
                                                            </div>
                                                        </div>
                                                        <div class="col-md-6 col-lg-6 mb-3">
                                                            <div class="iq-friendlist-block">
                                                                <div class="d-flex align-items-center justify-content-between">
                                                                    <div class="d-flex align-items-center">
                                                                        <a href="#">
                                                                            <img src="images/user/08.jpg"
                                                                                 alt="profile-img" class="img-fluid">
                                                                        </a>
                                                                        <div class="friend-info ms-3">
                                                                            <h5>Moe Fugga</h5>
                                                                            <p class="mb-0">16 friends</p>
                                                                        </div>
                                                                    </div>
                                                                    <div class="card-header-toolbar d-flex align-items-center">
                                                                        <div class="dropdown">
                                                   <span class="dropdown-toggle btn btn-secondary me-2"
                                                         id="dropdownMenuButton32" data-bs-toggle="dropdown"
                                                         aria-expanded="true" role="button">
                                                   <i class="ri-check-line me-1 text-white"></i> Friend
                                                   </span>
                                                                            <div class="dropdown-menu dropdown-menu-right"
                                                                                 aria-labelledby="dropdownMenuButton32">
                                                                                <a class="dropdown-item" href="#">Get
                                                                                    Notification</a>
                                                                                <a class="dropdown-item" href="#">Close
                                                                                    Friend</a>
                                                                                <a class="dropdown-item" href="#">Unfollow</a>
                                                                                <a class="dropdown-item" href="#">Unfriend</a>
                                                                                <a class="dropdown-item"
                                                                                   href="#">Block</a>
                                                                            </div>
                                                                        </div>
                                                                    </div>
                                                                </div>
                                                            </div>
                                                        </div>
                                                        <div class="col-md-6 col-lg-6 mb-3">
                                                            <div class="iq-friendlist-block">
                                                                <div class="d-flex align-items-center justify-content-between">
                                                                    <div class="d-flex align-items-center">
                                                                        <a href="#">
                                                                            <img src="images/user/09.jpg"
                                                                                 alt="profile-img" class="img-fluid">
                                                                        </a>
                                                                        <div class="friend-info ms-3">
                                                                            <h5>Tom Foolery</h5>
                                                                            <p class="mb-0">14 friends</p>
                                                                        </div>
                                                                    </div>
                                                                    <div class="card-header-toolbar d-flex align-items-center">
                                                                        <div class="dropdown">
                                                   <span class="dropdown-toggle btn btn-secondary me-2"
                                                         id="dropdownMenuButton33" data-bs-toggle="dropdown"
                                                         aria-expanded="true" role="button">
                                                   <i class="ri-check-line me-1 text-white"></i> Friend
                                                   </span>
                                                                            <div class="dropdown-menu dropdown-menu-right"
                                                                                 aria-labelledby="dropdownMenuButton33">
                                                                                <a class="dropdown-item" href="#">Get
                                                                                    Notification</a>
                                                                                <a class="dropdown-item" href="#">Close
                                                                                    Friend</a>
                                                                                <a class="dropdown-item" href="#">Unfollow</a>
                                                                                <a class="dropdown-item" href="#">Unfriend</a>
                                                                                <a class="dropdown-item"
                                                                                   href="#">Block</a>
                                                                            </div>
                                                                        </div>
                                                                    </div>
                                                                </div>
                                                            </div>
                                                        </div>
                                                        <div class="col-md-6 col-lg-6 mb-3">
                                                            <div class="iq-friendlist-block">
                                                                <div class="d-flex align-items-center justify-content-between">
                                                                    <div class="d-flex align-items-center">
                                                                        <a href="#">
                                                                            <img src="images/user/10.jpg"
                                                                                 alt="profile-img" class="img-fluid">
                                                                        </a>
                                                                        <div class="friend-info ms-3">
                                                                            <h5>Bud Wiser</h5>
                                                                            <p class="mb-0">16 friends</p>
                                                                        </div>
                                                                    </div>
                                                                    <div class="card-header-toolbar d-flex align-items-center">
                                                                        <div class="dropdown">
                                                   <span class="dropdown-toggle btn btn-secondary me-2"
                                                         id="dropdownMenuButton34" data-bs-toggle="dropdown"
                                                         aria-expanded="true" role="button">
                                                   <i class="ri-check-line me-1 text-white"></i> Friend
                                                   </span>
                                                                            <div class="dropdown-menu dropdown-menu-right"
                                                                                 aria-labelledby="dropdownMenuButton34">
                                                                                <a class="dropdown-item" href="#">Get
                                                                                    Notification</a>
                                                                                <a class="dropdown-item" href="#">Close
                                                                                    Friend</a>
                                                                                <a class="dropdown-item" href="#">Unfollow</a>
                                                                                <a class="dropdown-item" href="#">Unfriend</a>
                                                                                <a class="dropdown-item"
                                                                                   href="#">Block</a>
                                                                            </div>
                                                                        </div>
                                                                    </div>
                                                                </div>
                                                            </div>
                                                        </div>
                                                        <div class="col-md-6 col-lg-6 mb-3">
                                                            <div class="iq-friendlist-block">
                                                                <div class="d-flex align-items-center justify-content-between">
                                                                    <div class="d-flex align-items-center">
                                                                        <a href="#">
                                                                            <img src="images/user/15.jpg"
                                                                                 alt="profile-img" class="img-fluid">
                                                                        </a>
                                                                        <div class="friend-info ms-3">
                                                                            <h5>Polly Tech</h5>
                                                                            <p class="mb-0">10 friends</p>
                                                                        </div>
                                                                    </div>
                                                                    <div class="card-header-toolbar d-flex align-items-center">
                                                                        <div class="dropdown">
                                                   <span class="dropdown-toggle btn btn-secondary me-2"
                                                         id="dropdownMenuButton35" data-bs-toggle="dropdown"
                                                         aria-expanded="true" role="button">
                                                   <i class="ri-check-line me-1 text-white"></i> Friend
                                                   </span>
                                                                            <div class="dropdown-menu dropdown-menu-right"
                                                                                 aria-labelledby="dropdownMenuButton35">
                                                                                <a class="dropdown-item" href="#">Get
                                                                                    Notification</a>
                                                                                <a class="dropdown-item" href="#">Close
                                                                                    Friend</a>
                                                                                <a class="dropdown-item" href="#">Unfollow</a>
                                                                                <a class="dropdown-item" href="#">Unfriend</a>
                                                                                <a class="dropdown-item"
                                                                                   href="#">Block</a>
                                                                            </div>
                                                                        </div>
                                                                    </div>
                                                                </div>
                                                            </div>
                                                        </div>
                                                        <div class="col-md-6 col-lg-6 mb-3">
                                                            <div class="iq-friendlist-block">
                                                                <div class="d-flex align-items-center justify-content-between">
                                                                    <div class="d-flex align-items-center">
                                                                        <a href="#">
                                                                            <img src="images/user/16.jpg"
                                                                                 alt="profile-img" class="img-fluid">
                                                                        </a>
                                                                        <div class="friend-info ms-3">
                                                                            <h5>Holly Graham</h5>
                                                                            <p class="mb-0">8 friends</p>
                                                                        </div>
                                                                    </div>
                                                                    <div class="card-header-toolbar d-flex align-items-center">
                                                                        <div class="dropdown">
                                                   <span class="dropdown-toggle btn btn-secondary me-2"
                                                         id="dropdownMenuButton36" data-bs-toggle="dropdown"
                                                         aria-expanded="true" role="button">
                                                   <i class="ri-check-line me-1 text-white"></i> Friend
                                                   </span>
                                                                            <div class="dropdown-menu dropdown-menu-right"
                                                                                 aria-labelledby="dropdownMenuButton36">
                                                                                <a class="dropdown-item" href="#">Get
                                                                                    Notification</a>
                                                                                <a class="dropdown-item" href="#">Close
                                                                                    Friend</a>
                                                                                <a class="dropdown-item" href="#">Unfollow</a>
                                                                                <a class="dropdown-item" href="#">Unfriend</a>
                                                                                <a class="dropdown-item"
                                                                                   href="#">Block</a>
                                                                            </div>
                                                                        </div>
                                                                    </div>
                                                                </div>
                                                            </div>
                                                        </div>
                                                        <div class="col-md-6 col-lg-6 mb-3">
                                                            <div class="iq-friendlist-block">
                                                                <div class="d-flex align-items-center justify-content-between">
                                                                    <div class="d-flex align-items-center">
                                                                        <a href="#">
                                                                            <img src="images/user/17.jpg"
                                                                                 alt="profile-img" class="img-fluid">
                                                                        </a>
                                                                        <div class="friend-info ms-3">
                                                                            <h5>Tara Zona</h5>
                                                                            <p class="mb-0">5 friends</p>
                                                                        </div>
                                                                    </div>
                                                                    <div class="card-header-toolbar d-flex align-items-center">
                                                                        <div class="dropdown">
                                                   <span class="dropdown-toggle btn btn-secondary me-2"
                                                         id="dropdownMenuButton37" data-bs-toggle="dropdown"
                                                         aria-expanded="true" role="button">
                                                   <i class="ri-check-line me-1 text-white"></i> Friend
                                                   </span>
                                                                            <div class="dropdown-menu dropdown-menu-right"
                                                                                 aria-labelledby="dropdownMenuButton37">
                                                                                <a class="dropdown-item" href="#">Get
                                                                                    Notification</a>
                                                                                <a class="dropdown-item" href="#">Close
                                                                                    Friend</a>
                                                                                <a class="dropdown-item" href="#">Unfollow</a>
                                                                                <a class="dropdown-item" href="#">Unfriend</a>
                                                                                <a class="dropdown-item"
                                                                                   href="#">Block</a>
                                                                            </div>
                                                                        </div>
                                                                    </div>
                                                                </div>
                                                            </div>
                                                        </div>
                                                        <div class="col-md-6 col-lg-6 mb-3">
                                                            <div class="iq-friendlist-block">
                                                                <div class="d-flex align-items-center justify-content-between">
                                                                    <div class="d-flex align-items-center">
                                                                        <a href="#">
                                                                            <img src="images/user/18.jpg"
                                                                                 alt="profile-img" class="img-fluid">
                                                                        </a>
                                                                        <div class="friend-info ms-3">
                                                                            <h5>Barry Cade</h5>
                                                                            <p class="mb-0">20 friends</p>
                                                                        </div>
                                                                    </div>
                                                                    <div class="card-header-toolbar d-flex align-items-center">
                                                                        <div class="dropdown">
                                                   <span class="dropdown-toggle btn btn-secondary me-2"
                                                         id="dropdownMenuButton38" data-bs-toggle="dropdown"
                                                         aria-expanded="true" role="button">
                                                   <i class="ri-check-line me-1 text-white"></i> Friend
                                                   </span>
                                                                            <div class="dropdown-menu dropdown-menu-right"
                                                                                 aria-labelledby="dropdownMenuButton38">
                                                                                <a class="dropdown-item" href="#">Get
                                                                                    Notification</a>
                                                                                <a class="dropdown-item" href="#">Close
                                                                                    Friend</a>
                                                                                <a class="dropdown-item" href="#">Unfollow</a>
                                                                                <a class="dropdown-item" href="#">Unfriend</a>
                                                                                <a class="dropdown-item"
                                                                                   href="#">Block</a>
                                                                            </div>
                                                                        </div>
                                                                    </div>
                                                                </div>
                                                            </div>
                                                        </div>
                                                    </div>
                                                </div>
                                            </div>
                                            <div class="tab-pane fade" id="closefriends" role="tabpanel">
                                                <div class="card-body p-0">
                                                    <div class="row">
                                                        <div class="col-md-6 col-lg-6 mb-3">
                                                            <div class="iq-friendlist-block">
                                                                <div class="d-flex align-items-center justify-content-between">
                                                                    <div class="d-flex align-items-center">
                                                                        <a href="#">
                                                                            <img src="images/user/19.jpg"
                                                                                 alt="profile-img" class="img-fluid">
                                                                        </a>
                                                                        <div class="friend-info ms-3">
                                                                            <h5>Bud Wiser</h5>
                                                                            <p class="mb-0">32 friends</p>
                                                                        </div>
                                                                    </div>
                                                                    <div class="card-header-toolbar d-flex align-items-center">
                                                                        <div class="dropdown">
                                                   <span class="dropdown-toggle btn btn-secondary me-2"
                                                         id="dropdownMenuButton39" data-bs-toggle="dropdown"
                                                         aria-expanded="true" role="button">
                                                   <i class="ri-check-line me-1 text-white"></i> Friend
                                                   </span>
                                                                            <div class="dropdown-menu dropdown-menu-right"
                                                                                 aria-labelledby="dropdownMenuButton39">
                                                                                <a class="dropdown-item" href="#">Get
                                                                                    Notification</a>
                                                                                <a class="dropdown-item" href="#">Close
                                                                                    Friend</a>
                                                                                <a class="dropdown-item" href="#">Unfollow</a>
                                                                                <a class="dropdown-item" href="#">Unfriend</a>
                                                                                <a class="dropdown-item"
                                                                                   href="#">Block</a>
                                                                            </div>
                                                                        </div>
                                                                    </div>
                                                                </div>
                                                            </div>
                                                        </div>
                                                        <div class="col-md-6 col-lg-6 mb-3">
                                                            <div class="iq-friendlist-block">
                                                                <div class="d-flex align-items-center justify-content-between">
                                                                    <div class="d-flex align-items-center">
                                                                        <a href="#">
                                                                            <img src="images/user/05.jpg"
                                                                                 alt="profile-img" class="img-fluid">
                                                                        </a>
                                                                        <div class="friend-info ms-3">
                                                                            <h5>Otto Matic</h5>
                                                                            <p class="mb-0">9 friends</p>
                                                                        </div>
                                                                    </div>
                                                                    <div class="card-header-toolbar d-flex align-items-center">
                                                                        <div class="dropdown">
                                                   <span class="dropdown-toggle btn btn-secondary me-2"
                                                         id="dropdownMenuButton40" data-bs-toggle="dropdown"
                                                         aria-expanded="true" role="button">
                                                   <i class="ri-check-line me-1 text-white"></i> Friend
                                                   </span>
                                                                            <div class="dropdown-menu dropdown-menu-right"
                                                                                 aria-labelledby="dropdownMenuButton40">
                                                                                <a class="dropdown-item" href="#">Get
                                                                                    Notification</a>
                                                                                <a class="dropdown-item" href="#">Close
                                                                                    Friend</a>
                                                                                <a class="dropdown-item" href="#">Unfollow</a>
                                                                                <a class="dropdown-item" href="#">Unfriend</a>
                                                                                <a class="dropdown-item"
                                                                                   href="#">Block</a>
                                                                            </div>
                                                                        </div>
                                                                    </div>
                                                                </div>
                                                            </div>
                                                        </div>
                                                        <div class="col-md-6 col-lg-6 mb-3">
                                                            <div class="iq-friendlist-block">
                                                                <div class="d-flex align-items-center justify-content-between">
                                                                    <div class="d-flex align-items-center">
                                                                        <a href="#">
                                                                            <img src="images/user/06.jpg"
                                                                                 alt="profile-img" class="img-fluid">
                                                                        </a>
                                                                        <div class="friend-info ms-3">
                                                                            <h5>Peter Pants</h5>
                                                                            <p class="mb-0">2 friends</p>
                                                                        </div>
                                                                    </div>
                                                                    <div class="card-header-toolbar d-flex align-items-center">
                                                                        <div class="dropdown">
                                                   <span class="dropdown-toggle btn btn-secondary me-2"
                                                         id="dropdownMenuButton41" data-bs-toggle="dropdown"
                                                         aria-expanded="true" role="button">
                                                   <i class="ri-check-line me-1 text-white"></i> Friend
                                                   </span>
                                                                            <div class="dropdown-menu dropdown-menu-right"
                                                                                 aria-labelledby="dropdownMenuButton41">
                                                                                <a class="dropdown-item" href="#">Get
                                                                                    Notification</a>
                                                                                <a class="dropdown-item" href="#">Close
                                                                                    Friend</a>
                                                                                <a class="dropdown-item" href="#">Unfollow</a>
                                                                                <a class="dropdown-item" href="#">Unfriend</a>
                                                                                <a class="dropdown-item"
                                                                                   href="#">Block</a>
                                                                            </div>
                                                                        </div>
                                                                    </div>
                                                                </div>
                                                            </div>
                                                        </div>
                                                        <div class="col-md-6 col-lg-6 mb-3">
                                                            <div class="iq-friendlist-block">
                                                                <div class="d-flex align-items-center justify-content-between">
                                                                    <div class="d-flex align-items-center">
                                                                        <a href="#">
                                                                            <img src="images/user/07.jpg"
                                                                                 alt="profile-img" class="img-fluid">
                                                                        </a>
                                                                        <div class="friend-info ms-3">
                                                                            <h5>Zack Lee</h5>
                                                                            <p class="mb-0">15 friends</p>
                                                                        </div>
                                                                    </div>
                                                                    <div class="card-header-toolbar d-flex align-items-center">
                                                                        <div class="dropdown">
                                                   <span class="dropdown-toggle btn btn-secondary me-2"
                                                         id="dropdownMenuButton42" data-bs-toggle="dropdown"
                                                         aria-expanded="true" role="button">
                                                   <i class="ri-check-line me-1 text-white"></i> Friend
                                                   </span>
                                                                            <div class="dropdown-menu dropdown-menu-right"
                                                                                 aria-labelledby="dropdownMenuButton42">
                                                                                <a class="dropdown-item" href="#">Get
                                                                                    Notification</a>
                                                                                <a class="dropdown-item" href="#">Close
                                                                                    Friend</a>
                                                                                <a class="dropdown-item" href="#">Unfollow</a>
                                                                                <a class="dropdown-item" href="#">Unfriend</a>
                                                                                <a class="dropdown-item"
                                                                                   href="#">Block</a>
                                                                            </div>
                                                                        </div>
                                                                    </div>
                                                                </div>
                                                            </div>
                                                        </div>
                                                        <div class="col-md-6 col-lg-6 mb-3">
                                                            <div class="iq-friendlist-block">
                                                                <div class="d-flex align-items-center justify-content-between">
                                                                    <div class="d-flex align-items-center">
                                                                        <a href="#">
                                                                            <img src="images/user/08.jpg"
                                                                                 alt="profile-img" class="img-fluid">
                                                                        </a>
                                                                        <div class="friend-info ms-3">
                                                                            <h5>Barry Wine</h5>
                                                                            <p class="mb-0">36 friends</p>
                                                                        </div>
                                                                    </div>
                                                                    <div class="card-header-toolbar d-flex align-items-center">
                                                                        <div class="dropdown">
                                                   <span class="dropdown-toggle btn btn-secondary me-2"
                                                         id="dropdownMenuButton43" data-bs-toggle="dropdown"
                                                         aria-expanded="true" role="button">
                                                   <i class="ri-check-line me-1 text-white"></i> Friend
                                                   </span>
                                                                            <div class="dropdown-menu dropdown-menu-right"
                                                                                 aria-labelledby="dropdownMenuButton43">
                                                                                <a class="dropdown-item" href="#">Get
                                                                                    Notification</a>
                                                                                <a class="dropdown-item" href="#">Close
                                                                                    Friend</a>
                                                                                <a class="dropdown-item" href="#">Unfollow</a>
                                                                                <a class="dropdown-item" href="#">Unfriend</a>
                                                                                <a class="dropdown-item"
                                                                                   href="#">Block</a>
                                                                            </div>
                                                                        </div>
                                                                    </div>
                                                                </div>
                                                            </div>
                                                        </div>
                                                        <div class="col-md-6 col-lg-6 mb-3">
                                                            <div class="iq-friendlist-block">
                                                                <div class="d-flex align-items-center justify-content-between">
                                                                    <div class="d-flex align-items-center">
                                                                        <a href="#">
                                                                            <img src="images/user/09.jpg"
                                                                                 alt="profile-img" class="img-fluid">
                                                                        </a>
                                                                        <div class="friend-info ms-3">
                                                                            <h5>Robin Banks</h5>
                                                                            <p class="mb-0">22 friends</p>
                                                                        </div>
                                                                    </div>
                                                                    <div class="card-header-toolbar d-flex align-items-center">
                                                                        <div class="dropdown">
                                                   <span class="dropdown-toggle btn btn-secondary me-2"
                                                         id="dropdownMenuButton44" data-bs-toggle="dropdown"
                                                         aria-expanded="true" role="button">
                                                   <i class="ri-check-line me-1 text-white"></i> Friend
                                                   </span>
                                                                            <div class="dropdown-menu dropdown-menu-right"
                                                                                 aria-labelledby="dropdownMenuButton44">
                                                                                <a class="dropdown-item" href="#">Get
                                                                                    Notification</a>
                                                                                <a class="dropdown-item" href="#">Close
                                                                                    Friend</a>
                                                                                <a class="dropdown-item" href="#">Unfollow</a>
                                                                                <a class="dropdown-item" href="#">Unfriend</a>
                                                                                <a class="dropdown-item"
                                                                                   href="#">Block</a>
                                                                            </div>
                                                                        </div>
                                                                    </div>
                                                                </div>
                                                            </div>
                                                        </div>
                                                        <div class="col-md-6 col-lg-6 mb-3">
                                                            <div class="iq-friendlist-block">
                                                                <div class="d-flex align-items-center justify-content-between">
                                                                    <div class="d-flex align-items-center">
                                                                        <a href="#">
                                                                            <img src="images/user/10.jpg"
                                                                                 alt="profile-img" class="img-fluid">
                                                                        </a>
                                                                        <div class="friend-info ms-3">
                                                                            <h5>Cory Ander</h5>
                                                                            <p class="mb-0">18 friends</p>
                                                                        </div>
                                                                    </div>
                                                                    <div class="card-header-toolbar d-flex align-items-center">
                                                                        <div class="dropdown">
                                                   <span class="dropdown-toggle btn btn-secondary me-2"
                                                         id="dropdownMenuButton45" data-bs-toggle="dropdown"
                                                         aria-expanded="true" role="button">
                                                   <i class="ri-check-line me-1 text-white"></i> Friend
                                                   </span>
                                                                            <div class="dropdown-menu dropdown-menu-right"
                                                                                 aria-labelledby="dropdownMenuButton45">
                                                                                <a class="dropdown-item" href="#">Get
                                                                                    Notification</a>
                                                                                <a class="dropdown-item" href="#">Close
                                                                                    Friend</a>
                                                                                <a class="dropdown-item" href="#">Unfollow</a>
                                                                                <a class="dropdown-item" href="#">Unfriend</a>
                                                                                <a class="dropdown-item"
                                                                                   href="#">Block</a>
                                                                            </div>
                                                                        </div>
                                                                    </div>
                                                                </div>
                                                            </div>
                                                        </div>
                                                        <div class="col-md-6 col-lg-6 mb-3">
                                                            <div class="iq-friendlist-block">
                                                                <div class="d-flex align-items-center justify-content-between">
                                                                    <div class="d-flex align-items-center">
                                                                        <a href="#">
                                                                            <img src="images/user/15.jpg"
                                                                                 alt="profile-img" class="img-fluid">
                                                                        </a>
                                                                        <div class="friend-info ms-3">
                                                                            <h5>Moe Fugga</h5>
                                                                            <p class="mb-0">12 friends</p>
                                                                        </div>
                                                                    </div>
                                                                    <div class="card-header-toolbar d-flex align-items-center">
                                                                        <div class="dropdown">
                                                   <span class="dropdown-toggle btn btn-secondary me-2"
                                                         id="dropdownMenuButton46" data-bs-toggle="dropdown"
                                                         aria-expanded="true" role="button">
                                                   <i class="ri-check-line me-1 text-white"></i> Friend
                                                   </span>
                                                                            <div class="dropdown-menu dropdown-menu-right"
                                                                                 aria-labelledby="dropdownMenuButton46">
                                                                                <a class="dropdown-item" href="#">Get
                                                                                    Notification</a>
                                                                                <a class="dropdown-item" href="#">Close
                                                                                    Friend</a>
                                                                                <a class="dropdown-item" href="#">Unfollow</a>
                                                                                <a class="dropdown-item" href="#">Unfriend</a>
                                                                                <a class="dropdown-item"
                                                                                   href="#">Block</a>
                                                                            </div>
                                                                        </div>
                                                                    </div>
                                                                </div>
                                                            </div>
                                                        </div>
                                                        <div class="col-md-6 col-lg-6 mb-3">
                                                            <div class="iq-friendlist-block">
                                                                <div class="d-flex align-items-center justify-content-between">
                                                                    <div class="d-flex align-items-center">
                                                                        <a href="#">
                                                                            <img src="images/user/16.jpg"
                                                                                 alt="profile-img" class="img-fluid">
                                                                        </a>
                                                                        <div class="friend-info ms-3">
                                                                            <h5>Polly Tech</h5>
                                                                            <p class="mb-0">30 friends</p>
                                                                        </div>
                                                                    </div>
                                                                    <div class="card-header-toolbar d-flex align-items-center">
                                                                        <div class="dropdown">
                                                   <span class="dropdown-toggle btn btn-secondary me-2"
                                                         id="dropdownMenuButton47" data-bs-toggle="dropdown"
                                                         aria-expanded="true" role="button">
                                                   <i class="ri-check-line me-1 text-white"></i> Friend
                                                   </span>
                                                                            <div class="dropdown-menu dropdown-menu-right"
                                                                                 aria-labelledby="dropdownMenuButton47">
                                                                                <a class="dropdown-item" href="#">Get
                                                                                    Notification</a>
                                                                                <a class="dropdown-item" href="#">Close
                                                                                    Friend</a>
                                                                                <a class="dropdown-item" href="#">Unfollow</a>
                                                                                <a class="dropdown-item" href="#">Unfriend</a>
                                                                                <a class="dropdown-item"
                                                                                   href="#">Block</a>
                                                                            </div>
                                                                        </div>
                                                                    </div>
                                                                </div>
                                                            </div>
                                                        </div>
                                                        <div class="col-md-6 col-lg-6 mb-3">
                                                            <div class="iq-friendlist-block">
                                                                <div class="d-flex align-items-center justify-content-between">
                                                                    <div class="d-flex align-items-center">
                                                                        <a href="#">
                                                                            <img src="images/user/17.jpg"
                                                                                 alt="profile-img" class="img-fluid">
                                                                        </a>
                                                                        <div class="friend-info ms-3">
                                                                            <h5>Hal Appeno</h5>
                                                                            <p class="mb-0">25 friends</p>
                                                                        </div>
                                                                    </div>
                                                                    <div class="card-header-toolbar d-flex align-items-center">
                                                                        <div class="dropdown">
                                                   <span class="dropdown-toggle btn btn-secondary me-2"
                                                         id="dropdownMenuButton48" data-bs-toggle="dropdown"
                                                         aria-expanded="true" role="button">
                                                   <i class="ri-check-line me-1 text-white"></i> Friend
                                                   </span>
                                                                            <div class="dropdown-menu dropdown-menu-right"
                                                                                 aria-labelledby="dropdownMenuButton48">
                                                                                <a class="dropdown-item" href="#">Get
                                                                                    Notification</a>
                                                                                <a class="dropdown-item" href="#">Close
                                                                                    Friend</a>
                                                                                <a class="dropdown-item" href="#">Unfollow</a>
                                                                                <a class="dropdown-item" href="#">Unfriend</a>
                                                                                <a class="dropdown-item"
                                                                                   href="#">Block</a>
                                                                            </div>
                                                                        </div>
                                                                    </div>
                                                                </div>
                                                            </div>
                                                        </div>
                                                    </div>
                                                </div>
                                            </div>
                                            <div class="tab-pane fade" id="home-town" role="tabpanel">
                                                <div class="card-body p-0">
                                                    <div class="row">
                                                        <div class="col-md-6 col-lg-6 mb-3">
                                                            <div class="iq-friendlist-block">
                                                                <div class="d-flex align-items-center justify-content-between">
                                                                    <div class="d-flex align-items-center">
                                                                        <a href="#">
                                                                            <img src="images/user/18.jpg"
                                                                                 alt="profile-img" class="img-fluid">
                                                                        </a>
                                                                        <div class="friend-info ms-3">
                                                                            <h5>Paul Molive</h5>
                                                                            <p class="mb-0">14 friends</p>
                                                                        </div>
                                                                    </div>
                                                                    <div class="card-header-toolbar d-flex align-items-center">
                                                                        <div class="dropdown">
                                                   <span class="dropdown-toggle btn btn-secondary me-2"
                                                         id="dropdownMenuButton49" data-bs-toggle="dropdown"
                                                         aria-expanded="true" role="button">
                                                   <i class="ri-check-line me-1 text-white"></i> Friend
                                                   </span>
                                                                            <div class="dropdown-menu dropdown-menu-right"
                                                                                 aria-labelledby="dropdownMenuButton49">
                                                                                <a class="dropdown-item" href="#">Get
                                                                                    Notification</a>
                                                                                <a class="dropdown-item" href="#">Close
                                                                                    Friend</a>
                                                                                <a class="dropdown-item" href="#">Unfollow</a>
                                                                                <a class="dropdown-item" href="#">Unfriend</a>
                                                                                <a class="dropdown-item"
                                                                                   href="#">Block</a>
                                                                            </div>
                                                                        </div>
                                                                    </div>
                                                                </div>
                                                            </div>
                                                        </div>
                                                        <div class="col-md-6 col-lg-6 mb-3">
                                                            <div class="iq-friendlist-block">
                                                                <div class="d-flex align-items-center justify-content-between">
                                                                    <div class="d-flex align-items-center">
                                                                        <a href="#">
                                                                            <img src="images/user/19.jpg"
                                                                                 alt="profile-img" class="img-fluid">
                                                                        </a>
                                                                        <div class="friend-info ms-3">
                                                                            <h5>Paige Turner</h5>
                                                                            <p class="mb-0">8 friends</p>
                                                                        </div>
                                                                    </div>
                                                                    <div class="card-header-toolbar d-flex align-items-center">
                                                                        <div class="dropdown">
                                                   <span class="dropdown-toggle btn btn-secondary me-2"
                                                         id="dropdownMenuButton50" data-bs-toggle="dropdown"
                                                         aria-expanded="true" role="button">
                                                   <i class="ri-check-line me-1 text-white"></i> Friend
                                                   </span>
                                                                            <div class="dropdown-menu dropdown-menu-right"
                                                                                 aria-labelledby="dropdownMenuButton50">
                                                                                <a class="dropdown-item" href="#">Get
                                                                                    Notification</a>
                                                                                <a class="dropdown-item" href="#">Close
                                                                                    Friend</a>
                                                                                <a class="dropdown-item" href="#">Unfollow</a>
                                                                                <a class="dropdown-item" href="#">Unfriend</a>
                                                                                <a class="dropdown-item"
                                                                                   href="#">Block</a>
                                                                            </div>
                                                                        </div>
                                                                    </div>
                                                                </div>
                                                            </div>
                                                        </div>
                                                        <div class="col-md-6 col-lg-6 mb-3">
                                                            <div class="iq-friendlist-block">
                                                                <div class="d-flex align-items-center justify-content-between">
                                                                    <div class="d-flex align-items-center">
                                                                        <a href="#">
                                                                            <img src="images/user/05.jpg"
                                                                                 alt="profile-img" class="img-fluid">
                                                                        </a>
                                                                        <div class="friend-info ms-3">
                                                                            <h5>Barb Ackue</h5>
                                                                            <p class="mb-0">23 friends</p>
                                                                        </div>
                                                                    </div>
                                                                    <div class="card-header-toolbar d-flex align-items-center">
                                                                        <div class="dropdown">
                                                   <span class="dropdown-toggle btn btn-secondary me-2"
                                                         id="dropdownMenuButton51" data-bs-toggle="dropdown"
                                                         aria-expanded="true" role="button">
                                                   <i class="ri-check-line me-1 text-white"></i> Friend
                                                   </span>
                                                                            <div class="dropdown-menu dropdown-menu-right"
                                                                                 aria-labelledby="dropdownMenuButton51">
                                                                                <a class="dropdown-item" href="#">Get
                                                                                    Notification</a>
                                                                                <a class="dropdown-item" href="#">Close
                                                                                    Friend</a>
                                                                                <a class="dropdown-item" href="#">Unfollow</a>
                                                                                <a class="dropdown-item" href="#">Unfriend</a>
                                                                                <a class="dropdown-item"
                                                                                   href="#">Block</a>
                                                                            </div>
                                                                        </div>
                                                                    </div>
                                                                </div>
                                                            </div>
                                                        </div>
                                                        <div class="col-md-6 col-lg-6 mb-3">
                                                            <div class="iq-friendlist-block">
                                                                <div class="d-flex align-items-center justify-content-between">
                                                                    <div class="d-flex align-items-center">
                                                                        <a href="#">
                                                                            <img src="images/user/06.jpg"
                                                                                 alt="profile-img" class="img-fluid">
                                                                        </a>
                                                                        <div class="friend-info ms-3">
                                                                            <h5>Ira Membrit</h5>
                                                                            <p class="mb-0">16 friends</p>
                                                                        </div>
                                                                    </div>
                                                                    <div class="card-header-toolbar d-flex align-items-center">
                                                                        <div class="dropdown">
                                                   <span class="dropdown-toggle btn btn-secondary me-2"
                                                         id="dropdownMenuButton52" data-bs-toggle="dropdown"
                                                         aria-expanded="true" role="button">
                                                   <i class="ri-check-line me-1 text-white"></i> Friend
                                                   </span>
                                                                            <div class="dropdown-menu dropdown-menu-right"
                                                                                 aria-labelledby="dropdownMenuButton52">
                                                                                <a class="dropdown-item" href="#">Get
                                                                                    Notification</a>
                                                                                <a class="dropdown-item" href="#">Close
                                                                                    Friend</a>
                                                                                <a class="dropdown-item" href="#">Unfollow</a>
                                                                                <a class="dropdown-item" href="#">Unfriend</a>
                                                                                <a class="dropdown-item"
                                                                                   href="#">Block</a>
                                                                            </div>
                                                                        </div>
                                                                    </div>
                                                                </div>
                                                            </div>
                                                        </div>
                                                        <div class="col-md-6 col-lg-6 mb-3">
                                                            <div class="iq-friendlist-block">
                                                                <div class="d-flex align-items-center justify-content-between">
                                                                    <div class="d-flex align-items-center">
                                                                        <a href="#">
                                                                            <img src="images/user/07.jpg"
                                                                                 alt="profile-img" class="img-fluid">
                                                                        </a>
                                                                        <div class="friend-info ms-3">
                                                                            <h5>Maya Didas</h5>
                                                                            <p class="mb-0">12 friends</p>
                                                                        </div>
                                                                    </div>
                                                                    <div class="card-header-toolbar d-flex align-items-center">
                                                                        <div class="dropdown">
                                                   <span class="dropdown-toggle btn btn-secondary me-2"
                                                         id="dropdownMenuButton53" data-bs-toggle="dropdown"
                                                         aria-expanded="true" role="button">
                                                   <i class="ri-check-line me-1 text-white"></i> Friend
                                                   </span>
                                                                            <div class="dropdown-menu dropdown-menu-right"
                                                                                 aria-labelledby="dropdownMenuButton53">
                                                                                <a class="dropdown-item" href="#">Get
                                                                                    Notification</a>
                                                                                <a class="dropdown-item" href="#">Close
                                                                                    Friend</a>
                                                                                <a class="dropdown-item" href="#">Unfollow</a>
                                                                                <a class="dropdown-item" href="#">Unfriend</a>
                                                                                <a class="dropdown-item"
                                                                                   href="#">Block</a>
                                                                            </div>
                                                                        </div>
                                                                    </div>
                                                                </div>
                                                            </div>
                                                        </div>
                                                    </div>
                                                </div>
                                            </div>
                                            <div class="tab-pane fade" id="following" role="tabpanel">
                                                <div class="card-body p-0">
                                                    <div class="row">
                                                        <div class="col-md-6 col-lg-6 mb-3">
                                                            <div class="iq-friendlist-block">
                                                                <div class="d-flex align-items-center justify-content-between">
                                                                    <div class="d-flex align-items-center">
                                                                        <a href="#">
                                                                            <img src="images/user/05.jpg"
                                                                                 alt="profile-img" class="img-fluid">
                                                                        </a>
                                                                        <div class="friend-info ms-3">
                                                                            <h5>Maya Didas</h5>
                                                                            <p class="mb-0">20 friends</p>
                                                                        </div>
                                                                    </div>
                                                                    <div class="card-header-toolbar d-flex align-items-center">
                                                                        <div class="dropdown">
                                                   <span class="dropdown-toggle btn btn-secondary me-2"
                                                         id="dropdownMenuButton54" data-bs-toggle="dropdown"
                                                         aria-expanded="true" role="button">
                                                   <i class="ri-check-line me-1 text-white"></i> Friend
                                                   </span>
                                                                            <div class="dropdown-menu dropdown-menu-right"
                                                                                 aria-labelledby="dropdownMenuButton54">
                                                                                <a class="dropdown-item" href="#">Get
                                                                                    Notification</a>
                                                                                <a class="dropdown-item" href="#">Close
                                                                                    Friend</a>
                                                                                <a class="dropdown-item" href="#">Unfollow</a>
                                                                                <a class="dropdown-item" href="#">Unfriend</a>
                                                                                <a class="dropdown-item"
                                                                                   href="#">Block</a>
                                                                            </div>
                                                                        </div>
                                                                    </div>
                                                                </div>
                                                            </div>
                                                        </div>
                                                        <div class="col-md-6 col-lg-6 mb-3">
                                                            <div class="iq-friendlist-block">
                                                                <div class="d-flex align-items-center justify-content-between">
                                                                    <div class="d-flex align-items-center">
                                                                        <a href="#">
                                                                            <img src="images/user/06.jpg"
                                                                                 alt="profile-img" class="img-fluid">
                                                                        </a>
                                                                        <div class="friend-info ms-3">
                                                                            <h5>Monty Carlo</h5>
                                                                            <p class="mb-0">3 friends</p>
                                                                        </div>
                                                                    </div>
                                                                    <div class="card-header-toolbar d-flex align-items-center">
                                                                        <div class="dropdown">
                                                   <span class="dropdown-toggle btn btn-secondary me-2"
                                                         id="dropdownMenuButton55" data-bs-toggle="dropdown"
                                                         aria-expanded="true" role="button">
                                                   <i class="ri-check-line me-1 text-white"></i> Friend
                                                   </span>
                                                                            <div class="dropdown-menu dropdown-menu-right"
                                                                                 aria-labelledby="dropdownMenuButton55">
                                                                                <a class="dropdown-item" href="#">Get
                                                                                    Notification</a>
                                                                                <a class="dropdown-item" href="#">Close
                                                                                    Friend</a>
                                                                                <a class="dropdown-item" href="#">Unfollow</a>
                                                                                <a class="dropdown-item" href="#">Unfriend</a>
                                                                                <a class="dropdown-item"
                                                                                   href="#">Block</a>
                                                                            </div>
                                                                        </div>
                                                                    </div>
                                                                </div>
                                                            </div>
                                                        </div>
                                                        <div class="col-md-6 col-lg-6 mb-3">
                                                            <div class="iq-friendlist-block">
                                                                <div class="d-flex align-items-center justify-content-between">
                                                                    <div class="d-flex align-items-center">
                                                                        <a href="#">
                                                                            <img src="images/user/07.jpg"
                                                                                 alt="profile-img" class="img-fluid">
                                                                        </a>
                                                                        <div class="friend-info ms-3">
                                                                            <h5>Cliff Hanger</h5>
                                                                            <p class="mb-0">20 friends</p>
                                                                        </div>
                                                                    </div>
                                                                    <div class="card-header-toolbar d-flex align-items-center">
                                                                        <div class="dropdown">
                                                   <span class="dropdown-toggle btn btn-secondary me-2"
                                                         id="dropdownMenuButton56" data-bs-toggle="dropdown"
                                                         aria-expanded="true" role="button">
                                                   <i class="ri-check-line me-1 text-white"></i> Friend
                                                   </span>
                                                                            <div class="dropdown-menu dropdown-menu-right"
                                                                                 aria-labelledby="dropdownMenuButton56">
                                                                                <a class="dropdown-item" href="#">Get
                                                                                    Notification</a>
                                                                                <a class="dropdown-item" href="#">Close
                                                                                    Friend</a>
                                                                                <a class="dropdown-item" href="#">Unfollow</a>
                                                                                <a class="dropdown-item" href="#">Unfriend</a>
                                                                                <a class="dropdown-item"
                                                                                   href="#">Block</a>
                                                                            </div>
                                                                        </div>
                                                                    </div>
                                                                </div>
                                                            </div>
                                                        </div>
                                                        <div class="col-md-6 col-lg-6 mb-3">
                                                            <div class="iq-friendlist-block">
                                                                <div class="d-flex align-items-center justify-content-between">
                                                                    <div class="d-flex align-items-center">
                                                                        <a href="#">
                                                                            <img src="images/user/08.jpg"
                                                                                 alt="profile-img" class="img-fluid">
                                                                        </a>
                                                                        <div class="friend-info ms-3">
                                                                            <h5>b Ackue</h5>
                                                                            <p class="mb-0">12 friends</p>
                                                                        </div>
                                                                    </div>
                                                                    <div class="card-header-toolbar d-flex align-items-center">
                                                                        <div class="dropdown">
                                                   <span class="dropdown-toggle btn btn-secondary me-2"
                                                         id="dropdownMenuButton57" data-bs-toggle="dropdown"
                                                         aria-expanded="true" role="button">
                                                   <i class="ri-check-line me-1 text-white"></i> Friend
                                                   </span>
                                                                            <div class="dropdown-menu dropdown-menu-right"
                                                                                 aria-labelledby="dropdownMenuButton57">
                                                                                <a class="dropdown-item" href="#">Get
                                                                                    Notification</a>
                                                                                <a class="dropdown-item" href="#">Close
                                                                                    Friend</a>
                                                                                <a class="dropdown-item" href="#">Unfollow</a>
                                                                                <a class="dropdown-item" href="#">Unfriend</a>
                                                                                <a class="dropdown-item"
                                                                                   href="#">Block</a>
                                                                            </div>
                                                                        </div>
                                                                    </div>
                                                                </div>
                                                            </div>
                                                        </div>
                                                        <div class="col-md-6 col-lg-6 mb-3">
                                                            <div class="iq-friendlist-block">
                                                                <div class="d-flex align-items-center justify-content-between">
                                                                    <div class="d-flex align-items-center">
                                                                        <a href="#">
                                                                            <img src="images/user/09.jpg"
                                                                                 alt="profile-img" class="img-fluid">
                                                                        </a>
                                                                        <div class="friend-info ms-3">
                                                                            <h5>Bob Frapples</h5>
                                                                            <p class="mb-0">12 friends</p>
                                                                        </div>
                                                                    </div>
                                                                    <div class="card-header-toolbar d-flex align-items-center">
                                                                        <div class="dropdown">
                                                   <span class="dropdown-toggle btn btn-secondary me-2"
                                                         id="dropdownMenuButton58" data-bs-toggle="dropdown"
                                                         aria-expanded="true" role="button">
                                                   <i class="ri-check-line me-1 text-white"></i> Friend
                                                   </span>
                                                                            <div class="dropdown-menu dropdown-menu-right"
                                                                                 aria-labelledby="dropdownMenuButton58">
                                                                                <a class="dropdown-item" href="#">Get
                                                                                    Notification</a>
                                                                                <a class="dropdown-item" href="#">Close
                                                                                    Friend</a>
                                                                                <a class="dropdown-item" href="#">Unfollow</a>
                                                                                <a class="dropdown-item" href="#">Unfriend</a>
                                                                                <a class="dropdown-item"
                                                                                   href="#">Block</a>
                                                                            </div>
                                                                        </div>
                                                                    </div>
                                                                </div>
                                                            </div>
                                                        </div>
                                                        <div class="col-md-6 col-lg-6 mb-3">
                                                            <div class="iq-friendlist-block">
                                                                <div class="d-flex align-items-center justify-content-between">
                                                                    <div class="d-flex align-items-center">
                                                                        <a href="#">
                                                                            <img src="images/user/10.jpg"
                                                                                 alt="profile-img" class="img-fluid">
                                                                        </a>
                                                                        <div class="friend-info ms-3">
                                                                            <h5>Anna Mull</h5>
                                                                            <p class="mb-0">6 friends</p>
                                                                        </div>
                                                                    </div>
                                                                    <div class="card-header-toolbar d-flex align-items-center">
                                                                        <div class="dropdown">
                                                   <span class="dropdown-toggle btn btn-secondary me-2"
                                                         id="dropdownMenuButton59" data-bs-toggle="dropdown"
                                                         aria-expanded="true" role="button">
                                                   <i class="ri-check-line me-1 text-white"></i> Friend
                                                   </span>
                                                                            <div class="dropdown-menu dropdown-menu-right"
                                                                                 aria-labelledby="dropdownMenuButton59">
                                                                                <a class="dropdown-item" href="#">Get
                                                                                    Notification</a>
                                                                                <a class="dropdown-item" href="#">Close
                                                                                    Friend</a>
                                                                                <a class="dropdown-item" href="#">Unfollow</a>
                                                                                <a class="dropdown-item" href="#">Unfriend</a>
                                                                                <a class="dropdown-item"
                                                                                   href="#">Block</a>
                                                                            </div>
                                                                        </div>
                                                                    </div>
                                                                </div>
                                                            </div>
                                                        </div>
                                                        <div class="col-md-6 col-lg-6 mb-3">
                                                            <div class="iq-friendlist-block">
                                                                <div class="d-flex align-items-center justify-content-between">
                                                                    <div class="d-flex align-items-center">
                                                                        <a href="#">
                                                                            <img src="images/user/15.jpg"
                                                                                 alt="profile-img" class="img-fluid">
                                                                        </a>
                                                                        <div class="friend-info ms-3">
                                                                            <h5>ry Wine</h5>
                                                                            <p class="mb-0">15 friends</p>
                                                                        </div>
                                                                    </div>
                                                                    <div class="card-header-toolbar d-flex align-items-center">
                                                                        <div class="dropdown">
                                                   <span class="dropdown-toggle btn btn-secondary me-2"
                                                         id="dropdownMenuButton60" data-bs-toggle="dropdown"
                                                         aria-expanded="true" role="button">
                                                   <i class="ri-check-line me-1 text-white"></i> Friend
                                                   </span>
                                                                            <div class="dropdown-menu dropdown-menu-right"
                                                                                 aria-labelledby="dropdownMenuButton60">
                                                                                <a class="dropdown-item" href="#">Get
                                                                                    Notification</a>
                                                                                <a class="dropdown-item" href="#">Close
                                                                                    Friend</a>
                                                                                <a class="dropdown-item" href="#">Unfollow</a>
                                                                                <a class="dropdown-item" href="#">Unfriend</a>
                                                                                <a class="dropdown-item"
                                                                                   href="#">Block</a>
                                                                            </div>
                                                                        </div>
                                                                    </div>
                                                                </div>
                                                            </div>
                                                        </div>
                                                        <div class="col-md-6 col-lg-6 mb-3">
                                                            <div class="iq-friendlist-block">
                                                                <div class="d-flex align-items-center justify-content-between">
                                                                    <div class="d-flex align-items-center">
                                                                        <a href="#">
                                                                            <img src="images/user/16.jpg"
                                                                                 alt="profile-img" class="img-fluid">
                                                                        </a>
                                                                        <div class="friend-info ms-3">
                                                                            <h5>Don Stairs</h5>
                                                                            <p class="mb-0">12 friends</p>
                                                                        </div>
                                                                    </div>
                                                                    <div class="card-header-toolbar d-flex align-items-center">
                                                                        <div class="dropdown">
                                                   <span class="dropdown-toggle btn btn-secondary me-2"
                                                         id="dropdownMenuButton61" data-bs-toggle="dropdown"
                                                         aria-expanded="true" role="button">
                                                   <i class="ri-check-line me-1 text-white"></i> Friend
                                                   </span>
                                                                            <div class="dropdown-menu dropdown-menu-right"
                                                                                 aria-labelledby="dropdownMenuButton61">
                                                                                <a class="dropdown-item" href="#">Get
                                                                                    Notification</a>
                                                                                <a class="dropdown-item" href="#">Close
                                                                                    Friend</a>
                                                                                <a class="dropdown-item" href="#">Unfollow</a>
                                                                                <a class="dropdown-item" href="#">Unfriend</a>
                                                                                <a class="dropdown-item"
                                                                                   href="#">Block</a>
                                                                            </div>
                                                                        </div>
                                                                    </div>
                                                                </div>
                                                            </div>
                                                        </div>
                                                        <div class="col-md-6 col-lg-6 mb-3">
                                                            <div class="iq-friendlist-block">
                                                                <div class="d-flex align-items-center justify-content-between">
                                                                    <div class="d-flex align-items-center">
                                                                        <a href="#">
                                                                            <img src="images/user/17.jpg"
                                                                                 alt="profile-img" class="img-fluid">
                                                                        </a>
                                                                        <div class="friend-info ms-3">
                                                                            <h5>Peter Pants</h5>
                                                                            <p class="mb-0">8 friends</p>
                                                                        </div>
                                                                    </div>
                                                                    <div class="card-header-toolbar d-flex align-items-center">
                                                                        <div class="dropdown">
                                                   <span class="dropdown-toggle btn btn-secondary me-2"
                                                         id="dropdownMenuButton62" data-bs-toggle="dropdown"
                                                         aria-expanded="true" role="button">
                                                   <i class="ri-check-line me-1 text-white"></i> Friend
                                                   </span>
                                                                            <div class="dropdown-menu dropdown-menu-right"
                                                                                 aria-labelledby="dropdownMenuButton62">
                                                                                <a class="dropdown-item" href="#">Get
                                                                                    Notification</a>
                                                                                <a class="dropdown-item" href="#">Close
                                                                                    Friend</a>
                                                                                <a class="dropdown-item" href="#">Unfollow</a>
                                                                                <a class="dropdown-item" href="#">Unfriend</a>
                                                                                <a class="dropdown-item"
                                                                                   href="#">Block</a>
                                                                            </div>
                                                                        </div>
                                                                    </div>
                                                                </div>
                                                            </div>
                                                        </div>
                                                        <div class="col-md-6 col-lg-6 mb-3">
                                                            <div class="iq-friendlist-block">
                                                                <div class="d-flex align-items-center justify-content-between">
                                                                    <div class="d-flex align-items-center">
                                                                        <a href="#">
                                                                            <img src="images/user/18.jpg"
                                                                                 alt="profile-img" class="img-fluid">
                                                                        </a>
                                                                        <div class="friend-info ms-3">
                                                                            <h5>Polly Tech</h5>
                                                                            <p class="mb-0">18 friends</p>
                                                                        </div>
                                                                    </div>
                                                                    <div class="card-header-toolbar d-flex align-items-center">
                                                                        <div class="dropdown">
                                                   <span class="dropdown-toggle btn btn-secondary me-2"
                                                         id="dropdownMenuButton63" data-bs-toggle="dropdown"
                                                         aria-expanded="true" role="button">
                                                   <i class="ri-check-line me-1 text-white"></i> Friend
                                                   </span>
                                                                            <div class="dropdown-menu dropdown-menu-right"
                                                                                 aria-labelledby="dropdownMenuButton63">
                                                                                <a class="dropdown-item" href="#">Get
                                                                                    Notification</a>
                                                                                <a class="dropdown-item" href="#">Close
                                                                                    Friend</a>
                                                                                <a class="dropdown-item" href="#">Unfollow</a>
                                                                                <a class="dropdown-item" href="#">Unfriend</a>
                                                                                <a class="dropdown-item"
                                                                                   href="#">Block</a>
                                                                            </div>
                                                                        </div>
                                                                    </div>
                                                                </div>
                                                            </div>
                                                        </div>
                                                        <div class="col-md-6 col-lg-6 mb-3">
                                                            <div class="iq-friendlist-block">
                                                                <div class="d-flex align-items-center justify-content-between">
                                                                    <div class="d-flex align-items-center">
                                                                        <a href="#">
                                                                            <img src="images/user/19.jpg"
                                                                                 alt="profile-img" class="img-fluid">
                                                                        </a>
                                                                        <div class="friend-info ms-3">
                                                                            <h5>Tara Zona</h5>
                                                                            <p class="mb-0">30 friends</p>
                                                                        </div>
                                                                    </div>
                                                                    <div class="card-header-toolbar d-flex align-items-center">
                                                                        <div class="dropdown">
                                                   <span class="dropdown-toggle btn btn-secondary me-2"
                                                         id="dropdownMenuButton64" data-bs-toggle="dropdown"
                                                         aria-expanded="true" role="button">
                                                   <i class="ri-check-line me-1 text-white"></i> Friend
                                                   </span>
                                                                            <div class="dropdown-menu dropdown-menu-right"
                                                                                 aria-labelledby="dropdownMenuButton64">
                                                                                <a class="dropdown-item" href="#">Get
                                                                                    Notification</a>
                                                                                <a class="dropdown-item" href="#">Close
                                                                                    Friend</a>
                                                                                <a class="dropdown-item" href="#">Unfollow</a>
                                                                                <a class="dropdown-item" href="#">Unfriend</a>
                                                                                <a class="dropdown-item"
                                                                                   href="#">Block</a>
                                                                            </div>
                                                                        </div>
                                                                    </div>
                                                                </div>
                                                            </div>
                                                        </div>
                                                        <div class="col-md-6 col-lg-6 mb-3">
                                                            <div class="iq-friendlist-block">
                                                                <div class="d-flex align-items-center justify-content-between">
                                                                    <div class="d-flex align-items-center">
                                                                        <a href="#">
                                                                            <img src="images/user/05.jpg"
                                                                                 alt="profile-img" class="img-fluid">
                                                                        </a>
                                                                        <div class="friend-info ms-3">
                                                                            <h5>Arty Ficial</h5>
                                                                            <p class="mb-0">15 friends</p>
                                                                        </div>
                                                                    </div>
                                                                    <div class="card-header-toolbar d-flex align-items-center">
                                                                        <div class="dropdown">
                                                   <span class="dropdown-toggle btn btn-secondary me-2"
                                                         id="dropdownMenuButton65" data-bs-toggle="dropdown"
                                                         aria-expanded="true" role="button">
                                                   <i class="ri-check-line me-1 text-white"></i> Friend
                                                   </span>
                                                                            <div class="dropdown-menu dropdown-menu-right"
                                                                                 aria-labelledby="dropdownMenuButton65">
                                                                                <a class="dropdown-item" href="#">Get
                                                                                    Notification</a>
                                                                                <a class="dropdown-item" href="#">Close
                                                                                    Friend</a>
                                                                                <a class="dropdown-item" href="#">Unfollow</a>
                                                                                <a class="dropdown-item" href="#">Unfriend</a>
                                                                                <a class="dropdown-item"
                                                                                   href="#">Block</a>
                                                                            </div>
                                                                        </div>
                                                                    </div>
                                                                </div>
                                                            </div>
                                                        </div>
                                                        <div class="col-md-6 col-lg-6 mb-3">
                                                            <div class="iq-friendlist-block">
                                                                <div class="d-flex align-items-center justify-content-between">
                                                                    <div class="d-flex align-items-center">
                                                                        <a href="#">
                                                                            <img src="images/user/06.jpg"
                                                                                 alt="profile-img" class="img-fluid">
                                                                        </a>
                                                                        <div class="friend-info ms-3">
                                                                            <h5>Bill Emia</h5>
                                                                            <p class="mb-0">25 friends</p>
                                                                        </div>
                                                                    </div>
                                                                    <div class="card-header-toolbar d-flex align-items-center">
                                                                        <div class="dropdown">
                                                   <span class="dropdown-toggle btn btn-secondary me-2"
                                                         id="dropdownMenuButton66" data-bs-toggle="dropdown"
                                                         aria-expanded="true" role="button">
                                                   <i class="ri-check-line me-1 text-white"></i> Friend
                                                   </span>
                                                                            <div class="dropdown-menu dropdown-menu-right"
                                                                                 aria-labelledby="dropdownMenuButton66">
                                                                                <a class="dropdown-item" href="#">Get
                                                                                    Notification</a>
                                                                                <a class="dropdown-item" href="#">Close
                                                                                    Friend</a>
                                                                                <a class="dropdown-item" href="#">Unfollow</a>
                                                                                <a class="dropdown-item" href="#">Unfriend</a>
                                                                                <a class="dropdown-item"
                                                                                   href="#">Block</a>
                                                                            </div>
                                                                        </div>
                                                                    </div>
                                                                </div>
                                                            </div>
                                                        </div>
                                                        <div class="col-md-6 col-lg-6 mb-3">
                                                            <div class="iq-friendlist-block">
                                                                <div class="d-flex align-items-center justify-content-between">
                                                                    <div class="d-flex align-items-center">
                                                                        <a href="#">
                                                                            <img src="images/user/07.jpg"
                                                                                 alt="profile-img" class="img-fluid">
                                                                        </a>
                                                                        <div class="friend-info ms-3">
                                                                            <h5>Bill Yerds</h5>
                                                                            <p class="mb-0">9 friends</p>
                                                                        </div>
                                                                    </div>
                                                                    <div class="card-header-toolbar d-flex align-items-center">
                                                                        <div class="dropdown">
                                                   <span class="dropdown-toggle btn btn-secondary me-2"
                                                         id="dropdownMenuButton67" data-bs-toggle="dropdown"
                                                         aria-expanded="true" role="button">
                                                   <i class="ri-check-line me-1 text-white"></i> Friend
                                                   </span>
                                                                            <div class="dropdown-menu dropdown-menu-right"
                                                                                 aria-labelledby="dropdownMenuButton67">
                                                                                <a class="dropdown-item" href="#">Get
                                                                                    Notification</a>
                                                                                <a class="dropdown-item" href="#">Close
                                                                                    Friend</a>
                                                                                <a class="dropdown-item" href="#">Unfollow</a>
                                                                                <a class="dropdown-item" href="#">Unfriend</a>
                                                                                <a class="dropdown-item"
                                                                                   href="#">Block</a>
                                                                            </div>
                                                                        </div>
                                                                    </div>
                                                                </div>
                                                            </div>
                                                        </div>
                                                        <div class="col-md-6 col-lg-6 mb-3">
                                                            <div class="iq-friendlist-block">
                                                                <div class="d-flex align-items-center justify-content-between">
                                                                    <div class="d-flex align-items-center">
                                                                        <a href="#">
                                                                            <img src="images/user/08.jpg"
                                                                                 alt="profile-img" class="img-fluid">
                                                                        </a>
                                                                        <div class="friend-info ms-3">
                                                                            <h5>Matt Innae</h5>
                                                                            <p class="mb-0">19 friends</p>
                                                                        </div>
                                                                    </div>
                                                                    <div class="card-header-toolbar d-flex align-items-center">
                                                                        <div class="dropdown">
                                                   <span class="dropdown-toggle btn btn-secondary me-2"
                                                         id="dropdownMenuButton68" data-bs-toggle="dropdown"
                                                         aria-expanded="true" role="button">
                                                   <i class="ri-check-line me-1 text-white"></i> Friend
                                                   </span>
                                                                            <div class="dropdown-menu dropdown-menu-right"
                                                                                 aria-labelledby="dropdownMenuButton68">
                                                                                <a class="dropdown-item" href="#">Get
                                                                                    Notification</a>
                                                                                <a class="dropdown-item" href="#">Close
                                                                                    Friend</a>
                                                                                <a class="dropdown-item" href="#">Unfollow</a>
                                                                                <a class="dropdown-item" href="#">Unfriend</a>
                                                                                <a class="dropdown-item"
                                                                                   href="#">Block</a>
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

                        <%-- My photos tab pane --%>
                        <div class="tab-pane fade" id="photos" role="tabpanel">
                            <div class="card">
                                <div class="card-body">
                                    <h2>Photos</h2>
                                    <div class="friend-list-tab mt-2">
                                        <ul class="nav nav-pills d-flex align-items-center justify-content-left friend-list-items p-0 mb-2">
                                            <li>
                                                <a class="nav-link active" data-bs-toggle="pill"
                                                   href="#pill-photosofyou" data-bs-target="#photosofyou">Photos of
                                                    You</a>
                                            </li>
                                            <li>
                                                <a class="nav-link" data-bs-toggle="pill" href="#pill-your-photos"
                                                   data-bs-target="#your-photos">Your Photos</a>
                                            </li>
                                        </ul>
                                        <div class="tab-content">
                                            <div class="tab-pane fade active show" id="photosofyou" role="tabpanel">
                                                <div class="card-body p-0">
                                                    <div class="d-grid gap-2 d-grid-template-1fr-13">
                                                        <div class="">
                                                            <div class="user-images position-relative overflow-hidden">
                                                                <a href="#">
                                                                    <img src="images/page-img/51.jpg"
                                                                         class="img-fluid rounded"
                                                                         alt="Responsive image">
                                                                </a>
                                                                <div class="image-hover-data">
                                                                    <div class="product-elements-icon">
                                                                        <ul class="d-flex align-items-center m-0 p-0 list-inline">
                                                                            <li><a href="#" class="pe-3 text-white"> 60
                                                                                <i class="ri-thumb-up-line"></i> </a>
                                                                            </li>
                                                                            <li><a href="#" class="pe-3 text-white"> 30
                                                                                <i class="ri-chat-3-line"></i> </a></li>
                                                                            <li><a href="#" class="pe-3 text-white"> 10
                                                                                <i class="ri-share-forward-line"></i>
                                                                            </a></li>
                                                                        </ul>
                                                                    </div>
                                                                </div>
                                                                <a href="#" class="image-edit-btn"
                                                                   data-bs-toggle="tooltip" data-bs-placement="top"
                                                                   title="" data-bs-original-title="Edit or Remove"><i
                                                                        class="ri-edit-2-fill"></i></a>
                                                            </div>
                                                        </div>
                                                        <div class="">
                                                            <div class="user-images position-relative overflow-hidden">
                                                                <a href="#">
                                                                    <img src="images/page-img/52.jpg"
                                                                         class="img-fluid rounded"
                                                                         alt="Responsive image">
                                                                </a>
                                                                <div class="image-hover-data">
                                                                    <div class="product-elements-icon">
                                                                        <ul class="d-flex align-items-center m-0 p-0 list-inline">
                                                                            <li><a href="#" class="pe-3 text-white"> 60
                                                                                <i class="ri-thumb-up-line"></i> </a>
                                                                            </li>
                                                                            <li><a href="#" class="pe-3 text-white"> 30
                                                                                <i class="ri-chat-3-line"></i> </a></li>
                                                                            <li><a href="#" class="pe-3 text-white"> 10
                                                                                <i class="ri-share-forward-line"></i>
                                                                            </a></li>
                                                                        </ul>
                                                                    </div>
                                                                </div>
                                                                <a href="#" class="image-edit-btn"
                                                                   data-bs-toggle="tooltip" data-bs-placement="top"
                                                                   title="" data-bs-original-title="Edit or Remove"><i
                                                                        class="ri-edit-2-fill"></i></a>
                                                            </div>
                                                        </div>
                                                        <div class="">
                                                            <div class="user-images position-relative overflow-hidden">
                                                                <a href="#">
                                                                    <img src="images/page-img/53.jpg"
                                                                         class="img-fluid rounded"
                                                                         alt="Responsive image">
                                                                </a>
                                                                <div class="image-hover-data">
                                                                    <div class="product-elements-icon">
                                                                        <ul class="d-flex align-items-center m-0 p-0 list-inline">
                                                                            <li><a href="#" class="pe-3 text-white"> 60
                                                                                <i class="ri-thumb-up-line"></i> </a>
                                                                            </li>
                                                                            <li><a href="#" class="pe-3 text-white"> 30
                                                                                <i class="ri-chat-3-line"></i> </a></li>
                                                                            <li><a href="#" class="pe-3 text-white"> 10
                                                                                <i class="ri-share-forward-line"></i>
                                                                            </a></li>
                                                                        </ul>
                                                                    </div>
                                                                </div>
                                                                <a href="#" class="image-edit-btn"
                                                                   data-bs-toggle="tooltip" data-bs-placement="top"
                                                                   title="" data-bs-original-title="Edit or Remove"><i
                                                                        class="ri-edit-2-fill"></i></a>
                                                            </div>
                                                        </div>
                                                        <div class="">
                                                            <div class="user-images position-relative overflow-hidden">
                                                                <a href="#">
                                                                    <img src="images/page-img/54.jpg"
                                                                         class="img-fluid rounded"
                                                                         alt="Responsive image">
                                                                </a>
                                                                <div class="image-hover-data">
                                                                    <div class="product-elements-icon">
                                                                        <ul class="d-flex align-items-center m-0 p-0 list-inline">
                                                                            <li><a href="#" class="pe-3 text-white"> 60
                                                                                <i class="ri-thumb-up-line"></i> </a>
                                                                            </li>
                                                                            <li><a href="#" class="pe-3 text-white"> 30
                                                                                <i class="ri-chat-3-line"></i> </a></li>
                                                                            <li><a href="#" class="pe-3 text-white"> 10
                                                                                <i class="ri-share-forward-line"></i>
                                                                            </a></li>
                                                                        </ul>
                                                                    </div>
                                                                </div>
                                                                <a href="#" class="image-edit-btn"
                                                                   data-bs-toggle="tooltip" data-bs-placement="top"
                                                                   title="" data-bs-original-title="Edit or Remove"><i
                                                                        class="ri-edit-2-fill"></i></a>
                                                            </div>
                                                        </div>
                                                        <div class="">
                                                            <div class="user-images position-relative overflow-hidden">
                                                                <a href="#">
                                                                    <img src="images/page-img/55.jpg"
                                                                         class="img-fluid rounded"
                                                                         alt="Responsive image">
                                                                </a>
                                                                <div class="image-hover-data">
                                                                    <div class="product-elements-icon">
                                                                        <ul class="d-flex align-items-center m-0 p-0 list-inline">
                                                                            <li><a href="#" class="pe-3 text-white"> 60
                                                                                <i class="ri-thumb-up-line"></i> </a>
                                                                            </li>
                                                                            <li><a href="#" class="pe-3 text-white"> 30
                                                                                <i class="ri-chat-3-line"></i> </a></li>
                                                                            <li><a href="#" class="pe-3 text-white"> 10
                                                                                <i class="ri-share-forward-line"></i>
                                                                            </a></li>
                                                                        </ul>
                                                                    </div>
                                                                </div>
                                                                <a href="#" class="image-edit-btn"
                                                                   data-bs-toggle="tooltip" data-bs-placement="top"
                                                                   title="" data-bs-original-title="Edit or Remove"><i
                                                                        class="ri-edit-2-fill"></i></a>
                                                            </div>
                                                        </div>
                                                        <div class="">
                                                            <div class="user-images position-relative overflow-hidden">
                                                                <a href="#">
                                                                    <img src="images/page-img/56.jpg"
                                                                         class="img-fluid rounded"
                                                                         alt="Responsive image">
                                                                </a>
                                                                <div class="image-hover-data">
                                                                    <div class="product-elements-icon">
                                                                        <ul class="d-flex align-items-center m-0 p-0 list-inline">
                                                                            <li><a href="#" class="pe-3 text-white"> 60
                                                                                <i class="ri-thumb-up-line"></i> </a>
                                                                            </li>
                                                                            <li><a href="#" class="pe-3 text-white"> 30
                                                                                <i class="ri-chat-3-line"></i> </a></li>
                                                                            <li><a href="#" class="pe-3 text-white"> 10
                                                                                <i class="ri-share-forward-line"></i>
                                                                            </a></li>
                                                                        </ul>
                                                                    </div>
                                                                </div>
                                                                <a href="#" class="image-edit-btn"
                                                                   data-bs-toggle="tooltip" data-bs-placement="top"
                                                                   title="" data-bs-original-title="Edit or Remove"><i
                                                                        class="ri-edit-2-fill"></i></a>
                                                            </div>
                                                        </div>
                                                        <div class="">
                                                            <div class="user-images position-relative overflow-hidden">
                                                                <a href="#">
                                                                    <img src="images/page-img/57.jpg"
                                                                         class="img-fluid rounded"
                                                                         alt="Responsive image">
                                                                </a>
                                                                <div class="image-hover-data">
                                                                    <div class="product-elements-icon">
                                                                        <ul class="d-flex align-items-center m-0 p-0 list-inline">
                                                                            <li><a href="#" class="pe-3 text-white"> 60
                                                                                <i class="ri-thumb-up-line"></i> </a>
                                                                            </li>
                                                                            <li><a href="#" class="pe-3 text-white"> 30
                                                                                <i class="ri-chat-3-line"></i> </a></li>
                                                                            <li><a href="#" class="pe-3 text-white"> 10
                                                                                <i class="ri-share-forward-line"></i>
                                                                            </a></li>
                                                                        </ul>
                                                                    </div>
                                                                </div>
                                                                <a href="#" class="image-edit-btn"
                                                                   data-bs-toggle="tooltip" data-bs-placement="top"
                                                                   title="" data-bs-original-title="Edit or Remove"><i
                                                                        class="ri-edit-2-fill"></i></a>
                                                            </div>
                                                        </div>
                                                        <div class="">
                                                            <div class="user-images position-relative overflow-hidden">
                                                                <a href="#">
                                                                    <img src="images/page-img/58.jpg"
                                                                         class="img-fluid rounded"
                                                                         alt="Responsive image">
                                                                </a>
                                                                <div class="image-hover-data">
                                                                    <div class="product-elements-icon">
                                                                        <ul class="d-flex align-items-center m-0 p-0 list-inline">
                                                                            <li><a href="#" class="pe-3 text-white"> 60
                                                                                <i class="ri-thumb-up-line"></i> </a>
                                                                            </li>
                                                                            <li><a href="#" class="pe-3 text-white"> 30
                                                                                <i class="ri-chat-3-line"></i> </a></li>
                                                                            <li><a href="#" class="pe-3 text-white"> 10
                                                                                <i class="ri-share-forward-line"></i>
                                                                            </a></li>
                                                                        </ul>
                                                                    </div>
                                                                </div>
                                                                <a href="#" class="image-edit-btn"
                                                                   data-bs-toggle="tooltip" data-bs-placement="top"
                                                                   title="" data-bs-original-title="Edit or Remove"><i
                                                                        class="ri-edit-2-fill"></i></a>
                                                            </div>
                                                        </div>
                                                        <div class="">
                                                            <div class="user-images position-relative overflow-hidden">
                                                                <a href="#">
                                                                    <img src="images/page-img/59.jpg"
                                                                         class="img-fluid rounded" alt="image">
                                                                </a>
                                                                <div class="image-hover-data">
                                                                    <div class="product-elements-icon">
                                                                        <ul class="d-flex align-items-center m-0 p-0 list-inline">
                                                                            <li><a href="#" class="pe-3 text-white"> 60
                                                                                <i class="ri-thumb-up-line"></i> </a>
                                                                            </li>
                                                                            <li><a href="#" class="pe-3 text-white"> 30
                                                                                <i class="ri-chat-3-line"></i> </a></li>
                                                                            <li><a href="#" class="pe-3 text-white"> 10
                                                                                <i class="ri-share-forward-line"></i>
                                                                            </a></li>
                                                                        </ul>
                                                                    </div>
                                                                </div>
                                                                <a href="#" class="image-edit-btn"
                                                                   data-bs-toggle="tooltip" data-bs-placement="top"
                                                                   title="" data-bs-original-title="Edit or Remove"><i
                                                                        class="ri-edit-2-fill"></i></a>
                                                            </div>
                                                        </div>
                                                        <div class="">
                                                            <div class="user-images position-relative overflow-hidden">
                                                                <a href="#">
                                                                    <img src="images/page-img/60.jpg"
                                                                         class="img-fluid rounded"
                                                                         alt="Responsive image">
                                                                </a>
                                                                <div class="image-hover-data">
                                                                    <div class="product-elements-icon">
                                                                        <ul class="d-flex align-items-center m-0 p-0 list-inline">
                                                                            <li><a href="#" class="pe-3 text-white"> 60
                                                                                <i class="ri-thumb-up-line"></i> </a>
                                                                            </li>
                                                                            <li><a href="#" class="pe-3 text-white"> 30
                                                                                <i class="ri-chat-3-line"></i> </a></li>
                                                                            <li><a href="#" class="pe-3 text-white"> 10
                                                                                <i class="ri-share-forward-line"></i>
                                                                            </a></li>
                                                                        </ul>
                                                                    </div>
                                                                </div>
                                                                <a href="#" class="image-edit-btn"
                                                                   data-bs-toggle="tooltip" data-bs-placement="top"
                                                                   title="" data-bs-original-title="Edit or Remove"><i
                                                                        class="ri-edit-2-fill"></i></a>
                                                            </div>
                                                        </div>
                                                        <div class="">
                                                            <div class="user-images position-relative overflow-hidden">
                                                                <a href="#">
                                                                    <img src="images/page-img/61.jpg"
                                                                         class="img-fluid rounded"
                                                                         alt="Responsive image">
                                                                </a>
                                                                <div class="image-hover-data">
                                                                    <div class="product-elements-icon">
                                                                        <ul class="d-flex align-items-center m-0 p-0 list-inline">
                                                                            <li><a href="#" class="pe-3 text-white"> 60
                                                                                <i class="ri-thumb-up-line"></i> </a>
                                                                            </li>
                                                                            <li><a href="#" class="pe-3 text-white"> 30
                                                                                <i class="ri-chat-3-line"></i> </a></li>
                                                                            <li><a href="#" class="pe-3 text-white"> 10
                                                                                <i class="ri-share-forward-line"></i>
                                                                            </a></li>
                                                                        </ul>
                                                                    </div>
                                                                </div>
                                                                <a href="#" class="image-edit-btn"
                                                                   data-bs-toggle="tooltip" data-bs-placement="top"
                                                                   title="" data-bs-original-title="Edit or Remove"><i
                                                                        class="ri-edit-2-fill"></i></a>
                                                            </div>
                                                        </div>
                                                        <div class="">
                                                            <div class="user-images position-relative overflow-hidden">
                                                                <a href="#">
                                                                    <img src="images/page-img/62.jpg"
                                                                         class="img-fluid rounded"
                                                                         alt="Responsive image">
                                                                </a>
                                                                <div class="image-hover-data">
                                                                    <div class="product-elements-icon">
                                                                        <ul class="d-flex align-items-center m-0 p-0 list-inline">
                                                                            <li><a href="#" class="pe-3 text-white"> 60
                                                                                <i class="ri-thumb-up-line"></i> </a>
                                                                            </li>
                                                                            <li><a href="#" class="pe-3 text-white"> 30
                                                                                <i class="ri-chat-3-line"></i> </a></li>
                                                                            <li><a href="#" class="pe-3 text-white"> 10
                                                                                <i class="ri-share-forward-line"></i>
                                                                            </a></li>
                                                                        </ul>
                                                                    </div>
                                                                </div>
                                                                <a href="#" class="image-edit-btn"
                                                                   data-bs-toggle="tooltip" data-bs-placement="top"
                                                                   title="" data-bs-original-title="Edit or Remove"><i
                                                                        class="ri-edit-2-fill"></i></a>
                                                            </div>
                                                        </div>
                                                        <div class="">
                                                            <div class="user-images position-relative overflow-hidden">
                                                                <a href="#">
                                                                    <img src="images/page-img/63.jpg"
                                                                         class="img-fluid rounded"
                                                                         alt="Responsive image">
                                                                </a>
                                                                <div class="image-hover-data">
                                                                    <div class="product-elements-icon">
                                                                        <ul class="d-flex align-items-center m-0 p-0 list-inline">
                                                                            <li><a href="#" class="pe-3 text-white"> 60
                                                                                <i class="ri-thumb-up-line"></i> </a>
                                                                            </li>
                                                                            <li><a href="#" class="pe-3 text-white"> 30
                                                                                <i class="ri-chat-3-line"></i> </a></li>
                                                                            <li><a href="#" class="pe-3 text-white"> 10
                                                                                <i class="ri-share-forward-line"></i>
                                                                            </a></li>
                                                                        </ul>
                                                                    </div>
                                                                </div>
                                                                <a href="#" class="image-edit-btn"
                                                                   data-bs-toggle="tooltip" data-bs-placement="top"
                                                                   title="" data-bs-original-title="Edit or Remove"><i
                                                                        class="ri-edit-2-fill"></i></a>
                                                            </div>
                                                        </div>
                                                        <div class="">
                                                            <div class="user-images position-relative overflow-hidden">
                                                                <a href="#">
                                                                    <img src="images/page-img/64.jpg"
                                                                         class="img-fluid rounded"
                                                                         alt="Responsive image">
                                                                </a>
                                                                <div class="image-hover-data">
                                                                    <div class="product-elements-icon">
                                                                        <ul class="d-flex align-items-center m-0 p-0 list-inline">
                                                                            <li><a href="#" class="pe-3 text-white"> 60
                                                                                <i class="ri-thumb-up-line"></i> </a>
                                                                            </li>
                                                                            <li><a href="#" class="pe-3 text-white"> 30
                                                                                <i class="ri-chat-3-line"></i> </a></li>
                                                                            <li><a href="#" class="pe-3 text-white"> 10
                                                                                <i class="ri-share-forward-line"></i>
                                                                            </a></li>
                                                                        </ul>
                                                                    </div>
                                                                </div>
                                                                <a href="#" class="image-edit-btn"
                                                                   data-bs-toggle="tooltip" data-bs-placement="top"
                                                                   title="" data-bs-original-title="Edit or Remove"><i
                                                                        class="ri-edit-2-fill"></i></a>
                                                            </div>
                                                        </div>
                                                        <div class="">
                                                            <div class="user-images position-relative overflow-hidden">
                                                                <a href="#">
                                                                    <img src="images/page-img/65.jpg"
                                                                         class="img-fluid rounded"
                                                                         alt="Responsive image">
                                                                </a>
                                                                <div class="image-hover-data">
                                                                    <div class="product-elements-icon">
                                                                        <ul class="d-flex align-items-center m-0 p-0 list-inline">
                                                                            <li><a href="#" class="pe-3 text-white"> 60
                                                                                <i class="ri-thumb-up-line"></i> </a>
                                                                            </li>
                                                                            <li><a href="#" class="pe-3 text-white"> 30
                                                                                <i class="ri-chat-3-line"></i> </a></li>
                                                                            <li><a href="#" class="pe-3 text-white"> 10
                                                                                <i class="ri-share-forward-line"></i>
                                                                            </a></li>
                                                                        </ul>
                                                                    </div>
                                                                </div>
                                                                <a href="#" class="image-edit-btn"
                                                                   data-bs-toggle="tooltip" data-bs-placement="top"
                                                                   title="" data-bs-original-title="Edit or Remove"><i
                                                                        class="ri-edit-2-fill"></i></a>
                                                            </div>
                                                        </div>
                                                        <div class="">
                                                            <div class="user-images position-relative overflow-hidden">
                                                                <a href="#">
                                                                    <img src="images/page-img/51.jpg"
                                                                         class="img-fluid rounded"
                                                                         alt="Responsive image">
                                                                </a>
                                                                <div class="image-hover-data">
                                                                    <div class="product-elements-icon">
                                                                        <ul class="d-flex align-items-center m-0 p-0 list-inline">
                                                                            <li><a href="#" class="pe-3 text-white"> 60
                                                                                <i class="ri-thumb-up-line"></i> </a>
                                                                            </li>
                                                                            <li><a href="#" class="pe-3 text-white"> 30
                                                                                <i class="ri-chat-3-line"></i> </a></li>
                                                                            <li><a href="#" class="pe-3 text-white"> 10
                                                                                <i class="ri-share-forward-line"></i>
                                                                            </a></li>
                                                                        </ul>
                                                                    </div>
                                                                </div>
                                                                <a href="#" class="image-edit-btn"
                                                                   data-bs-toggle="tooltip" data-bs-placement="top"
                                                                   title="" data-bs-original-title="Edit or Remove"><i
                                                                        class="ri-edit-2-fill"></i></a>
                                                            </div>
                                                        </div>
                                                        <div class="">
                                                            <div class="user-images position-relative overflow-hidden">
                                                                <a href="#">
                                                                    <img src="images/page-img/52.jpg"
                                                                         class="img-fluid rounded"
                                                                         alt="Responsive image">
                                                                </a>
                                                                <div class="image-hover-data">
                                                                    <div class="product-elements-icon">
                                                                        <ul class="d-flex align-items-center m-0 p-0 list-inline">
                                                                            <li><a href="#" class="pe-3 text-white"> 60
                                                                                <i class="ri-thumb-up-line"></i> </a>
                                                                            </li>
                                                                            <li><a href="#" class="pe-3 text-white"> 30
                                                                                <i class="ri-chat-3-line"></i> </a></li>
                                                                            <li><a href="#" class="pe-3 text-white"> 10
                                                                                <i class="ri-share-forward-line"></i>
                                                                            </a></li>
                                                                        </ul>
                                                                    </div>
                                                                </div>
                                                                <a href="#" class="image-edit-btn"
                                                                   data-bs-toggle="tooltip" data-bs-placement="top"
                                                                   title="" data-bs-original-title="Edit or Remove"><i
                                                                        class="ri-edit-2-fill"></i></a>
                                                            </div>
                                                        </div>
                                                        <div class="">
                                                            <div class="user-images position-relative overflow-hidden">
                                                                <a href="#">
                                                                    <img src="images/page-img/53.jpg"
                                                                         class="img-fluid rounded"
                                                                         alt="Responsive image">
                                                                </a>
                                                                <div class="image-hover-data">
                                                                    <div class="product-elements-icon">
                                                                        <ul class="d-flex align-items-center m-0 p-0 list-inline">
                                                                            <li><a href="#" class="pe-3 text-white"> 60
                                                                                <i class="ri-thumb-up-line"></i> </a>
                                                                            </li>
                                                                            <li><a href="#" class="pe-3 text-white"> 30
                                                                                <i class="ri-chat-3-line"></i> </a></li>
                                                                            <li><a href="#" class="pe-3 text-white"> 10
                                                                                <i class="ri-share-forward-line"></i>
                                                                            </a></li>
                                                                        </ul>
                                                                    </div>
                                                                </div>
                                                                <a href="#" class="image-edit-btn"
                                                                   data-bs-toggle="tooltip" data-bs-placement="top"
                                                                   title="" data-bs-original-title="Edit or Remove"><i
                                                                        class="ri-edit-2-fill"></i></a>
                                                            </div>
                                                        </div>
                                                        <div class="">
                                                            <div class="user-images position-relative overflow-hidden">
                                                                <a href="#">
                                                                    <img src="images/page-img/54.jpg"
                                                                         class="img-fluid rounded"
                                                                         alt="Responsive image">
                                                                </a>
                                                                <div class="image-hover-data">
                                                                    <div class="product-elements-icon">
                                                                        <ul class="d-flex align-items-center m-0 p-0 list-inline">
                                                                            <li><a href="#" class="pe-3 text-white"> 60
                                                                                <i class="ri-thumb-up-line"></i> </a>
                                                                            </li>
                                                                            <li><a href="#" class="pe-3 text-white"> 30
                                                                                <i class="ri-chat-3-line"></i> </a></li>
                                                                            <li><a href="#" class="pe-3 text-white"> 10
                                                                                <i class="ri-share-forward-line"></i>
                                                                            </a></li>
                                                                        </ul>
                                                                    </div>
                                                                </div>
                                                                <a href="#" class="image-edit-btn"
                                                                   data-bs-toggle="tooltip" data-bs-placement="top"
                                                                   title="" data-bs-original-title="Edit or Remove"><i
                                                                        class="ri-edit-2-fill"></i></a>
                                                            </div>
                                                        </div>
                                                        <div class="">
                                                            <div class="user-images position-relative overflow-hidden">
                                                                <a href="#">
                                                                    <img src="images/page-img/55.jpg"
                                                                         class="img-fluid rounded"
                                                                         alt="Responsive image">
                                                                </a>
                                                                <div class="image-hover-data">
                                                                    <div class="product-elements-icon">
                                                                        <ul class="d-flex align-items-center m-0 p-0 list-inline">
                                                                            <li><a href="#" class="pe-3 text-white"> 60
                                                                                <i class="ri-thumb-up-line"></i> </a>
                                                                            </li>
                                                                            <li><a href="#" class="pe-3 text-white"> 30
                                                                                <i class="ri-chat-3-line"></i> </a></li>
                                                                            <li><a href="#" class="pe-3 text-white"> 10
                                                                                <i class="ri-share-forward-line"></i>
                                                                            </a></li>
                                                                        </ul>
                                                                    </div>
                                                                </div>
                                                                <a href="#" class="image-edit-btn"
                                                                   data-bs-toggle="tooltip" data-bs-placement="top"
                                                                   title="" data-bs-original-title="Edit or Remove"><i
                                                                        class="ri-edit-2-fill"></i></a>
                                                            </div>
                                                        </div>
                                                        <div class="">
                                                            <div class="user-images position-relative overflow-hidden">
                                                                <a href="#">
                                                                    <img src="images/page-img/56.jpg"
                                                                         class="img-fluid rounded"
                                                                         alt="Responsive image">
                                                                </a>
                                                                <div class="image-hover-data">
                                                                    <div class="product-elements-icon">
                                                                        <ul class="d-flex align-items-center m-0 p-0 list-inline">
                                                                            <li><a href="#" class="pe-3 text-white"> 60
                                                                                <i class="ri-thumb-up-line"></i> </a>
                                                                            </li>
                                                                            <li><a href="#" class="pe-3 text-white"> 30
                                                                                <i class="ri-chat-3-line"></i> </a></li>
                                                                            <li><a href="#" class="pe-3 text-white"> 10
                                                                                <i class="ri-share-forward-line"></i>
                                                                            </a></li>
                                                                        </ul>
                                                                    </div>
                                                                </div>
                                                                <a href="#" class="image-edit-btn"
                                                                   data-bs-toggle="tooltip" data-bs-placement="top"
                                                                   title="" data-bs-original-title="Edit or Remove"><i
                                                                        class="ri-edit-2-fill"></i></a>
                                                            </div>
                                                        </div>
                                                        <div class="">
                                                            <div class="user-images position-relative overflow-hidden">
                                                                <a href="#">
                                                                    <img src="images/page-img/57.jpg"
                                                                         class="img-fluid rounded"
                                                                         alt="Responsive image">
                                                                </a>
                                                                <div class="image-hover-data">
                                                                    <div class="product-elements-icon">
                                                                        <ul class="d-flex align-items-center m-0 p-0 list-inline">
                                                                            <li><a href="#" class="pe-3 text-white"> 60
                                                                                <i class="ri-thumb-up-line"></i> </a>
                                                                            </li>
                                                                            <li><a href="#" class="pe-3 text-white"> 30
                                                                                <i class="ri-chat-3-line"></i> </a></li>
                                                                            <li><a href="#" class="pe-3 text-white"> 10
                                                                                <i class="ri-share-forward-line"></i>
                                                                            </a></li>
                                                                        </ul>
                                                                    </div>
                                                                </div>
                                                                <a href="#" class="image-edit-btn"
                                                                   data-bs-toggle="tooltip" data-bs-placement="top"
                                                                   title="" data-bs-original-title="Edit or Remove"><i
                                                                        class="ri-edit-2-fill"></i></a>
                                                            </div>
                                                        </div>
                                                        <div class="">
                                                            <div class="user-images position-relative overflow-hidden">
                                                                <a href="#">
                                                                    <img src="images/page-img/58.jpg"
                                                                         class="img-fluid rounded"
                                                                         alt="Responsive image">
                                                                </a>
                                                                <div class="image-hover-data">
                                                                    <div class="product-elements-icon">
                                                                        <ul class="d-flex align-items-center m-0 p-0 list-inline">
                                                                            <li><a href="#" class="pe-3 text-white"> 60
                                                                                <i class="ri-thumb-up-line"></i> </a>
                                                                            </li>
                                                                            <li><a href="#" class="pe-3 text-white"> 30
                                                                                <i class="ri-chat-3-line"></i> </a></li>
                                                                            <li><a href="#" class="pe-3 text-white"> 10
                                                                                <i class="ri-share-forward-line"></i>
                                                                            </a></li>
                                                                        </ul>
                                                                    </div>
                                                                </div>
                                                                <a href="#" class="image-edit-btn"
                                                                   data-bs-toggle="tooltip" data-bs-placement="top"
                                                                   title="" data-bs-original-title="Edit or Remove"><i
                                                                        class="ri-edit-2-fill"></i></a>
                                                            </div>
                                                        </div>
                                                        <div class="">
                                                            <div class="user-images position-relative overflow-hidden">
                                                                <a href="#">
                                                                    <img src="images/page-img/59.jpg"
                                                                         class="img-fluid rounded"
                                                                         alt="Responsive image">
                                                                </a>
                                                                <div class="image-hover-data">
                                                                    <div class="product-elements-icon">
                                                                        <ul class="d-flex align-items-center m-0 p-0 list-inline">
                                                                            <li><a href="#" class="pe-3 text-white"> 60
                                                                                <i class="ri-thumb-up-line"></i> </a>
                                                                            </li>
                                                                            <li><a href="#" class="pe-3 text-white"> 30
                                                                                <i class="ri-chat-3-line"></i> </a></li>
                                                                            <li><a href="#" class="pe-3 text-white"> 10
                                                                                <i class="ri-share-forward-line"></i>
                                                                            </a></li>
                                                                        </ul>
                                                                    </div>
                                                                </div>
                                                                <a href="#" class="image-edit-btn"
                                                                   data-bs-toggle="tooltip" data-bs-placement="top"
                                                                   title="" data-bs-original-title="Edit or Remove"><i
                                                                        class="ri-edit-2-fill"></i></a>
                                                            </div>
                                                        </div>
                                                    </div>
                                                </div>
                                            </div>
                                            <div class="tab-pane fade" id="your-photos" role="tabpanel">
                                                <div class="card-body p-0">
                                                    <div class="d-grid gap-2 d-grid-template-1fr-13 ">
                                                        <div class="">
                                                            <div class="user-images position-relative overflow-hidden">
                                                                <a href="#">
                                                                    <img src="images/page-img/51.jpg"
                                                                         class="img-fluid rounded"
                                                                         alt="Responsive image">
                                                                </a>
                                                                <div class="image-hover-data">
                                                                    <div class="product-elements-icon">
                                                                        <ul class="d-flex align-items-center m-0 p-0 list-inline">
                                                                            <li><a href="#" class="pe-3 text-white"> 60
                                                                                <i class="ri-thumb-up-line"></i> </a>
                                                                            </li>
                                                                            <li><a href="#" class="pe-3 text-white"> 30
                                                                                <i class="ri-chat-3-line"></i> </a></li>
                                                                            <li><a href="#" class="pe-3 text-white"> 10
                                                                                <i class="ri-share-forward-line"></i>
                                                                            </a></li>
                                                                        </ul>
                                                                    </div>
                                                                </div>
                                                                <a href="#" class="image-edit-btn"
                                                                   data-bs-toggle="tooltip" data-bs-placement="top"
                                                                   title="" data-bs-original-title="Edit or Remove"><i
                                                                        class="ri-edit-2-fill"></i></a>
                                                            </div>
                                                        </div>
                                                        <div class="">
                                                            <div class="user-images position-relative overflow-hidden">
                                                                <a href="#">
                                                                    <img src="images/page-img/52.jpg"
                                                                         class="img-fluid rounded"
                                                                         alt="Responsive image">
                                                                </a>
                                                                <div class="image-hover-data">
                                                                    <div class="product-elements-icon">
                                                                        <ul class="d-flex align-items-center m-0 p-0 list-inline">
                                                                            <li><a href="#" class="pe-3 text-white"> 60
                                                                                <i class="ri-thumb-up-line"></i> </a>
                                                                            </li>
                                                                            <li><a href="#" class="pe-3 text-white"> 30
                                                                                <i class="ri-chat-3-line"></i> </a></li>
                                                                            <li><a href="#" class="pe-3 text-white"> 10
                                                                                <i class="ri-share-forward-line"></i>
                                                                            </a></li>
                                                                        </ul>
                                                                    </div>
                                                                </div>
                                                                <a href="#" class="image-edit-btn"
                                                                   data-bs-toggle="tooltip" data-bs-placement="top"
                                                                   title="" data-bs-original-title="Edit or Remove"><i
                                                                        class="ri-edit-2-fill"></i></a>
                                                            </div>
                                                        </div>
                                                        <div class="">
                                                            <div class="user-images position-relative overflow-hidden">
                                                                <a href="#">
                                                                    <img src="images/page-img/53.jpg"
                                                                         class="img-fluid rounded"
                                                                         alt="Responsive image">
                                                                </a>
                                                                <div class="image-hover-data">
                                                                    <div class="product-elements-icon">
                                                                        <ul class="d-flex align-items-center m-0 p-0 list-inline">
                                                                            <li><a href="#" class="pe-3 text-white"> 60
                                                                                <i class="ri-thumb-up-line"></i> </a>
                                                                            </li>
                                                                            <li><a href="#" class="pe-3 text-white"> 30
                                                                                <i class="ri-chat-3-line"></i> </a></li>
                                                                            <li><a href="#" class="pe-3 text-white"> 10
                                                                                <i class="ri-share-forward-line"></i>
                                                                            </a></li>
                                                                        </ul>
                                                                    </div>
                                                                </div>
                                                                <a href="#" class="image-edit-btn"
                                                                   data-bs-toggle="tooltip" data-bs-placement="top"
                                                                   title="" data-bs-original-title="Edit or Remove"><i
                                                                        class="ri-edit-2-fill"></i></a>
                                                            </div>
                                                        </div>
                                                        <div class="">
                                                            <div class="user-images position-relative overflow-hidden">
                                                                <a href="#">
                                                                    <img src="images/page-img/54.jpg"
                                                                         class="img-fluid rounded"
                                                                         alt="Responsive image">
                                                                </a>
                                                                <div class="image-hover-data">
                                                                    <div class="product-elements-icon">
                                                                        <ul class="d-flex align-items-center m-0 p-0 list-inline">
                                                                            <li><a href="#" class="pe-3 text-white"> 60
                                                                                <i class="ri-thumb-up-line"></i> </a>
                                                                            </li>
                                                                            <li><a href="#" class="pe-3 text-white"> 30
                                                                                <i class="ri-chat-3-line"></i> </a></li>
                                                                            <li><a href="#" class="pe-3 text-white"> 10
                                                                                <i class="ri-share-forward-line"></i>
                                                                            </a></li>
                                                                        </ul>
                                                                    </div>
                                                                </div>
                                                                <a href="#" class="image-edit-btn"
                                                                   data-bs-toggle="tooltip" data-bs-placement="top"
                                                                   title="" data-bs-original-title="Edit or Remove"><i
                                                                        class="ri-edit-2-fill"></i></a>
                                                            </div>
                                                        </div>
                                                        <div class="">
                                                            <div class="user-images position-relative overflow-hidden">
                                                                <a href="#">
                                                                    <img src="images/page-img/55.jpg"
                                                                         class="img-fluid rounded"
                                                                         alt="Responsive image">
                                                                </a>
                                                                <div class="image-hover-data">
                                                                    <div class="product-elements-icon">
                                                                        <ul class="d-flex align-items-center m-0 p-0 list-inline">
                                                                            <li><a href="#" class="pe-3 text-white"> 60
                                                                                <i class="ri-thumb-up-line"></i> </a>
                                                                            </li>
                                                                            <li><a href="#" class="pe-3 text-white"> 30
                                                                                <i class="ri-chat-3-line"></i> </a></li>
                                                                            <li><a href="#" class="pe-3 text-white"> 10
                                                                                <i class="ri-share-forward-line"></i>
                                                                            </a></li>
                                                                        </ul>
                                                                    </div>
                                                                </div>
                                                                <a href="#" class="image-edit-btn"
                                                                   data-bs-toggle="tooltip" data-bs-placement="top"
                                                                   title="" data-bs-original-title="Edit or Remove"><i
                                                                        class="ri-edit-2-fill"></i></a>
                                                            </div>
                                                        </div>
                                                        <div class="">
                                                            <div class="user-images position-relative overflow-hidden">
                                                                <a href="#">
                                                                    <img src="images/page-img/56.jpg"
                                                                         class="img-fluid rounded"
                                                                         alt="Responsive image">
                                                                </a>
                                                                <div class="image-hover-data">
                                                                    <div class="product-elements-icon">
                                                                        <ul class="d-flex align-items-center m-0 p-0 list-inline">
                                                                            <li><a href="#" class="pe-3 text-white"> 60
                                                                                <i class="ri-thumb-up-line"></i> </a>
                                                                            </li>
                                                                            <li><a href="#" class="pe-3 text-white"> 30
                                                                                <i class="ri-chat-3-line"></i> </a></li>
                                                                            <li><a href="#" class="pe-3 text-white"> 10
                                                                                <i class="ri-share-forward-line"></i>
                                                                            </a></li>
                                                                        </ul>
                                                                    </div>
                                                                </div>
                                                                <a href="#" class="image-edit-btn"
                                                                   data-bs-toggle="tooltip" data-bs-placement="top"
                                                                   title="" data-bs-original-title="Edit or Remove"><i
                                                                        class="ri-edit-2-fill"></i></a>
                                                            </div>
                                                        </div>
                                                        <div class="">
                                                            <div class="user-images position-relative overflow-hidden">
                                                                <a href="#">
                                                                    <img src="images/page-img/57.jpg"
                                                                         class="img-fluid rounded"
                                                                         alt="Responsive image">
                                                                </a>
                                                                <div class="image-hover-data">
                                                                    <div class="product-elements-icon">
                                                                        <ul class="d-flex align-items-center m-0 p-0 list-inline">
                                                                            <li><a href="#" class="pe-3 text-white"> 60
                                                                                <i class="ri-thumb-up-line"></i> </a>
                                                                            </li>
                                                                            <li><a href="#" class="pe-3 text-white"> 30
                                                                                <i class="ri-chat-3-line"></i> </a></li>
                                                                            <li><a href="#" class="pe-3 text-white"> 10
                                                                                <i class="ri-share-forward-line"></i>
                                                                            </a></li>
                                                                        </ul>
                                                                    </div>
                                                                </div>
                                                                <a href="#" class="image-edit-btn"
                                                                   data-bs-toggle="tooltip" data-bs-placement="top"
                                                                   title="" data-bs-original-title="Edit or Remove"><i
                                                                        class="ri-edit-2-fill"></i></a>
                                                            </div>
                                                        </div>
                                                        <div class="">
                                                            <div class="user-images position-relative overflow-hidden">
                                                                <a href="#">
                                                                    <img src="images/page-img/58.jpg"
                                                                         class="img-fluid rounded"
                                                                         alt="Responsive image">
                                                                </a>
                                                                <div class="image-hover-data">
                                                                    <div class="product-elements-icon">
                                                                        <ul class="d-flex align-items-center m-0 p-0 list-inline">
                                                                            <li><a href="#" class="pe-3 text-white"> 60
                                                                                <i class="ri-thumb-up-line"></i> </a>
                                                                            </li>
                                                                            <li><a href="#" class="pe-3 text-white"> 30
                                                                                <i class="ri-chat-3-line"></i> </a></li>
                                                                            <li><a href="#" class="pe-3 text-white"> 10
                                                                                <i class="ri-share-forward-line"></i>
                                                                            </a></li>
                                                                        </ul>
                                                                    </div>
                                                                </div>
                                                                <a href="#" class="image-edit-btn"
                                                                   data-bs-toggle="tooltip" data-bs-placement="top"
                                                                   title="" data-bs-original-title="Edit or Remove"><i
                                                                        class="ri-edit-2-fill"></i></a>
                                                            </div>
                                                        </div>
                                                        <div class="">
                                                            <div class="user-images position-relative overflow-hidden">
                                                                <a href="#">
                                                                    <img src="images/page-img/59.jpg"
                                                                         class="img-fluid rounded"
                                                                         alt="Responsive image">
                                                                </a>
                                                                <div class="image-hover-data">
                                                                    <div class="product-elements-icon">
                                                                        <ul class="d-flex align-items-center m-0 p-0 list-inline">
                                                                            <li><a href="#" class="pe-3 text-white"> 60
                                                                                <i class="ri-thumb-up-line"></i> </a>
                                                                            </li>
                                                                            <li><a href="#" class="pe-3 text-white"> 30
                                                                                <i class="ri-chat-3-line"></i> </a></li>
                                                                            <li><a href="#" class="pe-3 text-white"> 10
                                                                                <i class="ri-share-forward-line"></i>
                                                                            </a></li>
                                                                        </ul>
                                                                    </div>
                                                                </div>
                                                                <a href="#" class="image-edit-btn"
                                                                   data-bs-toggle="tooltip" data-bs-placement="top"
                                                                   title="" data-bs-original-title="Edit or Remove"><i
                                                                        class="ri-edit-2-fill"></i></a>
                                                            </div>
                                                        </div>
                                                        <div class="">
                                                            <div class="user-images position-relative overflow-hidden">
                                                                <a href="#">
                                                                    <img src="images/page-img/60.jpg"
                                                                         class="img-fluid rounded"
                                                                         alt="Responsive image">
                                                                </a>
                                                                <div class="image-hover-data">
                                                                    <div class="product-elements-icon">
                                                                        <ul class="d-flex align-items-center m-0 p-0 list-inline">
                                                                            <li><a href="#" class="pe-3 text-white"> 60
                                                                                <i class="ri-thumb-up-line"></i> </a>
                                                                            </li>
                                                                            <li><a href="#" class="pe-3 text-white"> 30
                                                                                <i class="ri-chat-3-line"></i> </a></li>
                                                                            <li><a href="#" class="pe-3 text-white"> 10
                                                                                <i class="ri-share-forward-line"></i>
                                                                            </a></li>
                                                                        </ul>
                                                                    </div>
                                                                </div>
                                                                <a href="#" class="image-edit-btn"
                                                                   data-bs-toggle="tooltip" data-bs-placement="top"
                                                                   title="" data-bs-original-title="Edit or Remove"><i
                                                                        class="ri-edit-2-fill"></i></a>
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

                <%-- Loading spinner --%>
                <div class="col-sm-12 text-center">
                    <img src="images/page-img/page-load-loader.gif" alt="loader" style="height: 100px;">
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
            <div class="col-lg-6 d-flex justify-content-end">
                Copyright 2024 <a href="#">SocialX</a> All Rights Reserved.
            </div>
        </div>
    </div>
</footer>

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
<script>
    document.getElementById("postInput").addEventListener("click", function () {
        window.location.href = "post/create";
    });
</script>
</body>
</html>
