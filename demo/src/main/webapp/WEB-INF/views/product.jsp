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
    <title>Quản lý sản phẩm</title>
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
        }

        .modal.right.show .modal-dialog {
            transform: translateX(0);
        }

        .frame-pick-image {
            border-radius: 12px;
            width: 64px;
            height: 64px;
            overflow: hidden;
            position: relative;
        }

        .preview-image,
        .edit-preview-image {
            position: absolute;
            top: 0;
            left: 0;
            width: 100%;
            height: 100%;
            object-fit: cover;
            object-position: center;
        }

        .wrap-upload,
        .edit-wrap-upload {
            position: fixed;
            display: none;
        }

        .upload-preview {
            position: absolute;
            top: -10px;
            right: 0;
        }

        #create-modal .form-control,
        #create-modal .form-select,
        #edit-modal .form-control,
        #edit-modal .form-select {
            height: 46px;
        }

        #edit-modal .form-label {
            margin-bottom: 0;
        }
    </style>
</head>

<body>
    <div class="sidebar">
        <div class="logo-container">
            <a href="product"><img src="imgs/Logo.png" alt="Logo" /></a>
        </div>
        <div class="wrap-order-button" style="display: flex; justify-content: center;">
            <div class="order-button">
                <a href="order" style="text-decoration: none;">Đặt hàng</a>
            </div>
        </div>
        <div class="wrap-nav">
            <div class="nav-item nav-product active">
                <a href="product"><i class="bi bi-cup-straw"></i> Sản phẩm</a>
            </div>
            <div class="nav-item nav-order">
                <a href="processing"><i class="bi bi-cart"></i> Đơn hàng</a>
            </div>
            <div class="nav-item nav-report">
                <a href="report"><i class="bi bi-bar-chart"></i> Báo cáo</a>
            </div>
            <div class="nav-item nav-account" hidden>
                <a href="account"><i class="bi bi-people"></i> Tài Khoản</a>
            </div>
        </div>
    </div>

    <!-- Main Content -->
    <div class="main-content">
        <!-- Top Header -->
        <div class="top-header">
            <div class="d-flex align-items-center">
                <button class="btn btn-sm d-none mobile-menu-toggle"><i class="bi bi-list"></i></button>
                <span class="fw-medium">Sản Phẩm</span>
            </div>
            <div class="d-flex align-items-center">
                <div class="notification-icon"><i class="bi bi-bell small"></i></div>
                <div class="user-avatar"><img src="imgs/Avatar.png" alt="User" class="w-100 h-100"></div>
            </div>
        </div>

        <!-- Content Area -->
        <div class="content-area" style="background-color: #fff">
            <div class="d-flex justify-content-between mb-4 flex-wrap" style="margin-bottom: 0 !important;">
                <div class="mb-2">
                    <h1 class="h4" style="font-weight: 600">Danh sách</h1>
                </div>
                <div class="d-flex gap-2 flex-wrap">
                    <div class="search-container mb-2">
                        <i class="bi bi-search"></i>
                        <input id="input-search" type="text" name="search" class="form-control search-input" placeholder="Tìm kiếm">
                    </div>
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
                    <div class="page-info"></div>
                    <div class="d-flex gap-2 align-items-center">
                        <button id="btn-prev-page" class="btn btn-sm btn-light page-previous"><i class="bi bi-chevron-left"></i></button>
                        <button id="btn-next-page" class="btn btn-sm btn-light page-next"><i class="bi bi-chevron-right"></i></button>
                    </div>
                </div>
            </div>

            <!-- Table -->
            <div class="table-responsive">
                <table class="warp-table">
                    <thead class="table-header">
                        <tr>
                            <th style="width:5%">ID</th>
                            <th style="width:7%">Hình ảnh</th>
                            <th style="width:28%">Tên</th>
                            <th style="width:19%">Danh mục</th>
                            <th style="width:7%">Kích cỡ</th>
                            <th style="width:17%">Giá</th>
                            <th style="width:10%">Trạng thái</th>
                            <th style="width:7%">Thao tác</th>
                        </tr>
                    </thead>
                    <tbody id="load-product"></tbody>
                </table>
            </div>
        </div>
    </div>

    <!-- Delete Modal -->
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
                    <button type="button" class="btn btn-confirm" style="background-color: #1F75FF; color: #fff;">Xác
                        nhận</button>
                    <button type="button" class="btn btn-cancel me-2" data-bs-dismiss="modal">Hủy</button>
                   
                </div>
            </div>
        </div>
    </div>

    <!-- Detail Modal -->
    <div class="modal fade right" id="slideModal" tabindex="-1" aria-hidden="true">
        <div class="modal-dialog">
            <div class="modal-content" style="height: 100%;">
                <div class="modal-header">
                    <div class="wrap-header-modal">
                        <div style="font-size: 18px; font-weight: 600;" class="detail-title"></div>
                    </div>
                    <button type="button" class="btn-close" data-bs-dismiss="modal" aria-label="Đóng"></button>
                </div>
                <div class="modal-body">
                    <div class="row" style="padding: 15px 15px 0 15px">
                        <div class="col-md-6">
                            <div class="lable-detail">Danh mục</div>
                            <div class="content-modal-llh detail-categoryName"></div>
                        </div>
                        <div class="col-md-6">
                            <div class="lable-detail">Giá gốc</div>
                            <div class="content-modal-llh detail-baseprice"></div>
                        </div>
                        <div class="col-md-6">
                            <div class="lable-detail">Trạng thái</div>
                            <div class="content-modal-llh detail-available"></div>
                        </div>
                        <div class="col-md-6">
                            <div class="lable-detail">Loại</div>
                            <div class="content-modal-llh detail-havetype"></div>
                        </div>
                    </div>
                    <div class="row wrap-productsizes" style="padding: 15px 15px 0 15px"></div>
                    <div class="row" style="padding: 15px">
                        <div class="col-md-12">
                            <input class="form-check-input" type="checkbox" name="directSale" id="buy"
                                value="isDirectSale" disabled>
                            <label class="form-check-label content-modal-llh" for="buy">Bán trực tiếp</label>
                        </div>
                    </div>
                </div>
            </div>
        </div>
    </div>

    <!-- Create Modal -->
    <div class="modal fade right" id="create-modal" tabindex="-1" aria-hidden="true">
        <div class="modal-dialog">
            <div class="modal-content" style="height: 100%;">
                <form id="create-form" enctype="multipart/form-data"
                    style="height:100%; display: flex; flex-direction: column;">
                    <div class="modal-header">
                        <div class="wrap-header-modal">
                            <div style="font-size: 20px; font-weight: 500">Thêm món</div>
                        </div>
                        <button id="btn-close-modal-create" type="button" class="btn-close" data-bs-dismiss="modal" aria-label="Đóng"></button>
                    </div>
                    <div class="modal-body">
                        <div class="mb-3">
                            <input type="text" placeholder="Tên" name="productName" class="form-control"
                                id="productName" autocomplete="off">
                        </div>
                        <div class="mb-3">
                            <select class="form-select" id="category" name="category">
                                <option value="-1" selected>Danh mục</option>
                            </select>
                        </div>
                        <div class="mb-3">
                            <div class="input-group">
                                <input type="text" placeholder="Giá gốc" name="productPrice" class="form-control"
                                    id="price" autocomplete="off">
                                <span style="position: fixed; right: 7%; padding-top: 10px; z-index: 99;">đ</span>
                            </div>
                        </div>
                        <div class="mb-3">
                            <select class="form-select" id="haveType" name="haveType">
                                <option value="3" selected>Nóng và lạnh</option>
                                <option value="2">Lạnh</option>
                                <option value="1">Nóng</option>
                            </select>
                        </div>
                        <div class="">
                            <label for="size" class="form-label">Kích cỡ</label>
                            <div id="wrap-productsize-create" class="wrap-productsize">
                                
                                <div class="row" style="padding: 0 15px; padding-bottom: 15px;">
                                    <input type="text"  name="size-create" class="form-control col-md-6"
                                        value="" style="width: 48%; margin-right: 2%">
                                    <input type="text" name="productPriceOfSizeM" class="form-control col-md-6"
                                        style="width: 48%; margin-left: 2%">
                                    <span style="position: fixed; right: -88%; padding-top: 10px;">đ</span>
                                </div>
                            </div>
                        </div>
                        <a id="add-size-create" href="" style="text-decoration: none;">Thêm size</a>
                        <div class="mb-3">
                            <label for="type" class="form-label">Trạng thái</label>
                            <div style="display: flex;">
                                <div class="form-check form-check-inline" style="width: 50%;">
                                    <input class="form-check-input" type="radio" name="availability"
                                        id="create-available" value="true" checked>
                                    <label class="form-check-label" for="create-available">Còn</label>
                                </div>
                                <div class="form-check form-check-inline" style="width: 50%;">
                                    <input class="form-check-input" type="radio" name="availability"
                                        id="create-outOfStock" value="false">
                                    <label class="form-check-label" for="create-outOfStock">Hết</label>
                                </div>
                            </div>
                        </div>
                        <div class="mb-3">
                            <label for="type" class="form-label">Mô tả hình ảnh</label>
                            <div class="image-upload-container row" style="padding-left: 10px;">
                                <input type="file" name="productImage" accept="image/*" id="create-productImage"
                                    hidden />
                                <div class="col-md-2 update-load-imgs pick-image">
                                    <img src="imgs/Button.png" alt="Upload" />
                                </div>
                                <div class="col-md-2 update-load-imgs wrap-upload">
                                    <div class="frame-pick-image">
                                        <img src="imgs/Button.png" alt="Preview" class="preview-image" />
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
                    <div class="modal-footer" style="justify-content: center;">
                        <button type="submit" class="btn btn-secondary"
                            style="background-color: #1F75FF;width: 200px;">Tạo</button>
                    </div>
                </form>
            </div>
        </div>
    </div>

    <!-- Edit Modal -->
    <div class="modal fade right" id="edit-modal" tabindex="-1" aria-hidden="true">
        <div class="modal-dialog">
            <div class="modal-content" style="height: 100%;">
                <form id="edit-form" enctype="multipart/form-data"
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
                            <input type="text" name="productName" class="form-control edit-productname">
                        </div>
                        <div class="mb-3">
                            <label for="size" class="form-label">Danh mục</label>
                            <select class="form-select" id="edit-category" name="category"></select>
                        </div>
                        <div class="mb-3">
                            <label for="size" class="form-label">Giá gốc</label>
                            <div class="input-group">
                                <input type="number" name="productPrice" class="form-control edit-baseprice">
                                <span style="position: fixed; right: 7%; padding-top: 10px; z-index: 99;">đ</span>
                            </div>
                        </div>
                        <div class="mb-3">
                            <label for="size" class="form-label">Loại</label>
                            <select class="form-select" id="edit-haveType" name="haveType">
                                <option value="3">Nóng và lạnh</option>
                                <option value="2">Lạnh</option>
                                <option value="1">Nóng</option>
                            </select>
                        </div>
                        <div class="mb-3">
                            <label for="size" class="form-label">Kích cỡ</label>
                            <div id="wrap-productsize-edit" class="wrap-productsize">
                                <div class="row" style="padding: 0 15px; padding-bottom: 15px;">
                                    <input type="text" readonly name="productSizeS" class="form-control col-md-6"
                                        value="S" style="width: 48%; margin-right: 2%">
                                    <input type="number" name="productPriceOfSizeS"
                                        class="form-control col-md-6 edit-productPriceOfSizeS"
                                        style="width: 48%; margin-left: 2%">
                                    <span style="position: fixed; right: -88%; padding-top: 10px;">đ</span>
                                </div>
                                <div class="row" style="padding: 0 15px; padding-bottom: 15px;">
                                    <input type="text" readonly name="productSizeM" class="form-control col-md-6"
                                        value="M" style="width: 48%; margin-right: 2%">
                                    <input type="number" name="productPriceOfSizeM"
                                        class="form-control col-md-6 edit-productPriceOfSizeM"
                                        style="width: 48%; margin-left: 2%">
                                    <span style="position: fixed; right: -88%; padding-top: 10px;">đ</span>
                                </div>
                                <div class="row" style="padding: 0 15px;">
                                    <input type="text" readonly name="productSizeL" class="form-control col-md-6"
                                        value="L" style="width: 48%; margin-right: 2%">
                                    <input type="number" name="productPriceOfSizeL"
                                        class="form-control col-md-6 edit-productPriceOfSizeL"
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
                                <input type="file" name="productImage" accept="image/*" id="edit-productImage" hidden />
                                <div class="col-md-2 update-load-imgs edit-pick-image">
                                    <img src="imgs/Button.png" alt="Upload" />
                                </div>
                                <div class="col-md-2 update-load-imgs edit-wrap-upload">
                                    <div class="frame-pick-image">
                                        <img src="imgs/Button.png" alt="Preview" class="edit-preview-image" />
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
                    <div class="modal-footer" style="justify-content: center;">
                        <input type="hidden" name="id" class="edit-productid">
                        <button type="submit" class="btn btn-secondary"
                            style="background-color: #1F75FF; width: 200px;">Cập nhật</button>
                    </div>
                </form>
            </div>
        </div>
    </div>

    <%@ include file="toast.jsp" %>

        <!-- Scripts -->
        <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.2/dist/js/bootstrap.bundle.min.js"></script>
        <script src="https://code.jquery.com/jquery-3.7.1.min.js"
            integrity="sha256-/JqT3SQfawRcv/BIHPThkBvs0OEvtFFmqPF/lYI/Cxo=" crossorigin="anonymous"></script>
        <script src="js/action.js"></script>
        <script>
            $(document).ready(function () {
                // VÙNG 1: VÙNG KHAI BÁO BIẾN TOÀN CỤC
                const gBASE_URL = "http://localhost:8080";
                let gPage = 1;
                let gSize = 10;
                let gCurrentDeleteId = null;
                let gDebounceTimer;
                let gNumberSizeOfProduct = null;
                let gProductSelected = null;
                let gNumberSize = 1;

                // VÙNG 2: VÙNG GÁN VÀ THỰC THI SỰ KIỆN CHO CÁC ELEMENT
                onPageLoading();

                // Search input
                $("#input-search").on("click", function () {
                    $(this).val("");
                    clearTimeout(gDebounceTimer);
                    gDebounceTimer = setTimeout(function () {
                        resetPage();
                        callApiToLoadProducts("");
                    }, 150); 
                });

                $("#input-search").on("keyup", function () {
                    let vKeyword = ($(this).val() || "").trim();
                    clearTimeout(gDebounceTimer);
                    gDebounceTimer = setTimeout(function () {
                        resetPage();
                        callApiToLoadProducts(vKeyword);
                    }, 400); // Wait 400ms after typing stops
                });

                // Pagination buttons
                $("#btn-prev-page").on("click", function () {
                    let vKeyword = ($("#input-search").val() || "").trim();
                    gPage--;
                    callApiToLoadProducts(vKeyword);
                });

                $("#btn-next-page").on("click", function () {
                    let vKeyword = ($("#input-search").val() || "").trim();
                    gPage++;
                    callApiToLoadProducts(vKeyword);
                });

                // Delete button in table
                $(document).on("click", ".delete-btn", function (e) {
                    e.preventDefault();
                    gCurrentDeleteId = $(this).data("id");
                    let vProductName = $(this).closest("tr").find(".name-product").text();
                    $("#ProductNameJquery").text(vProductName);
                });

                // Confirm delete
                $(".btn-confirm").on("click", onConfirmDeleteClick);

                // Product row click for details
                $(document).on("click", ".product-row", onProductRowClick);

                // Edit button
                $(document).on("click", ".edit-btn", onEditButtonClick);

                // Create form submission
                $("#create-form").on("submit", onCreateFormSubmit);

                // Edit form submission
                $("#edit-form").on("submit", onEditFormSubmit);

                // Image upload for create
                $(".pick-image").on("click", function () {
                    $("#create-productImage").click();
                });

                $("#create-productImage").on("change", onCreateImageChange);

                $(".image-delete").on("click", onCreateImageDelete);

                // Image upload for edit
                $(".edit-pick-image").on("click", function () {
                    $("#edit-productImage").click();
                });

                $("#edit-productImage").on("change", onEditImageChange);

                $(".edit-image-delete").on("click", onEditImageDelete);

                // Mobile menu toggle
                $(".mobile-menu-toggle").on("click", function () {
                    let $sidebar = $(".sidebar");
                    $sidebar.css("width", $sidebar.css("width") === "200px" ? "0" : "200px");
                });

                $("#add-size-create").on("click", function(e) {
                    e.preventDefault();
                    onBtnAddSizeCreateClick();
                });

                $("#btn-close-modal-create").on("click", resetFormCreate);

                // VÙNG 3: VÙNG VIẾT CÁC HÀM XỬ LÝ SỰ KIỆN
                // Page load
                function onPageLoading() {
                    callApiToLoadProducts("");
                    callApiToLoadCategories();
                    navigateToCorrectPage();
                }

                // Confirm delete
                function onConfirmDeleteClick() {
                    let vHeaders = {
                        Authorization: "Token " + getCookie("token")
                    };

                    if (gCurrentDeleteId) {
                        $.ajax({
                            url: gBASE_URL + `/products/` + gCurrentDeleteId,
                            type: "DELETE",
                            success: function (response) {
                                    $("#confirmationModal").modal("hide");
                                    callApiToLoadProducts(($("#input-search").val() || "").trim());
                                    showToast("Xóa sản phẩm thành công!", "success");
                            },
                            error: function (error) {
                                showToast("Xóa sản phẩm thất bại, vui lòng thử lại!", "error");
                                console.error("Error deleting product:", error);
                            }
                        });
                        gCurrentDeleteId = null;
                    }
                }

                // Product row click for details
                function onProductRowClick(e) {
                    e.preventDefault();
                    let vItemId = $(this).data("id");
                    callApiToLoadProductDetails(vItemId);
                }

                // Edit button click
                function onEditButtonClick(e) {
                    e.preventDefault();
                    let vItemId = $(this).data("id");
                    gProductSelected = vItemId;
                    callApiToLoadProductForEdit(vItemId);
                }

                // Create form submission
                function onCreateFormSubmit(e) {
                    e.preventDefault();
                    let vFormData = getDataProductToCreate(this);
                    if(!vFormData) return;

                    let vHeaders = {
                        Authorization: "Token " + getCookie("token")
                    };

                    $.ajax({
                        url: gBASE_URL + "/products/",
                        type: "POST",
                        data: vFormData,
                        processData: false,
                        contentType: false,
                        dataType: "json",
                        headers: vHeaders,
                        success: function (response) {
                            $("#create-modal").modal("hide");
                            callApiToLoadProducts(($("#input-search").val() || "").trim());
                            resetFormCreate();
                            showToast("Tạo sản phẩm thành công!", "success");
                            $("#create-form")[0].reset();
                            $(".wrap-upload").css("display", "none");
                            $(".pick-image").css("z-index", "1");
                            
                        },
                        error: function (error) {
                            showToast("Tạo sản phẩm thất bại, vui lòng thử lại!", "error");
                            console.error("Error creating product:", error);
                        }
                    });
                }

                // Edit form submission
                function onEditFormSubmit(e) {
                    e.preventDefault();
                    const formData = getDataProductToEdit(this);
                    if(!formData) return;

                    let vHeaders = {
                        Authorization: "Token " + getCookie("token")
                    };
                    $.ajax({
                        url: gBASE_URL + `/products/` + gProductSelected + `/update`,
                        type: "PUT",
                        data: formData,
                        processData: false,
                        contentType: false,
                        dataType: "json",
                        headers: vHeaders,
                        success: function (response) {
                            $("#edit-modal").modal("hide");
                            callApiToLoadProducts(($("#input-search").val() || "").trim());
                            showToast("Cập nhật sản phẩm thành công!", "success");
                        },
                        error: function (error) {
                            showToast("Cập nhật sản phẩm thất bại, vui lòng thử lại!", "error");
                            console.error("Error updating product:", error);
                        }
                    });
                }

                // Create image change
                function onCreateImageChange() {
                    if (this.files && this.files[0]) {
                        let vReader = new FileReader();
                        vReader.onload = function (e) {
                            $(".preview-image").attr("src", e.target.result).show();
                            $(".wrap-upload").css("display", "block");
                            $(".pick-image").css("z-index", "-1");
                        };
                        vReader.readAsDataURL(this.files[0]);
                    }
                }

                // Create image delete
                function onCreateImageDelete() {
                    $("#create-productImage").val("");
                    $(".preview-image").attr("src", "").hide();
                    $(".wrap-upload").css("display", "none");
                    $(".pick-image").css("z-index", "1");
                }

                // Edit image change
                function onEditImageChange() {
                    if (this.files && this.files[0]) {
                        let vReader = new FileReader();
                        vReader.onload = function (e) {
                            $(".edit-preview-image").attr("src", e.target.result).show();
                            $(".edit-wrap-upload").css("display", "block");
                            $(".edit-pick-image").css("z-index", "-1");
                        };
                        vReader.readAsDataURL(this.files[0]);
                    }
                }

                // Edit image delete
                function onEditImageDelete() {
                    $("#edit-productImage").val("");
                    $(".edit-preview-image").attr("src", "").hide();
                    $(".edit-wrap-upload").css("display", "none");
                    $(".edit-pick-image").css("z-index", "1");
                }

                // VÙNG 4: VÙNG VIẾT CÁC HÀM DÙNG CHUNG
                // Load products
                function callApiToLoadProducts(keyword) {
                    let vHeaders = {
                        Authorization: "Token " + getCookie("token")
                    };

                    $.ajax({
                        url: gBASE_URL + `/products/?keyword=`+ keyword +`&page=`+ gPage + `&size=` + gSize,
                        method: "GET",
                        dataType: "json",
                        headers: vHeaders,
                        success: function (response) {
                            loadProductsToPage(response);
                        },
                        error: function (error) {
                            if (error.status === 403) {
                                deleteCookie("token");
                                window.location.href = "login";
                            }
                            console.error("Error loading products:", error);
                        }
                    });
                }

                // Load products to table
                function loadProductsToPage(productResponseData) {
                    let $tbody = $("#load-product");
                    $tbody.empty();
                    if (!productResponseData?.contents?.length) {
                        $tbody.append('<tr><td colspan="8">Không tìm thấy sản phẩm</td></tr>');
                        displayPagination(productResponseData);
                        return;
                    }

                    let vListProducts = productResponseData.contents;
                    $.each(vListProducts, function (index, product) {
                        let vListPrice = product.listPrice.split(",").map(price => formatMoney(price)).join(", ");
                        let vStatus = product.isAvailable
                            ? '<span class="status-badge status-in">Còn</span>'
                            : '<span class="status-badge status-out">Hết</span>';
                        let vRow = `
                        <tr class="product-row" data-id="`+ product.productId + `" data-bs-toggle="modal" data-bs-target="#slideModal">
                            <td class="id-product">`+ product.productId + `</td>
                            <td><img src="` + gBASE_URL + product.urlImage +`" alt="`+ product.productName + `" class="product-image"></td>
                            <td class="name-product">`+ product.productName +`</td>
                            <td>`+ product.categoryName +`</td>
                            <td>` + product.sizes + `</td>
                            <td>` + vListPrice + `</td>
                            <td>` + vStatus +`</td>
                            <td>
                                <button class="action-button edit-btn" data-bs-toggle="modal" data-bs-target="#edit-modal" data-id="`+ product.productId + `">
                                    <i class="bi bi-pencil" style="color: black;"></i>
                                </button>
                                <button class="action-button delete-btn" data-bs-toggle="modal" data-bs-target="#confirmationModal" data-id="` + product.productId + `">
                                    <i class="bi bi-trash"></i>
                                </button>
                            </td>
                        </tr>`;
                        $tbody.append(vRow);
                    });

                    displayPagination(productResponseData);
                }

                // Load categories
                function callApiToLoadCategories() {
                    let vHeaders = {
                        Authorization: "Token " + getCookie("token")
                    };

                    $.ajax({
                        url: gBASE_URL + "/categories/",
                        method: "GET",
                        dataType: "json",
                        headers: vHeaders,
                        success: function (categories) {
                            let $categorySelects = $("#category, #edit-category");
                            $.each(categories.data, function (index, category) {
                                let vOption = `<option value="` + category.id + `">` + category.categoryName + `</option>`;
                                $categorySelects.append(vOption);
                            })
                        },
                        error: function (error) {
                            console.error("Error loading categories:", error);
                        }
                    });
                }

                // Load product details
                function callApiToLoadProductDetails(itemId) {
                    let vHeaders = {
                        Authorization: "Token " + getCookie("token")
                    };

                    $.ajax({
                        url: gBASE_URL + `/products/` + itemId + `/details`,
                        type: "GET",
                        data: { detailID: itemId },
                        headers: vHeaders,
                        success: function (response) {
                            $(".detail-title").text("#" + response.productId + " - " + response.productName);
                            $(".detail-categoryName").text(response.categoryName);
                            $(".detail-baseprice").text(formatMoney(response.basePrice) + `đ`);
                            $(".detail-available").text(response.isAvailable ? "Còn" : "Hết");
                            $(".detail-havetype").text(
                                response.haveType === 1 ? "Nóng" : response.haveType === 2 ? "Lạnh" : "Nóng và lạnh"
                            );
                            $("#buy").prop("checked", response.isDirectSale);

                            $(".wrap-productsizes").empty();
                            $.each(response.variants, function (index, variant) {
                                let vVariantHtml = `
                                <div class="col-md-6">
                                    <div class="lable-detail">Kích cỡ</div>
                                    <div class="content-modal-llh">`+ variant.sizeName + `</div>
                                </div>
                                <div class="col-md-6">
                                    <div class="lable-detail">Giá</div>
                                    <div class="content-modal-llh">` + formatMoney(variant.price) + ` đ</div>
                                </div>`;
                                $(".wrap-productsizes").append(vVariantHtml);
                            });
                        },
                        error: function (error) {
                            console.error("Error fetching product details:", error);
                        }
                    });
                }

                // Load product for edit
                function callApiToLoadProductForEdit(itemId) {
                    let vHeaders = {
                        Authorization: "Token " + getCookie("token")
                    };

                    $.ajax({
                        url: gBASE_URL + `/products/` + itemId + `/details`,
                        type: "GET",
                        headers: vHeaders,
                        success: function (response) {
                            $(".edit-productid").val(response.productId);
                            $(".edit-productname").val(response.productName);
                            $(".edit-baseprice").val(response.basePrice);
                            $("#edit-category").val(response.categoryId);
                            $("#edit-haveType").val(response.haveType);
                            $(".edit-radio-true").prop("checked", response.isAvailable);
                            $(".edit-radio-false").prop("checked", !response.isAvailable);
                            $(".edit-checkbox").prop("checked", response.isDirectSale);
                            $(".edit-preview-image").attr("src", gBASE_URL + response.urlImage).show();
                            $(".edit-wrap-upload").css("display", response.urlImage ? "block" : "none");
                            $(".edit-pick-image").css("z-index", response.urlImage ? "-1" : "1");

                            let vWrapProductSize = $("#wrap-productsize-edit");
                            vWrapProductSize.empty();
                            $.each(response.variants, function (index, variant) {
                                console.log(response.variants);
                                let vSizeHtml = `<div class="row" style="padding: 0 15px; padding-bottom: 15px;">
                                    <input type="text" name="size" class="form-control col-md-6" value="`+ variant.sizeName + `" style="width: 48%; margin-right: 2%">
                                    <input type="text" name="price" value="`+ variant.price + `"class="form-control col-md-6" style="width: 48%; margin-left: 2%">
                                    <span style="position: fixed; right: -88%; padding-top: 10px;">đ</span>
                                </div>`
                                vWrapProductSize.append(vSizeHtml);
                            });
                        },
                        error: function (error) {
                            console.error("Error fetching product for edit:", error);
                        }
                    });
                }

                // Format money
                function formatMoney(number) {
                    return Number(number).toLocaleString("vi-VN");
                }

                // Reset pagination
                function resetPage() {
                    gPage = 1;
                    gSize = 10;
                }

                // Display pagination
                function displayPagination(responseData) {
                    let $pageDisplay = $(".page-info");
                    let vStartNum = (responseData.pageNumber - 1) * responseData.pageSize + 1;
                    let vEndNum = vStartNum + responseData.numberOfElements - 1;
                    $pageDisplay.html(vStartNum + ` - ` + vEndNum + ` trong số ` + responseData.totalElements);

                    $("#btn-prev-page").prop("disabled", gPage <= 1);
                    $("#btn-next-page").prop("disabled", gPage >= responseData.totalPages);
                }

                // Navigate based on role
                function navigateToCorrectPage() {
                    let vToken = getCookie("token");
                    if (vToken && isTokenValid(vToken)) {
                        let vRole = getUserRoleFromToken(vToken);
                        switch (vRole) {
                            case "ADMIN":
                                $(".nav-account").attr("hidden", false);
                                break;
                            case "STAFF":
                                window.location.href = "order";
                                break;
                            case "MANAGER":
                                break;
                            default:
                                showToast("Không xác định được quyền người dùng!", "error");
                                window.location.href = "login";
                        }
                    } else {
                        window.location.href = "login";
                    }
                }

                // Function get data edit
                function getDataProductToEdit(element) {
                    // Tạo FormData
                    const formData = new FormData(element);

                    // Xử lý imageInput mà không dừng nếu không tìm thấy
                    const imageInput = $('#edit-productImage');
                    const imageFile = imageInput.length > 0 ? imageInput[0].files[0] : "";
                    if (imageFile) {
                        formData.append("image", imageFile);
                    }

                    const productData = {
                        productName: $(".edit-productname").val().trim(),
                        categoryId: $("#edit-category").val(),
                        basePrice: parseFloat($(".edit-baseprice").val()) || 0,
                        haveType: $("#edit-haveType").val(),
                        productVariants: [],
                        isAvailable: $("#r-available").is(':checked'),
                        isDirectSale: $('#edit-buy').is(':checked')
                    };

                    // Validate product data
                    const pass = validateProductData(productData);
                    if (!pass) {
                        return null;
                    }

                    // Collect and validate variants
                    let hasError = false;
                    $('#wrap-productsize-edit .row').each(function () {
                        
                        const size = $(this).find('input[name="size"]').val().trim();
                        
                        const price = parseFloat($(this).find('input:not([name="size"])').val()) || 0;
                        const variantpass = validateVariantData({ size, price }, productData.basePrice);
                        if (!variantpass) {
                            hasError = true;
                            return false;
                        }
                        productData.productVariants.push({ size, price });
                    });
                    // If there was an error in variants, return null
                    if (hasError) {
                        return null;
                    }

                    formData.append("data", JSON.stringify(productData));
                    return formData;
                }

                // Function get data create
                function getDataProductToCreate(element) {
                    // Tạo FormData
                    const formData = new FormData(element);

                    // Xử lý imageInput mà không dừng nếu không tìm thấy
                    const imageInput = $('#create-productImage');
                    const imageFile = imageInput.length > 0 ? imageInput[0].files[0] : null;
                    if (imageFile) {
                        formData.append("image", imageFile);
                    }

                    const productData = {
                        productName: $("#productName").val().trim(),
                        categoryId: $("#category").val(),
                        basePrice: parseFloat($("#price").val()) || 0,
                        haveType: $("#haveType").val(),
                        productVariants: [],
                        isAvailable: $("#create-available").is(':checked'),
                        isDirectSale: $("#create-buy").is(':checked')
                    };

                    

                    if(productData.categoryId == -1) {
                        showToast("Vui lòng chọn danh mục cho sản phẩm!", "warning");
                        return null;
                    }
                    // Validate product data
                    const pass = validateProductData(productData);
                    if (!pass) {
                        return null;
                    }


                    // Collect and validate variants
                    let hasError = false;
                    $('#wrap-productsize-create .row').each(function () {
                        const size = $(this).find('input[name="size-create"]').val().trim();
                        const price = parseFloat($(this).find('input:not([name="size-create"])').val()) || 0;
                        const variantpass = validateVariantData({ size, price }, productData.basePrice);
                        if (!variantpass) {
                            hasError = true
                            return false;
                        }
                        productData.productVariants.push({ size, price });
                    });

                    // If there was an error in variants, return null
                    if (hasError) {
                        return null;
                    }

                    formData.append("data", JSON.stringify(productData));
                    return formData;
                }


                function validateProductData(product) {
                    if (!product.productName) {
                        showToast("Tên sản phẩm không được để trống!", "warning");
                        return false;
                    }
                    if (!product.basePrice) {
                        showToast("Giá gốc không được để trống!", "warning");
                        return false;
                    }
                    if (product.basePrice <= 0) {
                        showToast("Giá gốc phải lớn hơn 0!", "warning");
                        return false;
                    }
                    return true;
                }

                function validateVariantData(variant, basePrice) {
                    if (!variant.size) {
                        showToast("Kích thước không được để trống!", "warning");
                        return false;
                    }
                    if (!variant.price) {
                        showToast("Giá bán không được để trống!", "warning");
                        return false;
                    }
                    if (variant.price <= 0) {
                        showToast("Giá bán phải lớn hơn 0!", "warning");
                        return false;
                    }
                    if (variant.price <= basePrice) {
                        showToast("Giá bán phải lớn hơn giá gốc!", "warning");
                        return false;
                    }
                    return true;
                }

                function onBtnAddSizeCreateClick() {
                    let vWrapProductSize = $("#wrap-productsize-create");
                    let vSize = `<div class="row" style="padding: 0 15px; padding-bottom: 15px;">
                                    <input type="text"  name="size-create" class="form-control col-md-6"
                                        value="" style="width: 48%; margin-right: 2%">
                                    <input type="text" name="productPriceOfSizeM" class="form-control col-md-6"
                                        style="width: 48%; margin-left: 2%">
                                    <span style="position: fixed; right: -88%; padding-top: 10px;">đ</span>
                                </div>`
                    vWrapProductSize.append(vSize);
                    gNumberSize ++;
                    if(gNumberSize == 3 ) {
                        $("#add-size-create").hide();
                    }
                }

                function resetFormCreate() {
                    $("#wrap-productsize-create").empty();
                    gNumberSize = 0;
                    onBtnAddSizeCreateClick();     
                    $('#create-productImage').val('');
                    $(".preview-image").attr("src", "").hide();
                    $(".wrap-upload").css("display", "none");
                    $(".pick-image").css("z-index", "1");
                    
                    $("#productName").val(''),
                    $("#category").val('-1'),
                    $("#price").val(),
                    $("#haveType").val("3"),
                    $("#create-available").prop('checked', false);
                    $("#create-outOfStock").prop('checked', false);
                    $("#create-buy").prop('checked', false);
                }

            });
        </script>
</body>

</html>