<%--
  Created by IntelliJ IDEA.
  User: Khai Hoan
  Date: 4/3/2024
  Time: 10:43 AM
  To change this template use File | Settings | File Templates.
--%>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib uri="http://java.sun.com/jstl/core_rt" prefix="c" %>
<%@ taglib uri="http://java.sun.com/jstl/fmt_rt" prefix="f" %>
<%@ taglib uri="http://www.springframework.org/tags/form" prefix="form" %>
<!doctype html>
<html lang="en">
<head>
    <base href="${pageContext.request.contextPath}/"/>
    <meta charset="utf-8">
    <meta name="viewport" content="width=device-width, initial-scale=1, shrink-to-fit=no">
    <title>SocialX | Đặt lại mật khẩu</title>

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
<body class=" ">
<!-- loader Start -->
<div id="loading">
    <div id="loading-center">
    </div>
</div>
<!-- loader END -->

<div class="wrapper">
    <section class="sign-in-page">
        <div id="container-inside">
            <div id="circle-small"></div>
            <div id="circle-medium"></div>
            <div id="circle-large"></div>
            <div id="circle-xlarge"></div>
            <div id="circle-xxlarge"></div>
        </div>
        <div class="container p-0">
            <div class="row no-gutters">
                <div class="col-md-6 text-center pt-5">
                    <div class="sign-in-detail text-white">
                        <a class="sign-in-logo mb-5" href="#"><img src="images/logo-full.png" class="img-fluid"
                                                                   alt="logo"></a>
                        <div class="sign-slider overflow-hidden ">
                            <ul class="swiper-wrapper list-inline m-0 p-0 ">
                                <li class="swiper-slide">
                                    <img src="images/login/1.png" class="img-fluid mb-4" alt="logo">
                                    <h4 class="mb-1 text-white">Tìm bạn mới</h4>
                                    <p>Khám phá và kết bạn với những người mới trên nền tảng của chúng tôi.</p>
                                </li>
                                <li class="swiper-slide">
                                    <img src="images/login/2.png" class="img-fluid mb-4" alt="logo">
                                    <h4 class="mb-1 text-white">Kết nối với thế giới</h4>
                                    <p>Truy cập vào mạng lưới xã hội để kết nối với những người ở khắp nơi trên thế
                                        giới.</p>
                                </li>
                                <li class="swiper-slide">
                                    <img src="images/login/3.png" class="img-fluid mb-4" alt="logo">
                                    <h4 class="mb-1 text-white">Tạo sự kiện mới</h4>
                                    <p>Sáng tạo và tổ chức các sự kiện độc đáo, thu hút sự quan tâm của cộng đồng.</p>
                                </li>
                            </ul>
                        </div>
                    </div>
                </div>
                <div class="col-md-6 bg-white pt-5 pt-5 pb-lg-0 pb-5">
                    <div class="sign-in-from">
                        <h1 class="mb-0">Đặt lại mật khẩu</h1>
                        <p>Cài lại mật khẩu của bạn để tiếp tục truy cập vào SocialX</p>
                        <form:form class="mt-4" modelAttribute="resetPasswordDto" action="auth/reset-password"
                                   method="post">
                            <form:hidden path="token"/>
                            <div class="form-group">
                                <label class="form-label" for="exampleInputPassword1">Mật khẩu</label>
                                <form:input path="password" type="password" class="form-control mb-0"
                                            id="exampleInputPassword1" placeholder="Nhập mật khẩu"/>
                                <form:errors path="password" cssClass="text-danger text-sm-center"/>
                            </div>
                            <div class="form-group">
                                <label class="form-label" for="exampleInputCfPassword1">Nhập lại mật khẩu</label>
                                <form:input path="confirmPassword" type="password" class="form-control mb-0"
                                            id="exampleInputCfPassword1" placeholder="Nhập lại mật khẩu"/>
                                <form:errors path="confirmPassword" cssClass="text-danger text-sm-center"/>
                            </div>
                            <div class="d-inline-block w-100">
                                <div class="form-check d-inline-block mt-2 pt-1">
                                </div>
                                <button type="submit" class="btn btn-primary float-end">Xác nhận</button>
                            </div>
                            <div class="sign-info">
                                <span class="dark-color d-inline-block line-height-2">Đã có tài khoản ? <a
                                        href="auth/sign-in">Đăng nhập</a></span>
                                <ul class="iq-social-media">
                                    <li><a href="#"><i class="ri-facebook-box-line"></i></a></li>
                                    <li><a href="#"><i class="ri-twitter-line"></i></a></li>
                                    <li><a href="#"><i class="ri-instagram-line"></i></a></li>
                                </ul>
                            </div>
                        </form:form>
                    </div>
                </div>
            </div>
        </div>
    </section>
</div>

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
<script src="vendor/vanillajs-datepicker/distscripts/datepicker.min.js"></script>
<script src="scripts/lottie.js"></script>
<!-- Toast handle script -->
<script src="https://cdnjs.cloudflare.com/ajax/libs/toastr.js/latest/toastr.min.js"></script>
<script>
    var errorMessage = '<%= request.getAttribute("errorMessage") %>';
    var successMessage = '<%= request.getAttribute("successMessage") %>';
</script>
<script src="scripts/toastHandler.js"></script>
<!-- -->
</body>
</html>
