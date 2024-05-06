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
    <title>SocialX | Cập nhật bài đăng</title>

    <link rel="shortcut icon" href="images/favicon.ico"/>
    <link rel="stylesheet" href="css/libs.min.css">
    <link rel="stylesheet" href="css/socialv.css?v=4.0.0">
    <link rel="stylesheet" href="vendor/@fortawesome/fontawesome-free/css/all.min.css">
    <link rel="stylesheet" href="vendor/remixicon/fonts/remixicon.css">
    <link rel="stylesheet" href="vendor/vanillajs-datepicker/dist/css/datepicker.min.css">
    <link rel="stylesheet" href="vendor/font-awesome-line-awesome/css/all.min.css">
    <link rel="stylesheet" href="vendor/line-awesome/dist/line-awesome/css/line-awesome.min.css">
    <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/toastr.js/latest/toastr.min.css">

    <style>
        #files-container {
            display: flex;
            flex-wrap: wrap;
        }

        .file-preview-item {
            margin-right: 10px;
            margin-bottom: 10px;
            position: relative;
        }

        .file-preview-item img, .file-preview-item video {
            max-width: 200px;
            max-height: 200px;
            border-radius: 4px;
        }

        .file-preview-item button {
            position: absolute;
            top: -5px;
            right: -5px;
            background-color: grey;
            color: whitesmoke !important;
            width: 12px;
            height: 12px;
            opacity: 100;
            display: flex;
            justify-content: center;
            align-items: center;
            border: none;
            border-radius: 50%;
            cursor: pointer;
            font-size: xx-small;
        }
    </style>
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
        <div class="bg-white p-4 my-4">
            <div>
                <h5 class="modal-title mb-2" id="post-modalLabel">Chỉnh sửa bài đăng</h5>
            </div>
            <div>
                <div class="d-flex align-items-start">
                    <div class="user-img">
                        <img src="${requestScope["user"]["avatar"]}" alt="userimg" class="avatar-60 rounded-circle">
                    </div>
                    <form id="uploadForm" class="post-text ms-3 w-100" action="post/${post.id}/edit"
                          enctype="multipart/form-data"
                          method="post">
                        <div class="d-flex flex-column gap-2">
                            <input name="title" type="text" class="form-control rounded py-2" id="title"
                                   value="${post.title}"
                                   placeholder="Nhập tiêu đề bài viết..."/>
                            <textarea name="content" type="text" class="form-control rounded"
                                      rows="5" id="content"
                                      placeholder="Nhập nội dung bài viết...">${post.content}</textarea>
                            <input type="file" id="fileInput" name="files" multiple
                                   style="visibility: hidden; position: absolute"
                                   accept="image/*,video/*">
                            <div id="files-container"></div>
                            <span href="post/create" class="btn btn-soft-primary w-25" id="uploadButton">
                                    <img src="images/small/07.png" alt="icon" class="img-fluid me-2"> Ảnh/Video
                            </span>
                        </div>
                        <hr>
                        <button type="submit" class="btn btn-primary py-2 d-block w-25 ms-auto">Cập nhật</button>
                    </form>
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
<script>
    var uploadedFiles = [];
    document.addEventListener('DOMContentLoaded', function () {
        var fileInput = document.getElementById('fileInput');
        var preview = document.getElementById('files-container');

        fileInput.addEventListener('change', function (e) {
            var files = e.target.files;
            for (var i = 0; i < files.length; i++) {
                var file = files[i];
                uploadedFiles.push(file); // Add the file to the array of uploaded files

                var reader = new FileReader();

                reader.onload = function (event) {
                    var filePreview = document.createElement("div");
                    filePreview.classList.add("file-preview-item");

                    var element = null;
                    if (file.type.includes("video")) {
                        var video = document.createElement("video");
                        video.src = event.target.result;
                        video.controls = true;
                        element = video;
                    } else {
                        var img = document.createElement("img");
                        img.src = event.target.result;
                        element = img;
                    }

                    var button = document.createElement("button");
                    button.classList.add("btn-close");
                    button.onclick = function () {
                        // Remove the file from the array of uploaded files and the file preview when the delete button is clicked
                        var index = uploadedFiles.indexOf(file);
                        if (index !== -1) {
                            uploadedFiles.splice(index, 1);
                        }
                        filePreview.remove();
                        updateCurrentFiles(fileInput);
                    };

                    filePreview.appendChild(element);
                    filePreview.appendChild(button);
                    preview.appendChild(filePreview);
                };

                reader.readAsDataURL(file);
            }
            updateCurrentFiles(fileInput);
        });

        var uploadButton = document.getElementById('uploadButton');
        uploadButton.addEventListener('click', function () {
            fileInput.click();
        });
    });

    function updateCurrentFiles(fileInput) {
        let list = new DataTransfer();
        uploadedFiles.forEach(file => {
            list.items.add(file);
        });
        fileInput.files = list.files;
    }

    <c:forEach items="${post.files}" var="file">
    var url = '${file.fileUrl}';
    fetch(url)
        .then(response => response.blob())
        .then(blob => {
            var fileInput = document.getElementById('fileInput');
            var preview = document.getElementById('files-container');
            var file = new File([blob], '${file.id}', {type: blob.type});
            uploadedFiles.push(file);
            var reader = new FileReader();
            reader.onload = function (event) {
                var filePreview = document.createElement("div");
                filePreview.classList.add("file-preview-item");

                var element = null;
                if (file.type.includes("video")) {
                    var video = document.createElement("video");
                    video.src = event.target.result;
                    video.controls = true;
                    element = video;
                } else {
                    var img = document.createElement("img");
                    img.src = event.target.result;
                    element = img;
                }

                var button = document.createElement("button");
                button.classList.add("btn-close");
                button.onclick = function () {
                    // Remove the file from the array of uploaded files and the file preview when the delete button is clicked
                    var index = uploadedFiles.indexOf(file);
                    if (index !== -1) {
                        uploadedFiles.splice(index, 1);
                    }
                    filePreview.remove();
                    updateCurrentFiles(fileInput);
                };

                filePreview.appendChild(element);
                filePreview.appendChild(button);
                preview.appendChild(filePreview);
            };
            reader.readAsDataURL(file);
            updateCurrentFiles(fileInput);
        })
        .catch(error => console.error('Error fetching file:', error));
    </c:forEach>
</script>
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
