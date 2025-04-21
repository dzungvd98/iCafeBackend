<%-- 
    Document   : MenuAdmin
    Created on : Mar 28, 2025, 11:07:42 AM
    Author     : ADMIN
--%>

<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>

<head>
    <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
    <title>Quản lý đơn hàng</title>
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
        .select-container {
      position: relative;
    }
    
    .custom-select {
      width: 100%;
      padding: 6px 10px;
      font-size: 16px;
      border: 1px solid #e0e0e0;
      border-radius: 25px;
      appearance: none;
      background-color: white;
      cursor: pointer;
      text-align: center;
      outline: none;
      transition: color 0.3s;
    }
    
    .select-arrow {
      position: absolute;
      right: 16px;
      top: 50%;
      transform: translateY(-50%);
      pointer-events: none;
    }
    
    .arrow-path {
      transition: stroke 0.3s;
    }
    
    /* Colored options in dropdown */
    option[value="received"] {
      color: #000000;
    }
    
    option[value="processing"] {
      color: #0066FF;
    }
    
    option[value="completed"] {
      color: #00A651;
    }
    
    option[value="cancelled"] {
      color: #FF0000;
    }
    </style>
</head>

<body>
    <!-- Sidebar -->
    <div class="sidebar">
        <div class="logo-container">
            <img src="imgs/Logo.png" alt="alt" />
        </div>

        <div class="wrap-order-button" style="display: flex; justify-content: center;">
            <div class="order-button">
                <a href="order" style="text-decoration: none;">Đặt hàng</a>
            </div>
        </div>
        <div class="wrap-nav">
            <div class="nav-item nav-product" hidden>
                <a href="product">
                    <i class="bi bi-cup-straw"></i>
                    Sản phẩm
                </a>
            </div>

            <div class="nav-item nav-order active">
                <a href="processing">
                    <i class="bi bi-cart"></i>
                    Đơn hàng
                </a>

            </div>

            <div class="nav-item nav-report" hidden>
                <a href="report">
                    <i class="bi bi-bar-chart"></i>
                    Báo cáo
                </a>
            </div>
            <div class="nav-item nav-account" hidden>
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
                <span class="fw-medium">Menu</span>
            </div>

            <div class="d-flex align-items-center">
                <div class="notification-icon">
                    <i class="bi bi-bell-fill small"></i>
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
                            <input id="input-search" type="text" value="" name="search"
                                class="form-control search-input" placeholder="Tìm kiếm">
                        </div>
                    </form>

                    <button class="btn btn-outline-secondary mb-2" hidden>
                        Xuất dữ liệu
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
                <table id="table-orders" class="warp-table">
                    <thead class="table-header">
                        <tr>
                            <th style="width:10%">ID</th>
                            <th style="width:30%">Tên món</th>
                            <th style="width:15%">Ngày giờ tạo</th>
                            <th style="width:15%">Người tạo</th>
                            <th style="width:15%">Giá</th>
                            <th style="width:15%; text-align: center; vertical-align: middle;">Trạng thái</th>
                        </tr>
                    </thead>
                    <tbody>
                        <tr>
                            <td>ID</td>
                            <td>Tên món</td>
                            <td>ngày giờ tạo</td>
                            <td>người tạo</td>
                            <td>Giá</td>
                            <td>Trạng thái</td>
                        </tr>
                    </tbody>
                </table>
            </div>
        </div>
    </div>


    <!--Modals delete-->
    <div class="modal fade" id="confirmationModal" tabindex="-1" aria-labelledby="confirmationModalLabel"
        aria-hidden="true">
        <div class="modal-dialog modal-dialog-centered modal-confirm">
            <div class="modal-content">
                <div class="modal-header" style="border: 0">
                    <h5 class="modal-title" id="confirmationModalLabel">Xóa món nước?</h5>
                    <button type="button" class="btn-close" data-bs-dismiss="modal" aria-label="Close"></button>
                </div>
                <div class="modal-body">
                    <p>Bạn có chắc chắn muốn xóa món <b id="ProductNameJquery"></b> không?</p>
                </div>
                <div class="modal-footer" style="border: 0">
                    <button type="button" class="btn btn-cancel me-2" data-bs-dismiss="modal">Hủy</button>
                    <button type="button" class="btn btn-confirm" style="background-color: #1F75FF; color: #fff;">Xác
                        nhận</button>
                </div>
            </div>
        </div>
    </div>


    <!--Modals detail-->
    <div class="modal fade right" id="slideModal" tabindex="-1" aria-hidden="true">
        <div class="modal-dialog">
            <div class="modal-content" style="height: 100%;">
                <div class="modal-header">
                    <div class="wrap-header-modal">
                        <div style="font-size: 18px; font-weight: 600;" class="detail-title">#01 - Cà phê sữa</div>
                        <!--<div style="font-size: 12px;background-color: #F2F4F7;width: 40px;text-align: center;border-radius: 10px;" class="detail-isAvailable">Còn</div>-->
                    </div>
                    <button type="button" class="btn-close" data-bs-dismiss="modal" aria-label="Đóng"></button>
                </div>

                <div class="modal-body">
                    <div class="row" style="padding: 15px 15px 0 15px">
                        <div class="col-md-6">
                            <div class="lable-detail">Danh muc</div>
                            <div class="content-modal-llh detail-categoryName">Cà phê</div>
                        </div>

                        <div class="col-md-6">
                            <div class="lable-detail">Giá gốc</div>
                            <div class="content-modal-llh detail-baseprice">10.000đ</div>
                        </div>

                        <div class="col-md-6">
                            <div class="lable-detail">Trạng thái</div>
                            <div class="content-modal-llh detail-available">Còn</div>
                        </div>

                        <div class="col-md-6">
                            <div class="lable-detail">Loại</div>
                            <div class="content-modal-llh detail-havetype">Lạnh</div>
                        </div>
                    </div>

                    <div class="row wrap-productsizes" style="padding: 15px 15px 0 15px">

                    </div>

                    <div class="row" style="padding: 15px">
                        <div class="col-md-12">
                            <input class="form-check-input" checked type="checkbox" name="directSale" id="buy"
                                value="isDirectSale" disabled>
                            <label class="form-check-label content-modal-llh" for="buy">Bán trực tiếp</label>
                        </div>
                    </div>
                </div>

                <div class="modal-footer">
                    <button class="action-button edit-btn" data-bs-toggle="modal" data-bs-target="#edit-modal"
                        data-id="1" style="width: 40px;height: 40px;border: 1px solid #EAECF0;border-radius: 50px;">
                        <i class="bi bi-pencil" style="color: black;"></i>
                    </button>
                    <button class="action-button delete-btn" data-bs-toggle="modal" data-bs-target="#confirmationModal"
                        data-id="1" style="width: 40px;height: 40px;border: 1px solid #EAECF0;border-radius: 50px;">
                        <i class="bi bi-trash"></i>
                    </button>
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
    <!--Modals delete-->
    <div class="modal fade" id="modal-cancel" tabindex="-1" aria-labelledby="confirmationModalLabel"
        aria-hidden="true">
        <div class="modal-dialog modal-dialog-centered modal-confirm">
            <div class="modal-content">
                <div class="modal-header">
                    <h5 class="modal-title" id="confirmationModalLabel">Xóa tài khoản</h5>
                    <button type="button" class="btn-close" data-bs-dismiss="modal" aria-label="Close"></button>
                </div>
                <div class="modal-body">
                    <p>Bạn có chắc chắn hủy đơn hàng này không? </p>
                </div>
                <div class="modal-footer" >
                    
                    <button id="btn-confirm-cancel" type="button" class="btn btn-confirm" style="background-color: #1F75FF; color: #fff;">Xác
                        nhận</button>
                    <button id="btn-hide-modal" type="button" class="btn btn-cancel me-2">Hủy</button>
                </div>
            </div>
        </div>
    </div>
    <!--Modals create-->
    <div class="modal fade right" id="create-modal" tabindex="-1" aria-hidden="true">
        <div class="modal-dialog">

            <div class="modal-content" style="height: 100%;">
                <form action="menu" method="post" enctype="multipart/form-data"
                    style="height:100%; display: flex; flex-direction: column;">
                    <div class="modal-header">
                        <div class="wrap-header-modal">
                            <div style="font-size: 20px; font-weight: 500">Thêm món</div>
                        </div>
                        <button type="button" class="btn-close" data-bs-dismiss="modal" aria-label="Đóng"></button>
                    </div>
                    <div class="modal-body">
                        <div class="mb-3">
                            <input type="text" placeholder="Tên" name="productName" class="form-control"
                                id="productName" value="">
                        </div>
                        <div class="mb-3">
                        </div>
                        <div class="mb-3">
                            <div class="input-group">
                                <input type="text" placeholder="Giá gốc" name="productPrice" class="form-control"
                                    id="price" value="" style="width: 100%">
                                <span class=""
                                    style="position: fixed; right: 7%; padding-top: 10px; z-index: 99;">đ</span>
                            </div>
                        </div>
                        <div class="mb-3">
                            <select class="form-select" id="haveType" name="haveType">
                                <option value="3" selected>Nóng và lạnh</option>
                                <option value="2">Lạnh</option>
                                <option value="1">Nóng</option>
                            </select>
                        </div>
                        <div class="mb-3">
                            <label for="size" class="form-label">Kích cỡ</label>
                            <div class="wrap-productsize">
                                <div class="row" style="padding: 0 15px; padding-bottom: 15px;">
                                    <input type="text" readonly name="productSizeS" class="form-control col-md-6"
                                        value="S" style="width: 48%; margin-right: 2%">
                                    <input type="text" name="productPriceOfSizeS" class="form-control col-md-6" value=""
                                        style="width: 48%; margin-left: 2%">
                                    <span style="position: fixed; right: -88%; padding-top: 10px;">đ</span>
                                </div>

                                <div class="row" style="padding: 0 15px; padding-bottom: 15px;">
                                    <input type="text" readonly name="productSizeM" class="form-control col-md-6"
                                        value="M" style="width: 48%; margin-right: 2%">
                                    <input type="text" name="productPriceOfSizeM" class="form-control col-md-6" value=""
                                        style="width: 48%; margin-left: 2%">
                                    <span style="position: fixed; right: -88%; padding-top: 10px;">đ</span>
                                </div>

                                <div class="row" style="padding: 0 15px;">
                                    <input type="text" readonly name="productSizeL" class="form-control col-md-6"
                                        value="L" style="width: 48%; margin-right: 2%">
                                    <input type="text" name="productPriceOfSizeL" class="form-control col-md-6" value=""
                                        style="width: 48%; margin-left: 2%">
                                    <span style="position: fixed; right: -88%; padding-top: 10px;">đ</span>
                                </div>
                            </div>
                        </div>
                        <div class="mb-3">
                            <label for="type" class="form-label">Trạng thái</label>
                            <div style="display: flex;">
                                <div class="form-check form-check-inline" style="width: 50%;">
                                    <input class="form-check-input" type="radio" name="availability" id="edit-available"
                                        value="true" checked>
                                    <label class="form-check-label" for="edit-available">Còn</label>
                                </div>
                                <div class="form-check form-check-inline" style="width: 50%;">
                                    <input class="form-check-input" type="radio" name="availability"
                                        id="edit-outOfStock" value="false">
                                    <label class="form-check-label" for="edit-outOfStock">Hết</label>
                                </div>
                            </div>
                        </div>
                        <div class="mb-3">
                            <label for="type" class="form-label">Mô tả hình ảnh</label>
                            <div class="image-upload-container row" style="padding-left: 10px;">
                                <input type="file" name="productImage" id="create-productImage" hidden />
                                <div class="col-md-2 update-load-imgs pick-image">
                                    <img src="imgs/Button.png" alt="alt" />
                                </div>

                                <div class="col-md-2 update-load-imgs wrap-upload">
                                    <div class="frame-pick-image">
                                        <img src="imgs/Button.png" alt="alt" class="preview-image" />
                                    </div>
                                    <div class="upload-preview">
                                        <i class="bi bi-x image-delete"
                                            style="background-color: #5e5e5e8a;border-radius: 50%;color: #fff;cursor: pointer;"></i>
                                    </div>
                                </div>
                            </div>
                        </div>
                        <div class="mb-3">
                            <input class="form-check-input" type="checkbox" name="directSale" id="create-buy"
                                value="isDirectSale">
                            <label class="form-check-label" for="create-buy">Bán trực tiếp</label>
                        </div>
                    </div>
                    <div class="modal-footer">
                        <button type="submit" class="btn btn-secondary" data-bs-dismiss="modal"
                            style="background-color: #1F75FF">Tạo</button>
                    </div>
                </form>
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
                <form action="menu" method="post" enctype="multipart/form-data"
                    style="height:100%; display: flex; flex-direction: column;">
                    <div class="modal-header">
                        <div class="wrap-header-modal">
                            <div style="font-size: 20px; font-weight: 500">Chỉnh sửa món</div>
                        </div>
                        <button type="button" class="btn-close" data-bs-dismiss="modal" aria-label="Đóng"></button>
                    </div>
                    <div class="modal-body">
                        <div class="mb-3">
                            <label for="size" class="form-label">Tên</label>
                            <input type="text" name="productName" class="form-control edit-productname" value="">
                        </div>
                        <div class="mb-3">
                            <label for="size" class="form-label">Danh mục</label>
                        </div>
                        <div class="mb-3">
                            <label for="size" class="form-label">Giá gốc</label>
                            <div class="input-group">
                                <input type="text" name="productPrice" class="form-control edit-baseprice" id="price"
                                    value="" style="width: 100%">
                                <span class=""
                                    style="position: fixed; right: 7%; padding-top: 10px; z-index: 99;">đ</span>
                            </div>
                        </div>
                        <div class="mb-3">
                            <label for="size" class="form-label">Loại</label>
                            <select class="form-select" id="edit-haveType" name="haveType">
                                <option value="3" selected>Nóng và lạnh</option>
                                <option value="2">Lạnh</option>
                                <option value="1">Nóng</option>
                            </select>
                        </div>
                        <div class="mb-3">
                            <label for="size" class="form-label">Kích cỡ</label>
                            <div class="wrap-productsize">
                                <div class="row" style="padding: 0 15px; padding-bottom: 15px;">
                                    <input type="text" readonly name="productSizeS" class="form-control col-md-6"
                                        value="S" style="width: 48%; margin-right: 2%">
                                    <input type="text" name="productPriceOfSizeS"
                                        class="form-control col-md-6 edit-productPriceOfSizeS" value=""
                                        style="width: 48%; margin-left: 2%">
                                    <span style="position: fixed; right: -88%; padding-top: 10px;">đ</span>
                                </div>

                                <div class="row" style="padding: 0 15px; padding-bottom: 15px;">
                                    <input type="text" readonly name="productSizeM" class="form-control col-md-6"
                                        value="M" style="width: 48%; margin-right: 2%">
                                    <input type="text" name="productPriceOfSizeM"
                                        class="form-control col-md-6  edit-productPriceOfSizeM" value=""
                                        style="width: 48%; margin-left: 2%">
                                    <span style="position: fixed; right: -88%; padding-top: 10px;">đ</span>
                                </div>

                                <div class="row" style="padding: 0 15px;">
                                    <input type="text" readonly name="productSizeL" class="form-control col-md-6"
                                        value="L" style="width: 48%; margin-right: 2%">
                                    <input type="text" name="productPriceOfSizeL"
                                        class="form-control col-md-6  edit-productPriceOfSizeL" value=""
                                        style="width: 48%; margin-left: 2%">
                                    <span style="position: fixed; right: -88%; padding-top: 10px;">đ</span>
                                </div>
                            </div>
                        </div>
                        <div class="mb-3">
                            <label for="type" class="form-label">Trạng thái</label>
                            <div style="display: flex;">
                                <div class="form-check form-check-inline" style="width: 50%;">
                                    <input class="form-check-input edit-radio-true" type="radio" name="availability"
                                        id="r-available" value="true">
                                    <label class="form-check-label" for="r-available">Còn</label>
                                </div>
                                <div class="form-check form-check-inline" style="width: 50%;">
                                    <input class="form-check-input edit-radio-false" type="radio" name="availability"
                                        id="r-outOfStock" value="false">
                                    <label class="form-check-label" for="r-outOfStock">Hết</label>
                                </div>
                            </div>
                        </div>
                        <div class="mb-3">
                            <label for="type" class="form-label">Mô tả hình ảnh</label>
                            <div class="image-upload-container row" style="padding-left: 10px;">
                                <input type="file" name="productImage" id="edit-productImage" hidden />
                                <div class="col-md-2 update-load-imgs edit-pick-image">
                                    <img src="imgs/Button.png" alt="alt" />
                                </div>

                                <div class="col-md-2 update-load-imgs edit-wrap-upload">
                                    <div class="frame-pick-image">
                                        <img src="imgs/Button.png" alt="alt" class="edit-preview-image" />
                                    </div>
                                    <div class="upload-preview">
                                        <i class="bi bi-x edit-image-delete"
                                            style="background-color: #5e5e5e8a;border-radius: 50%;color: #fff;cursor: pointer;"></i>
                                    </div>
                                </div>
                            </div>
                        </div>
                        <div class="mb-3">
                            <input class="form-check-input edit-checkbox" type="checkbox" name="directSale"
                                id="edit-buy" value="isDirectSale">
                            <label class="form-check-label" for="edit-buy">Bán trực tiếp</label>
                        </div>
                    </div>
                    <div class="modal-footer">
                        <input type="text" name="id" class="edit-productid" value="" hidden />
                        <button type="submit" id="edit-update" class="btn btn-secondary" data-bs-dismiss="modal"
                            style="background-color: #1F75FF">Cập nhật</button>
                    </div>
                </form>
            </div>
        </div>
    </div>
                            
    <%@ include file="toast.jsp" %>     
    <!-- Bootstrap 5 JS Bundle with Popper -->
    <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.2/dist/js/bootstrap.bundle.min.js"></script>
    <script src="https://code.jquery.com/jquery-3.6.0.min.js"></script>
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
        $(document).ready(function () {
            // VÙNG 1: VÙNG KHAI BÁO BIẾN TOÀN CỤC
            let gPage = 1;
            let gSize = 10;
            let debounceTimer;
            let gElementSelected = null;

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
                    callApiToLoadListOrders(vKeyword);
                }, 400); // chờ 400ms sau khi ngừng gõ
            });

            // Xử lý sự kiện sang trang tiếp theo
            $("#btn-next-page").on("click", function () {
                let vKeyword = ($("#input-search").val() || "").trim();
                gPage++;
                callApiToLoadListOrders(vKeyword);
            });

            // Xử lý sự kiện quay lại trang trước
            $("#btn-prev-page").on("click", function () {
                let vKeyword = ($("#input-search").val() || "").trim();

                gPage--;
                callApiToLoadListOrders(vKeyword);
            });

            // Xử lý sự kiện thay đổi status của đơn hàng
            $("#table-orders").on("change", ".status-select", function() {
                gElementSelected = this;
                onChangeOrderStatus(this); 
            });
            
            // Xử lý sự kiện nhấn nút xác nhận hủy đơn hàng
            $("#btn-confirm-cancel").on("click", function() {
               let vRow = $(gElementSelected).closest('tr');
               let orderCode = vRow.find('td:eq(0)').text();
               callApiToChangeOrderStatus(orderCode, "cancelled"); 
               $("#modal-cancel").modal("hide");
            });
            
            // Xử lý sự kiện nhấn nút xác nhận hủy đơn hàng
            $("#btn-hide-modal").on("click", function() {
                let vKeyword = ($("#input-search").val() || "").trim();
                callApiToLoadListOrders(vKeyword);
                $("#modal-cancel").modal("hide");
            });
            // VÙNG 3: VÙNG VIẾT CÁC HÀM XỬ LÝ SỰ KIỆN
            // Hàm xử lý sự kiện tải trang
            function onPageLoading() {
                navigateToCorrectPage();
                callApiToLoadListOrders("");
            }
            // VÙNG 4: VÙNG VIẾT CÁC HÀM DÙNG CHUNG

            // Hàm gọi API trả ra danh sách đơn hàng
            function callApiToLoadListOrders(keyword) {
                let vHeaders = {
                    Authorization: "Token " + getCookie("token")
                };
                $.ajax({
                    url: gBASE_URL + "/orders/?keyword=" + keyword + "&page=" + gPage + "&size=" + gSize,
                    method: "GET",
                    headers: vHeaders,
                    success: function (response) {
                        loadListOrdersToPage(response);
                    },
                    error: function (error) {
                        console.error("Error loading products:", error);
                        if (error.status === 403) {
                            deleteCookie("token");
                            window.location.href = "login";
                        }
                    }
                    
                });
            }

            // Hàm load dữ liệu order trả về vào page
            function loadListOrdersToPage(orderResponseData) {
                const $tbody = $('#table-orders tbody');
                $tbody.empty();
                if (!orderResponseData?.contents?.length) {
                    $tbody.empty().append('<tr><td colspan="5">Không tìm thấy đơn hàng</td></tr>');
                    displayPagination(orderResponseData);
                    return;
                }
                let vListOrder = orderResponseData.contents;
                $.each(vListOrder, function (item, order) {
                    let tenMonHtml = '<ul>';
                    $.each(order.orderProducts, function (index, mon) {
                        let vNameProduct = mon.productName;
                        if (Number(mon.percentIce) == -1) {
                            vNameProduct = vNameProduct + " nóng ";
                        }
                        vNameProduct = vNameProduct + "(" + mon.size;
                        if (Number(mon.percentSugar) > 0) {
                            vNameProduct = vNameProduct + ", " + mon.percentSugar + "% đường";
                        }

                        if (Number(mon.percentIce) > 0) {
                            vNameProduct = vNameProduct + ", " + mon.percentIce + "% đá";
                        }
                        vNameProduct += ")";


                        tenMonHtml += '<li>' + vNameProduct + '</li>';
                    });
                    tenMonHtml += '</ul>';
                    let formattedTotalPrice = Number(order.price).toLocaleString('vi-VN');
                    let vRow = `
                <tr>
                    <td>`+ order.orderCode + `</td>
                    <td>`+ tenMonHtml + `</td>
                    <td>`+ order.timeCreated + `</td>
                    <td>`+ order.createdBy + `</td>
                    <td>`+ formattedTotalPrice + `đ</td>
                    <td>`+ getHtmlForSelectStatus(order.status) + `</td>
                </tr>`;
                    $tbody.append(vRow);
                });

                displayPagination(orderResponseData);
            }

            function mapStatus(status) {
                switch (status) {
                    case 'pending':
                        return 'Đã tiếp nhận';
                    case 'processing':
                        return 'Đang xử lý';
                    case 'completed':
                        return 'Hoàn tất';
                    case 'cancelled':
                        return 'Đã hủy';
                    default:
                        return status;
                }
            }

            function resetPage() {
                gPage = 1;
                gSize = 10;
            }

            function displayPagination(responseOrderData) {
                let vPageDisplay = $("#page-display");
                let vStartNum = (responseOrderData.pageNumber - 1) * responseOrderData.pageSize + 1;
                let vEndNum = vStartNum + responseOrderData.numberOfElements - 1;
                vPageDisplay.html(vStartNum + " - " + vEndNum + " trong số " + responseOrderData.totalElements);
                $("#span-current-page").html(gPage);

                if (gPage <= 1) {
                    $("#btn-prev-page").prop("disabled", true);
                } else {
                    $("#btn-prev-page").prop("disabled", false);
                }

                if (gPage >= responseOrderData.totalPages) {
                    $("#btn-next-page").prop("disabled", true);
                } else {
                    $("#btn-next-page").prop("disabled", false);
                }
            }
            
            function navigateToCorrectPage() {
                const token = getCookie("token");
                if (token && isTokenValid(token)) {
                    const role = getUserRoleFromToken(token);
                    
                    switch (role) {
                        case "ADMIN":
                            $(".nav-account").attr("hidden", false);
                            $(".nav-product").attr("hidden", false);
                            $(".nav-report").attr("hidden", false);
                            break;
                        case "STAFF":
                            break;
                        case "MANAGER":
                            $(".nav-product").attr("hidden", false);
                            $(".nav-report").attr("hidden", false);
                            break;
                        default:
                            showToast("Không xác định được quyền người dùng!", "error");
                            window.location.href = "login";
                    }
                }
                else {
                    window.location.href = "login";
                }
            }
            
            function getHtmlForSelectStatus(status) {
            let vBeginTagSelect = `<div class="select-container">
          <select class="custom-select status-select">`;
            let vOptionTagSelect = "";
            switch (status) {
              case 'pending':
                vOptionTagSelect = `
                <option value="pending" data-color="#000000" selected>Đã tiếp nhận</option>
                <option value="processing" data-color="#0066FF">Đang xử lý</option>
                <option value="completed" data-color="#00A651">Hoàn tất</option>
                <option value="cancelled" data-color="#FF0000">Huỷ</option>`;
                break;
              case 'processing':
                vOptionTagSelect = `
                <option value="pending" data-color="#000000">Đã tiếp nhận</option>
                <option value="processing" data-color="#0066FF" selected>Đang xử lý</option>
                <option value="completed" data-color="#00A651">Hoàn tất</option>`;
                break;
              case 'completed':
                vOptionTagSelect = `<option value="completed" data-color="#00A651" selected>Hoàn tất</option>`;
                break;
              case 'cancelled':
                vOptionTagSelect = `
                <option value="cancelled" data-color="#FF0000" selected>Huỷ</option>`;
                break;
              default:
                break;
            }
            let vEndTagSelect = `
            </select>
            <div class="select-arrow">
            <svg width="12" height="6" viewBox="0 0 12 6" fill="none" xmlns="http://www.w3.org/2000/svg">
              <path id="arrow-path" class="arrow-path" d="M1 1L6 5L11 1" stroke="#000000" stroke-width="1.5"
              stroke-linecap="round" stroke-linejoin="round" />
            </svg>
            </div>
            </div>`;

            return vBeginTagSelect + vOptionTagSelect + vEndTagSelect;
          }


           function onChangeOrderStatus(element) {
               let vRow = $(element).closest('tr');
               let orderCode = vRow.find('td:eq(0)').text();
               let vNewStatus = $(element).val();
               if(vNewStatus == 'cancelled') {
                   $("#modal-cancel").modal("show");
                   return;
               }
               callApiToChangeOrderStatus(orderCode, vNewStatus);
           }
           
           
           async function callApiToChangeOrderStatus(orderCode, newStatus) {
               let vHeaders = {
                    Authorization: "Token " + getCookie("token")
                };
               await $.ajax({
                   url: gBASE_URL + "/orders/" + orderCode + "/?status=" + newStatus.toUpperCase(),
                   method: "PATCH",
                   headers: vHeaders,
                   success: function(response) {
                       showToast("Trạng thái đơn hàng đã được thay đổi!", "success");
             
                   },
                   error: function(xhr, status, error) {
                       showToast("Thay đổi trạng thái thất bại!", "error");
                   }
                   
               });
               let vKeyword = ($("#input-search").val() || "").trim();
                callApiToLoadListOrders(vKeyword);
           }
           
           
           function showToast(message, type) {
                // Lấy phần tử Toast và toast-content
                var toastEl = document.getElementById('myToast');
                var toastContent = toastEl.querySelector('#toast-content');
                var iconToast = toastEl.querySelector('.icon-toast i');
                var zoneIcon = toastEl.querySelector('.icon-toast');

                // Cập nhật nội dung thông báo
                if (toastContent) {
                    toastContent.textContent = message;
                }

                // Xóa các lớp màu và icon cũ
                zoneIcon.classList.remove('bg-success', 'bg-danger', 'bg-warning', 'bg-info');
                if (iconToast) {
                    iconToast.classList.remove('bi-check-lg', 'bi-exclamation-triangle', 'bi-info-circle');
                }

                // Cập nhật màu nền và icon dựa trên type
                if (type === "success") {
                    if (iconToast) {
                        iconToast.classList.add('bi-check-lg'); // Icon check cho success
                    }
                } else if (type === "error") {
                    zoneIcon.classList.add('bg-danger');
                    if (iconToast) {
                        iconToast.classList.add('bi-x-circle'); // Icon lỗi cho error
                    }
                } else if (type === "warning") {
                    zoneIcon.classList.add('bg-warning');
                    if (iconToast) {
                        iconToast.classList.add('bi-exclamation-triangle'); // Icon cảnh báo cho warning
                    }
                } else {
                    zoneIcon.classList.add('bg-info');
                    if (iconToast) {
                        iconToast.classList.add('bi-info-circle'); // Icon thông tin cho info
                    }
                }

                // Khởi tạo và hiển thị Toast
                var toast = new bootstrap.Toast(toastEl);
                toast.show();
            }
            
            function deleteCookie(name) {
                document.cookie = name + '=; Path=/; Expires=Thu, 01 Jan 1970 00:00:01 GMT;';
            }
        });
    </script>
</body>

</html>