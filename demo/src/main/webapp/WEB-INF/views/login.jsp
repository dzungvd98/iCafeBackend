<%-- 
    Document   : Login
    Created on : Mar 23, 2025, 11:19:07 PM
    Author     : ADMIN
--%>

<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <link rel="stylesheet" href="css/style.css"/>
        <title>Đăng nhập</title>
        <!-- Bootstrap 5 CSS -->
        <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0-alpha1/dist/css/bootstrap.min.css" rel="stylesheet">
        <!-- Custom CSS -->
        <style>
            .password-container-liem {
                position: relative;
            }
            .toggle-visibility-liem {
                position: absolute;
                right: 15px;
                top: 50%;
                transform: translateY(-50%);
                cursor: pointer;
                font-size: 20px;
            }
        </style>
    </head>
    <body>
        <div class="container py-5">
            <div class="row justify-content-center align-items-center">
                <div class="col-lg-1">
                    
                </div>
                <div class="col-lg-6">
                    <div class="mb-4">
                        <h1 class="fw-bold fs-2">👋 Mừng bạn đến với Hệ Thống Quản trị viên!</h1>
                    </div>

                    <div class="mt-5"  style="width: 400px;">
                            <div class="mb-4">
                                <input id="input-username" type="text" name ="username" class="form-control form-control-lg" placeholder="Tên đăng nhập">
                            </div>

                            <div class="mb-4 password-container-liem">
                                <input type="password" name ="password" class="form-control form-control-lg" id="input-password" placeholder="Mật Khẩu">
                            </div>

                            <button id="btn-login" class="btn btn-primary w-100 btn-continue rounded-pill">
                                Tiếp tục
                            </button>
                    </div>
                </div>
                <div class="col-lg-1 text-center illustration">

                </div>
                <div class="col-lg-3 text-center illustration">
                    <img src="imgs/Cover.png" alt="CMS Illustration" class="img-fluid">
                </div>
                <div class="col-lg-1">
                    
                </div>
            </div>
        </div>
        <%@ include file="toast.jsp" %>
        <!-- Bootstrap 5 JS Bundle with Popper -->
        <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0-alpha1/dist/js/bootstrap.bundle.min.js"></script>
        <script src="https://code.jquery.com/jquery-3.6.0.min.js"></script>
        <script src="js/action.js?v=" + new Date().getTime()></script>
    <script>
        $(document).ready(function () {
            // VÙNG 1: VÙNG KHAI BÁO BIẾN TOÀN CỤC
            const gBASE_URL = 'http://localhost:8080';
            // VÙNG 2: VÙNG GÁN VÀ THỰC THI SỰ KIỆN CHO CÁC ELEMENT
            onPageLoading();

            // Thực thi sự kiện nhấn nút đăng nhập
            $("#btn-login").on("click", function (e) {
                e.preventDefault();
                onBtnLoginClick();
            });

            // VÙNG 3: VÙNG VIẾT CÁC HÀM XỬ LÝ SỰ KIỆN
            function onPageLoading() {
                navigateToCorrectPage();
            }

            // Hàm xử lý sự kiện nhấn nút login
            function onBtnLoginClick() {
                let vLoginData = {
                    username: $("#input-username").val().trim(),
                    password: $("#input-password").val()
                }

                $.ajax({
                    url: gBASE_URL + "/api/v1/users/login",
                    method: "POST",
                    contentType: "application/json",
                    data: JSON.stringify(vLoginData),
                    success: function (response) {
                        showToast("Đăng nhập thành công!", "success");
                        responseHandler(response);
                            // window.location.href = "order";
                    },
                    error: function (error) {
                        showToast("Tên đăng nhập hoặc mật khẩu sai!", "success");
                    }
                });
            }

            function navigateToCorrectPage() {
                const token = getCookie("token"); // hoặc lấy từ localStorage nếu bạn dùng cái đó
                if (token && isTokenValid(token)) {
                    const role = getUserRoleFromToken(token);
                        
                    
                    switch (role) {
                        case "ADMIN":
                            window.location.href = "report";
                            break;
                        case "STAFF":
                            window.location.href = "order";
                            break;
                        case "MANAGER":
                            window.location.href = "report";
                            break;
                        default:
                            alert("Không xác định được quyền người dùng!");
                            window.location.href = "login";
                    }
                }
            }


        });
    </script>

        
    </body>
</html>
