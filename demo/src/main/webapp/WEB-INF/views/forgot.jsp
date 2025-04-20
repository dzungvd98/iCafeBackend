<%-- 
    Document   : forgot
    Created on : Apr 3, 2025, 9:02:04 AM
    Author     : PC
--%>

<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <link rel="stylesheet" href="css/forgot.css"/>
        <title>Quên mật khẩu</title>
        <!-- Bootstrap 5 CSS -->
        <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0-alpha1/dist/css/bootstrap.min.css" rel="stylesheet">
        <!-- Custom CSS -->
        <style>
            
        </style>
    </head>
    <body>
        <div class="container py-5 liem-forgot">
            <div class="row justify-content-center align-items-center liem-forgot">
                <div class="col-lg-8 liem-forgot">
                    <div class="mb-4 liem-forgot">
                        <h1 class="fw-bold fs-2">Nhập Mật Khẩu</h1>
                        <p class="text-muted">
                            Vui lòng nhập bên dưới để lấy lại mật khẩu của bạn.
                            <!--<a href="#" class="create-new-account">Tạo tài khoản mới</a>-->
                        </p>
                    </div>

                    <div class="mt-5">
                        <form action="forgot" method="post" onsubmit="return validateForm()">

                            <!-- Trường nhập user -->
                            <div class="mb-4">
                                <!--<input type="text" name ="username" class="form-control form-control-lg" placeholder="Tên đăng nhập">-->
                                <input type="text" name="username" class="form-control form-control-lg" id="username"  placeholder="Tên đăng nhập" required>
                            </div>

                            <!-- Trường nhập mật khẩu mới -->
                            <div class="mb-4 password-container-liem">
                                <input type="password" name="newPass" class="form-control form-control-lg liem-forgot pe-5" id="newPass" placeholder="Nhập mật khẩu mới" required>
                                <span class="toggle-visibility-liem" onclick="toggleVisibilityforgot('newPass', this)">👁</span>
                            </div>

                            <!-- Trường xác nhận mật khẩu -->
                            <div class="mb-4 password-container-liem">
                                <input type="password" name="confirmPass" class="form-control form-control-lg liem-forgot pe-5" id="confirmPass" placeholder="Xác nhận mật khẩu mới" required>
                                <span class="toggle-visibility-liem" onclick="toggleVisibilityforgot('confirmPass', this)">👁</span>
                            </div>

                            <!-- Thông báo lỗi nếu mật khẩu không khớp -->
                            <p class="error-message" id="error-message">⚠ Mật khẩu nhập lại không khớp!</p>

                            <button class="btn btn-primary w-100 btn-continue rounded-pill">
                                Xát nhận
                            </button>
                        </form>
                    </div>
                </div>
                <div class="col-lg-1 text-center illustration liem-forgot"></div>
                <div class="col-lg-3 text-center illustration liem-forgot">
                    <img src="imgs/Cover.png" alt="CMS Illustration" class="img-fluid">
                </div>
            </div>
        </div>

        <!-- Bootstrap 5 JS Bundle with Popper -->
        <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0-alpha1/dist/js/bootstrap.bundle.min.js"></script>
        <script>
            function toggleVisibilityforgot(fieldId, icon) {
                let inputField = document.getElementById(fieldId);
                if (inputField.type === "password") {
                    inputField.type = "text";
                    icon.innerHTML = "🚫"; // Đổi sang trạng thái hiển thị
                } else {
                    inputField.type = "password";
                    icon.innerHTML = "👁"; // Đổi sang trạng thái ẩn
                }
            }
            function validateForm() {
                let newPass = document.getElementById("newPass").value;
                let confirmPass = document.getElementById("confirmPass").value;
                let errorMessage = document.getElementById("error-message");

                if (newPass !== confirmPass) {
                    errorMessage.style.display = "block"; // Hiện thông báo lỗi
                    return false;
                } else {
                    errorMessage.style.display = "none"; // Ẩn thông báo lỗi nếu đúng
                    return true;
                }
            }
        </script>

    </body>
</html>

