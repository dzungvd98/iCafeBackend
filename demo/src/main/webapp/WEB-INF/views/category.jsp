<%-- 
    Document   : MenuAdmin
    Created on : Mar 28, 2025, 11:07:42 AM
    Author     : ADMIN
--%>

<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>

<head>
    <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
    <title>Danh mục</title>
    <link rel="stylesheet" href="css/style_menu.css" />
    <!-- Bootstrap 5 CSS -->
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.2/dist/css/bootstrap.min.css" rel="stylesheet">
    <!-- Bootstrap Icons -->
    <link rel="stylesheet" href="https://cdn.jsdelivr.net/npm/bootstrap-icons@1.11.1/font/bootstrap-icons.css">
    <style>
        .modal.right .modal-dialog {
            position: fixed;
            margin: auto;
            width: 30%;
            height: 100%;
            right: 0;
            transform: translateX(100%);
            transition: transform 0.3s ease-in-out;
            height: 100%;
        }

        .modal.right.show .modal-dialog {
            transform: translateX(0);
        }

        .frame-pick-image {
            border-radius: 12px;
            width: 64px;
            height: 64px;
            overflow: hidden;
            /* Ẩn phần hình ảnh vượt quá khung */
            position: relative;
            /* Để định vị tuyệt đối hình ảnh bên trong */
        }

        .preview-image {
            position: absolute;
            top: 0;
            left: 0;
            width: 100%;
            height: 100%;
            object-fit: cover;
            /* Scale hình ảnh để lấp đầy khung, cắt phần dư */
            object-position: center;
            /* Đảm bảo tâm của hình ảnh ở giữa */
        }

        .wrap-upload {
            position: fixed;
            display: none;
        }

        .upload-preview {
            position: absolute;
            top: -10px;
            right: 0;
        }
    </style>
</head>

<body>
    <!-- Sidebar -->
    <div class="sidebar">
        <div class="logo-container">
            <a href="product">
                <img src="imgs/Logo.png" alt="alt" />
            </a>
        </div>

        <div class="wrap-order-button" style="display: flex; justify-content: center;">
            <div class="order-button">
                <a href="order" style="text-decoration: none;">Đặt hàng</a>
            </div>
        </div>
        <div class="wrap-nav">
            <div class="nav-item nav-category active">
                <a href="category">
                    <i class="bi bi-grid"></i>
                    Danh mục
                </a>
            </div>
            <div class="nav-item nav-product">
                <a href="product">
                    <i class="bi bi-cup-straw"></i>
                    Sản phẩm
                </a>
            </div>

            <div class="nav-item nav-order">
                <a href="processing">
                    <i class="bi bi-cart"></i>
                    Đơn hàng
                </a>

            </div>

            <div class="nav-item  nav-report">
                <a href="report">
                    <i class="bi bi-bar-chart"></i>
                    Báo cáo
                </a>
            </div>
            <div class="nav-item nav-account ">
                <a href="account">
                    <i class="bi bi-people"></i>
                    Tài Khoản
                </a>
            </div>
        </div>
    </div>

    <!-- Main Content -->
    <div class="main-content">
        <!-- Top Header -->
        <div class="top-header">
            <div class="d-flex align-items-center">
                <button class="btn btn-sm d-none mobile-menu-toggle">
                    <i class="bi bi-list"></i>
                </button>
                <span class="fw-medium">Danh mục</span>
            </div>

            <div class="d-flex align-items-center">
                <div class="notification-icon">
                    <i class="bi bi-bell small"></i>
                </div>
                <div class="user-avatar">
                    <img src="imgs/Avatar.png" alt="User" class="w-100 h-100">
                </div>
            </div>
        </div>

        <!-- Content Area -->
        <div class="content-area" style="background-color: #fff">
            <div class="d-flex justify-content-between mb-4 flex-wrap" style="margin-bottom: 0 !important;">
                <div class="mb-2">
                    <h1 class="h4" style="font-weight: 600">Danh sách</h1>
                </div>
                <div class="d-flex gap-2 flex-wrap">
                    <form action="menu" method="GET">
                        <div class="search-container mb-2">
                            <i class="bi bi-search"></i>
                            <input id="input-search" type="text" value="" name="search" class="form-control search-input"
                                placeholder="Tìm kiếm">
                        </div>
                    </form>

                    <button class="btn btn-outline-secondary mb-2" hidden>
                        Xuất dữ liệu
                    </button>

                    <button class="btn btn-primary add-button mb-2" data-bs-toggle="modal"
                        data-bs-target="#create-modal">
                        <i class="bi bi-plus"></i> Thêm
                    </button>
                </div>
            </div>
        </div>
        <div style="border-bottom: 1px solid var(--border-color); width: 100%;"></div>
        <div class="content-area">
            <div class="d-flex justify-content-between mb-4 flex-wrap">
                <div class="mb-2">
                </div>

                <div class="d-flex gap-2 flex-wrap" style="align-items: center;">
                    <div id="page-display">1 - 10 trong số 30 </div>
                    <div class="d-flex gap-2 align-items-center">
                        <button value="1" id="btn-prev-page" class="btn btn-sm btn-light">
                            <i class="bi bi-chevron-left"></i>
                        </button>
                        <span id="span-current-page">1</span>
                        <button value="1" id="btn-next-page" class="btn btn-sm btn-light">
                            <i class="bi bi-chevron-right"></i>
                        </button>
                        <button class="btn btn-sm btn-light" hidden>
                            <i class="bi bi-funnel"></i>
                        </button>
                    </div>
                </div>
            </div>

            <!-- Table -->
            <div class="table-responsive">
                <table id="table-users" class="warp-table">
                    <thead class="table-header">
                        <tr>
                            <th >STT</th>
                            <th >Tên danh mục</th>
                            <th >Số lượng sản phẩm</th>
                            <th >Ngày cập nhật cuối</th>
                            <th >Người cập nhật</th>
                            <th >Thao tác</th>
                        </tr>
                    </thead>
                    <tbody>
                        <tr class="product-row" data-bs-toggle="modal" data-bs-target="#slideModal">
                        <tr>
                            <td>STT</td>
                            <td>Tên danh mục</td>
                            <th>Số lượng sản phẩm</th>
                            <td>Ngày cập nhật cuối</td>
                            <td>Người cập nhật</td>
                            <td>
                                <button class="action-button edit-btn" data-bs-toggle="modal"
                                    data-bs-target="#edit-modal">
                                    <i class="bi bi-pencil" style="color: black;"></i>
                                </button>
                                <button class="action-button delete-btn" data-bs-toggle="modal"
                                    data-bs-target="#confirmationModal">
                                    <i class="bi bi-trash"></i>
                                </button>
                            </td>
                        </tr>

                        </tr>
                    </tbody>
                </table>
            </div>
        </div>
    </div>


    <!--Modals delete-->
    <div class="modal fade" id="modal-delete" tabindex="-1" aria-labelledby="confirmationModalLabel"
        aria-hidden="true">
        <div class="modal-dialog modal-dialog-centered modal-confirm">
            <div class="modal-content">
                <div class="modal-header">
                    <h5 class="modal-title" id="confirmationModalLabel">Xóa danh mục</h5>
                    <button type="button" class="btn-close" data-bs-dismiss="modal" aria-label="Close"></button>
                </div>
                <div class="modal-body">
                    <p>Xóa danh mục sẽ có <span id="span-number-product" style="font-weight: bold;"> </span> bị ảnh hưởng, chắc chắn không? </p>
                </div>
                <div class="modal-footer" >
                    
                    <button id="btn-confirm-delete" type="button" class="btn btn-confirm" style="background-color: #1F75FF; color: #fff;">Xác
                        nhận</button>
                    <button type="button" class="btn btn-cancel me-2" data-bs-dismiss="modal">Hủy</button>
                </div>
            </div>
        </div>
    </div>

    <style>
        #create-modal .form-control,
        #create-modal .form-select {
            height: 46px;
        }
    </style>

    <!--Modals create-->
    <div class="modal fade right" id="create-modal" tabindex="-1" aria-hidden="true">
        <div class="modal-dialog">

            <div class="modal-content" style="height: 100%;">
                    <div class="modal-header">
                        <div class="wrap-header-modal">
                            <div style="font-size: 20px; font-weight: 500">Tạo danh mục</div>
                        </div>
                        <button type="button" class="btn-close" data-bs-dismiss="modal" aria-label="Đóng"></button>
                    </div>
                    <div class="modal-body">
                        <div class="mb-3">
                            <input type="text" placeholder="Tên danh mục" name="productName" class="form-control"
                                id="input-category-create" value="" autocomplete="off">
                        </div>

                    </div>
                    <div class="modal-footer">
                        <button id="btn-create-category" class="btn btn-secondary"
                            style="background-color: #1F75FF">Tạo</button>
                    </div>
            </div>
        </div>
    </div>

    <style>
        #edit-modal .form-label {
            margin-bottom: 0;
        }

        .edit-wrap-upload {
            position: fixed;
        }
    </style>
    <!--modal edit-->
    <div class="modal fade right" id="edit-modal" tabindex="-1" aria-hidden="true">
        <div class="modal-dialog">
            <div class="modal-content" style="height: 100%;">
                    <div class="modal-header">
                        <div class="wrap-header-modal">
                            <div style="font-size: 20px; font-weight: 500">Cập nhật danh mục</div>
                        </div>
                        <button type="button" class="btn-close" data-bs-dismiss="modal" aria-label="Đóng"></button>
                    </div>
                    <div class="modal-body">
                        <div class="mb-3">
                            <label for="size" class="form-label" >Tên danh mục</label>
                            <input id="input-category-update" type="text" name="categoryname" class="form-control edit-productname" value="">
                        </div>
                    </div>
                    <div class="modal-footer">
                        <button type="submit" id="btn-update-user" class="btn btn-secondary"
                            style="background-color: #1F75FF">Cập nhật</button>
                    </div>
            </div>
        </div>
    </div>

     <%@ include file="toast.jsp" %>
    <!-- Bootstrap 5 JS Bundle with Popper -->
    <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.2/dist/js/bootstrap.bundle.min.js"></script>
    <script src="https://code.jquery.com/jquery-3.7.1.min.js"
        integrity="sha256-/JqT3SQfawRcv/BIHPThkBvs0OEvtFFmqPF/lYI/Cxo=" crossorigin="anonymous"></script>
    <script src="js/action.js"></script>

    <!-- Custom JavaScript -->
    <script>
        // Mobile menu toggle
        document.querySelector('.mobile-menu-toggle')?.addEventListener('click', function () {
            const sidebar = document.querySelector('.sidebar');
            if (sidebar.style.width === '200px') {
                sidebar.style.width = '0';
            } else {
                sidebar.style.width = '200px';
            }
        });
    </script>
    
    <script>
        $(document).ready(function() {
            // VÙNG 1: VÙNG KHAI BÁO BIẾN TOÀN CỤC
            const gBASE_URL = "http://localhost:8080";
            let gPage = 1;
            let gSize = 10;
            let debounceTimer;
            let gCategoryId = null;

            // VÙNG 2: VÙNG GÁN VÀ THỰC THI SỰ KIỆN CHO CÁC ELEMENT
            onPageLoading();
            $("#input-search").on("click", function () {
                $(this).val("");
            });

            $("#input-search").on("keyup", function () {
                let vKeyword = ($(this).val() || "").trim();
                clearTimeout(debounceTimer);
                debounceTimer = setTimeout(function () {
                    resetPage();
                    callApiToGetListCategory(vKeyword);
                }, 400); // chờ 400ms sau khi ngừng gõ
            });

            $("#btn-next-page").on("click", function () {
                let vKeyword = ($("#input-search").val() || "").trim();
                gPage++;
                callApiToGetListCategory(vKeyword);
            });

            // Xử lý sự kiện quay lại trang trước
            $("#btn-prev-page").on("click", function () {
                let vKeyword = ($("#input-search").val() || "").trim();

                gPage--;
                callApiToGetListCategory(vKeyword);
            });

            
            //Thực thi sự kiện nhấn nút tạo tài khoản
            $("#btn-create-category").on("click", function() {
                callApiToCreateCategory();
            });

            // Thực thi sự kiện nhấn nút sửa tài khoản
            $("#table-users").on('click', '.edit-btn', function() {
                onBtnEditCategoryClick(this);
            });

            // Thực thi sự kiện nhấn nút xác nhận sửa tài khoản
            $("#btn-update-user").on("click", function() {
                onBtnConfirmUpdateCategoryClick();
            });

            // Thực thi sự kiện nhấn nút delete tài khoản
            $("#table-users").on('click', '.delete-btn', function() {
                let vRow = $(this).closest('tr');
                gCategoryId = vRow.find('td:eq(0)').attr("id");
                let vNumberProduct = vRow.find('td:eq(2)').text();
                $("#span-number-product").text(vNumberProduct);
            });

            // Thực thi sự kiện nhấn nút xóa tài khoản
            $("#btn-confirm-delete").on("click", function() {
                onBtnConfirmDeleteClick();
            });

            // VÙNG 3: VÙNG VIẾT CÁC HÀM XỬ LÝ SỰ KIỆN
            function onPageLoading() {
                navigateToCorrectPage();
                callApiToGetListCategory("");
            }

            function onBtnConfirmDeleteClick() {
                let vHeaders = {
                    Authorization: "Token " + getCookie("token")
                };
                $.ajax({
                    url: gBASE_URL + "/categories/" + gCategoryId,
                    method: "DELETE",
                    headers: vHeaders,
                    success: function(response) {
                        $("#modal-delete").modal("hide");
                        let vKeyword = $("#input-search").val();
                        callApiToGetListCategory(vKeyword);
                    },
                    error: function(error) {
                        console.log(error);
                    }
                });
            }

            // VÙNG 4: VÙNG VIẾT CÁC HÀM DÙNG CHUNG
            function callApiToGetListCategory(keyword) {
                let vHeaders = {
                    Authorization: "Token " + getCookie("token")
                };
                $.ajax({
                    url: gBASE_URL + "/categories/all?keyword=" + keyword + "&page=" + gPage + "&size=" + gSize,
                    method: "GET",
                    headers: vHeaders,
                    success: function(response) {
                        loadUserDataToTable(response);
                    },
                    error: function(error) {
                    
                        if (error.status === 403) {
                            deleteCookie("token");
                            window.location.href = "login";
                        }
                        showToast(error.responseText, "error");
                    }
                });
            }

            // Hàm call Api để tạo mới user
            function callApiToCreateCategory() {
                let vHeaders = {
                    Authorization: "Token " + getCookie("token")
                };
                let vCategoryName = $("#input-category-create").val();
                if(vCategoryName == "" || !vCategoryName) {
                    showToast("Tên danh mục không được bỏ trống!", "warning");
                    return;
                }
                
                $.ajax({
                    url: gBASE_URL + "/categories/?newCategoryName=" + vCategoryName,
                    method: "POST",
                    headers: vHeaders,
                    contentType: "application/json",
                    data: JSON.stringify(vCategoryName),
                    success: function(response) {
                        $("#create-modal").modal("hide");
                        $("#input-category-create").val("");
                        callApiToGetListCategory("");
                        showToast("Tạo danh mục thành công!", "success");
                    },
                    error: function(error) {
                        console.log(error);
                        showToast(error.responseText, "error");
                    }
                });
            }

            //Hàm load user to table
            function loadUserDataToTable(responseCategoryData) {
                let vTBody = $('#table-users tbody');
                if (!responseCategoryData?.contents?.length) {
                    vTBody.empty().append('<tr><td colspan="5">Không tìm thấy danh mục</td></tr>');
                    displayPagination(responseCategoryData);
                    return;
                }
                let vStartNum = (responseCategoryData.pageNumber - 1) * 10 + 1; 
                vTBody.empty();
                $.each(responseCategoryData.contents, function(index, category) {
                    let vRow = `<tr>
                            <td id=`+ category.categoryId +`>`+ (vStartNum++) +`</td>
                            <td>`+ category.categoryName +`</td>
                            <td>`+ category.numberProduct +` sản phẩm</td>
                            <td>`+ category.timeUpdated +`</td>
                            <td>`+ category.updatedBy+`</td>
                            <td>
                                <button class="action-button edit-btn" data-bs-toggle="modal"
                                    data-bs-target="#edit-modal">
                                    <i class="bi bi-pencil" style="color: black;"></i>
                                </button>
                                <button class="action-button delete-btn" data-bs-toggle="modal"
                                    data-bs-target="#modal-delete">
                                    <i class="bi bi-trash"></i>
                                </button>
                            </td>
                        </tr>`
                    vTBody.append(vRow);
                    displayPagination(responseCategoryData);
                });
            }
            
            // Hàm hiển thị phân trang
            function displayPagination(responseCategoryData) {
                let vPageDisplay = $("#page-display");
                let vStartNum = (responseCategoryData.pageNumber - 1) * responseCategoryData.pageSize + 1;
                let vEndNum = vStartNum + responseCategoryData.numberOfElements - 1;
                vPageDisplay.html(vStartNum + " - " + vEndNum + " trong số " + responseCategoryData.totalElements);
                $("#span-current-page").html(gPage);

                if (gPage <= 1) {
                    $("#btn-prev-page").prop("disabled", true);
                } else {
                    $("#btn-prev-page").prop("disabled", false);
                }

                if (gPage >= responseCategoryData.totalPages) {
                    $("#btn-next-page").prop("disabled", true);
                } else {
                    $("#btn-next-page").prop("disabled", false);
                }
            }

            function resetPage() {
                gPage = 1;
                gSize = 10;
            }

            // Map role
            function mapRole(role) {
                switch (role) {
                    case 'ADMIN':
                        return 'Quản trị viên';
                    case 'MANAGER':
                        return 'Quản lý';
                    case 'STAFF':
                        return 'Nhân viên';
                    default:
                        return role;
                }
            }

            // Hàm xử lý sự kiện nhấn nút edit user trong table
            function onBtnEditCategoryClick(element) {
                let vRow = $(element).closest('tr');
                let vCategoryId = vRow.find('td:eq(0)').attr("id");
                let vCategoryName = vRow.find('td:eq(1)').text();
                gCategoryId = vCategoryId;
                $("#input-category-update").val(vCategoryName);
            }

            // Function get user data to update
            function getUserDataToUpdate() {
                let vUserDataUpdate = {
                    username: $("#input-user-update").val(),
                    password: $("#input-password-update").val(),
                    role:  $('#select-role-update').val()
                };
                return vUserDataUpdate
            }
            // Function confirm update data
            function onBtnConfirmUpdateCategoryClick() {
                let vNewCategoryName = $("#input-category-update").val();
                if(vNewCategoryName == "" || !vNewCategoryName) {
                    showToast("Tên danh mục không được bỏ trống", "warning");
                    return;
                }
                let vHeaders = {
                    Authorization: "Token " + getCookie("token")
                };
                $.ajax({
                    url: gBASE_URL + "/categories/" + gCategoryId + "?newCategoryName=" + vNewCategoryName,
                    method: "PUT",
                    headers: vHeaders,
                    contentType: "application/json",
                    success: function(response) {
                        let vKeyword = $("#input-search").val();
                        callApiToGetListCategory(vKeyword);
                        showToast("Cập nhật danh mục thành công!", "success");
                        $("#input-category-update").val("");
                    },
                    error: function(error) {
                        console.log(error);
                        showToast(error.responseText, "error");
                        
                    }  

                });
                $("#edit-modal").modal("hide");
            }

            function navigateToCorrectPage() {
                const token = getCookie("token"); 
                if (token && isTokenValid(token)) {
                    const role = getUserRoleFromToken(token);
                        
                    
                    switch (role) {
                        case "ADMIN":
                            break;
                        case "STAFF":
                            window.location.href = "order";
                            break;
                        case "MANAGER":
                            window.location.href = "processing";
                            break;
                        default:
                            alert("Không xác định được quyền người dùng!");
                            window.location.href = "login";
                    }
                }
                else {
                    window.location.href = "login";
                }
            }
            
              function validateFormCreateAccount(userAccountData) {
                let isValid = true;

                // Validate username
                const usernamePattern = /^[a-z0-9]{5,}$/;
                if (!usernamePattern.test(userAccountData.username)) {
                  $("#username-error")
                    .text("Tên đăng nhập phải có ít nhất 5 ký tự, chỉ gồm chữ thường và số.")
                    .show();
                  isValid = false;
                } else {
                  $("#username-error").hide();
                }

                // Validate password
                const minLength = /.{8,}/;
                const hasLowerCase = /[a-z]/;
                const hasUpperCase = /[A-Z]/;
                const hasNumber = /[0-9]/;

                let passwordError = "";
                if (!minLength.test(userAccountData.password)) {
                  passwordError = "Mật khẩu phải có ít nhất 8 ký tự.";
                } else if (!hasLowerCase.test(userAccountData.password)) {
                  passwordError = "Mật khẩu phải có ít nhất một chữ thường.";
                } else if (!hasUpperCase.test(userAccountData.password)) {
                  passwordError = "Mật khẩu phải có ít nhất một chữ in hoa.";
                } else if (!hasNumber.test(userAccountData.password)) {
                  passwordError = "Mật khẩu phải có ít nhất một chữ số.";
                }

                if (passwordError !== "") {
                  $("#password-error").text(passwordError).show();
                  isValid = false;
                } else {
                  $("#password-error").hide();
                }

                return isValid;
              }
              
            function validatePasswordAndShowError(password) {
                if(password.trim() == "") return true;
                const $errorEl = $("#password-error-update");

                const minLength = /.{8,}/;
                const hasLowerCase = /[a-z]/;
                const hasUpperCase = /[A-Z]/;
                const hasNumber = /[0-9]/;

                let error = "";

                if (!minLength.test(password)) {
                    error = "Mật khẩu phải có ít nhất 8 ký tự.";
                } else if (!hasLowerCase.test(password)) {
                    error = "Mật khẩu phải có ít nhất một chữ thường.";
                } else if (!hasUpperCase.test(password)) {
                    error = "Mật khẩu phải có ít nhất một chữ in hoa.";
                } else if (!hasNumber.test(password)) {
                    error = "Mật khẩu phải có ít nhất một chữ số.";
                }

                if (error !== "") {
                    $errorEl.text(error).show();
                    return false;
                } else {
                    $errorEl.text("").hide();
                    return true;
                }
            }
            
            function deleteCookie(name) {
                document.cookie = name + '=; Path=/; Expires=Thu, 01 Jan 1970 00:00:01 GMT;';
            }
        });
    </script>


</body>

</html>