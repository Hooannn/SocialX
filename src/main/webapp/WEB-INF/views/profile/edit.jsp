<%--
  Created by IntelliJ IDEA.
  User: nguyenduckhaihoan
  Date: 03/04/2024
  Time: 21:16
  To change this template use File | Settings | File Templates.
--%>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
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
    <title>SocialX | Chỉnh sửa hồ sơ</title>

    <link rel="shortcut icon" href="images/favicon.ico"/>
    <link rel="stylesheet" href="css/libs.min.css">
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
                    <li class="">
                        <a href="home" class=" ">
                            <i class="las la-newspaper"></i><span>Bảng tin</span>
                        </a>
                    </li>
                    <li class="">
                        <a href="profile" class="">
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
                    <form action="explore" method="get" class="searchbox">
                        <button class="bg-transparent border-0 search-link d-flex align-items-center justify-content-center"
                                style="width: 25px; height: 25px; top: 50%; transform: translateY(-50%);"
                                href="#">
                            <i class="ri-search-line"></i>
                        </button>
                        <input name="query" type="text" class="text search-input" placeholder="Tìm kiếm...">
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
                                <img src="${requestScope["user"]["avatar"]}" class="img-fluid rounded-circle me-1"
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
        <div class="row mt-3">
            <div class="col-lg-12">
                <div class="card">
                    <div class="card-body p-0">
                        <div class="iq-edit-list">
                            <ul class="iq-edit-profile row nav nav-pills">
                                <li class="col-md-6 p-0">
                                    <a class="nav-link ${tab == "password" ? '' : 'active'}" data-bs-toggle="pill"
                                       href="#personal-information">
                                        Thông tin cá nhân
                                    </a>
                                </li>
                                <li class="col-md-6 p-0">
                                    <a class="nav-link ${tab == "password" ? 'active' : ''}" data-bs-toggle="pill"
                                       href="#chang-pwd">
                                        Đổi mật khẩu
                                    </a>
                                </li>
                            </ul>
                        </div>
                    </div>
                </div>
            </div>
            <div class="col-lg-12">
                <div class="iq-edit-list-data">
                    <div class="tab-content">
                        <div class="tab-pane fade ${tab == "password" ? '' : 'active show'}" id="personal-information"
                             role="tabpanel">
                            <div class="card">
                                <div class="card-header d-flex justify-content-between">
                                    <div class="header-title">
                                        <h4 class="card-title">Thông tin cá nhân</h4>
                                    </div>
                                </div>
                                <div class="card-body">
                                    <form action="profile/edit/information"
                                          enctype="multipart/form-data"
                                          method="post">

                                        <div class="row align-items-center">
                                            <div class="form-group col-sm-12">
                                                <label class="form-label">Ảnh bìa:</label>
                                                <br>
                                                <div style="position: relative">
                                                    <img id="cover-pic"
                                                         style="width: 100%; max-height: 250px; object-fit: cover"
                                                         class="e-background-pic rounded" src="${user.coverImage}"
                                                         alt="background-pic">
                                                    <div class="p-image">
                                                        <i class="ri-pencil-line e-upload-button-1 text-white"></i>
                                                        <input id="cover-file-upload" style="visibility: hidden"
                                                               class="e-file-upload" type="file"
                                                               accept="image/*"
                                                               name="coverImage"
                                                        />
                                                    </div>
                                                </div>
                                            </div>
                                            <div class="form-group col-sm-12">
                                                <label class="form-label">Ảnh đại diện:</label>
                                                <br>
                                                <div class="profile-img-edit">
                                                    <img id="avatar-pic"
                                                         style="width: 100%;display:block;border-radius:50%;aspect-ratio: 1/1;object-fit: cover"
                                                         class="e-profile-pic" src="${user.avatar}" alt="profile-pic">
                                                    <div class="p-image">
                                                        <i class="ri-pencil-line e-upload-button text-white"></i>
                                                        <input id="avatar-file-upload" style="visibility: hidden"
                                                               class="e-file-upload" type="file"
                                                               accept="image/*"
                                                               name="file"
                                                        />
                                                    </div>
                                                </div>
                                            </div>
                                            <div class="form-group col-sm-6">
                                                <label class="form-label" for="fname">Tên:</label>
                                                <input value="${user.firstName}" name="firstName" type="text"
                                                       class="form-control"
                                                       id="fname"/>
                                                <!-- error message -->
                                            </div>
                                            <div class="form-group col-sm-6">
                                                <label class="form-label" for="lname">Họ:</label>
                                                <input value="${user.lastName}" name="lastName" type="text"
                                                       class="form-control"
                                                       id="lname"/>
                                                <!-- error message -->
                                            </div>
                                            <div class="form-group col-sm-6">
                                                <label class="form-label d-block">Giới tính:</label>
                                                <div class="form-check form-check-inline">
                                                    <input type="radio" id="inlineRadio10" class="form-check-input"
                                                           name="sex" value="${true}" ${user.sex ? 'checked' : ''}/>
                                                    <label class="form-check-label" for="inlineRadio10">Nam</label>
                                                </div>
                                                <div class="form-check form-check-inline">
                                                    <input type="radio" id="inlineRadio11" class="form-check-input"
                                                           name="sex" value="${false}" ${!user.sex ? 'checked' : ''}/>
                                                    <label class="form-check-label" for="inlineRadio11">Nữ</label>
                                                </div>
                                            </div>
                                            <div class="form-group col-sm-6">
                                                <label for="dob" class="form-label">Ngày sinh:</label>
                                                <fmt:formatDate value="${user.dateOfBirth}" pattern="yyyy-MM-dd"
                                                                var="formattedDate"/>
                                                <input value="<c:out value='${formattedDate}' />" name="dateOfBirth"
                                                       type="date"
                                                       class=" form-control"
                                                       id="dob"/>
                                                <!-- error message -->
                                            </div>
                                            <div class="form-group col-sm-12">
                                                <label class="form-label" for="address">Địa chỉ:</label>
                                                <textarea class="form-control" name="address" id="address"
                                                          rows="5" style="line-height: 22px;">${user.address}</textarea>
                                            </div>
                                        </div>
                                        <button type="submit" class="btn btn-primary me-2">Cập nhật</button>
                                        <button type="reset" class="btn bg-soft-danger">Huỷ bỏ thay đổi</button>
                                    </form>
                                </div>
                            </div>
                        </div>
                        <div class="tab-pane fade ${tab == "password" ? 'active show' : ''}" id="chang-pwd"
                             role="tabpanel">
                            <div class="card">
                                <div class="card-header d-flex justify-content-between">
                                    <div class="iq-header-title">
                                        <h4 class="card-title">Đổi mật khẩu</h4>
                                    </div>
                                </div>
                                <div class="card-body">
                                    <c:if test="${not empty passwordErrorMessage}">
                                        <div class="alert alert-danger alert-dismissible fade show" role="alert">
                                            <span>${passwordErrorMessage}</span>
                                            <button type="button" class="btn-close" data-bs-dismiss="alert"
                                                    aria-label="Close"></button>
                                        </div>
                                    </c:if>
                                    <form:form modelAttribute="changePasswordDto" action="profile/edit/password"
                                               method="post">
                                        <div class="form-group">
                                            <label class="form-label" for="cpass">Mật khẩu hiện tại:</label>
                                            <form:input path="currentPassword" type="password" class="form-control"
                                                        id="cpass"/>
                                            <form:errors path="currentPassword" cssClass="text-danger text-sm-center"/>
                                        </div>
                                        <div class="form-group">
                                            <label class="form-label" for="npass">Mật khẩu mới:</label>
                                            <form:input path="newPassword" type="password" class="form-control"
                                                        id="npass"/>
                                            <form:errors path="newPassword" cssClass="text-danger text-sm-center"/>
                                        </div>
                                        <div class="form-group">
                                            <label class="form-label" for="cfpass">Nhập lại mật khẩu:</label>
                                            <form:input path="confirmPassword" type="password" class="form-control"
                                                        id="cfpass"/>
                                            <form:errors path="confirmPassword" cssClass="text-danger text-sm-center"/>
                                        </div>
                                        <button type="submit" class="btn btn-primary me-2">Cập nhật</button>
                                        <button type="reset" class="btn bg-soft-danger">Huỷ bỏ thay đổi</button>
                                    </form:form>
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
<script>
    document.addEventListener('DOMContentLoaded', function () {
        var dobInput = document.getElementById('dob');
        dobInput.max = new Date().toISOString().split("T")[0];
        var avatarFileInput = document.getElementById('avatar-file-upload');
        var avatarPreview = document.getElementById('avatar-pic');
        var coverFileInput = document.getElementById('cover-file-upload');
        var coverPreview = document.getElementById('cover-pic');

        avatarFileInput.addEventListener('change', function (event) {
            var file = avatarFileInput.files[0];
            var reader = new FileReader();

            if (file && !file.type.toString().includes('image')) {
                toastr.error('Chỉ chấp nhận file ảnh.');
                avatarFileInput.value = '';
                return;
            }

            reader.onload = function (event) {
                avatarPreview.src = event.target.result;
            };

            reader.readAsDataURL(file);
        });

        coverFileInput.addEventListener('change', function (event) {
            var file = coverFileInput.files[0];
            var reader = new FileReader();

            if (file && !file.type.toString().includes('image')) {
                toastr.error('Chỉ chấp nhận file ảnh.');
                coverFileInput.value = '';
                return;
            }

            reader.onload = function (event) {
                coverPreview.src = event.target.result;
            };

            reader.readAsDataURL(file);
        });

        var fileUploadButton = document.querySelector('.e-upload-button');
        var coverUploadButton = document.querySelector('.e-upload-button-1');

        fileUploadButton.addEventListener('click', function () {
            avatarFileInput.click();
        });

        coverUploadButton.addEventListener('click', function () {
            coverFileInput.click();
        });
    });
</script>

</body>
</html>
