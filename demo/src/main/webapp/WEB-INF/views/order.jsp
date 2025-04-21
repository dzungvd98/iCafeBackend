<%-- 
    Document   : order
    Created on : Apr 4, 2025, 12:07:54 AM
    Author     : ADMIN
--%>

<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>

<head>
    <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
    <title>Coffee Shop - Đặt hàng</title>
    <!-- Bootstrap 5 CSS -->
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0-alpha1/dist/css/bootstrap.min.css" rel="stylesheet">
    <!-- Bootstrap Icons -->
    <link rel="stylesheet" href="https://cdn.jsdelivr.net/npm/bootstrap-icons@1.10.0/font/bootstrap-icons.css">
    <style>
        body {
            background-color: #f8f9fa;
        }

        
        .notification-icon {
            width: 32px;
            height: 32px;
            display: flex;
            align-items: center;
            justify-content: center;
            border-radius: 50%;
            background-color: #f1f3f5;
            margin-right: 0.5rem;
        }
        
        .nav-tabs .nav-link {
            color: #6c757d;
            border: none;
            padding: 15px 0;
            margin-right: 20px;
            font-weight: 500;
        }

        .nav-tabs .nav-link.active {
            color: #0d6efd;
            border-bottom: 2px solid #0d6efd;
            background-color: transparent;
        }

        .product-card {
            border-radius: 12px;
            overflow: hidden;
            transition: transform 0.3s;
            height: 100%;
        }

        .product-card:hover {
            transform: translateY(-5px);
            box-shadow: 0 10px 20px rgba(0, 0, 0, 0.1);
        }

        .product-img-container {
            width: 100%;
            height: 180px;
            background-color: #ffe8c8;
            display: flex;
            align-items: center;
            justify-content: center;
            overflow: hidden;
            position: relative;
        }

        .product-img {
/*            width: 100%;
            height: 100%;*/
            position: absolute;
            top: 0;
            left: 0;
            width: 100%;
            height: 100%;
            object-fit: cover;
            object-position: center;
        }

        .product-info {
            padding: 15px;
            background-color: white;
        }

        .product-title {
            font-size: 14px;
            font-weight: 500;
            margin-bottom: 5px;
        }

        .product-price {
            font-weight: bold;
            color: #212529;
            text-align: right;
        }

        .quantity-control {
            display: flex;
            align-items: center;
            justify-content: space-between;
            margin-top: 10px;
            /*border: 1px solid #dee2e6;*/
            border-radius: 8px;
            padding: 5px 10px;
        }

        .quantity-btn {
            background: none;
            border: none;
            font-size: 18px;
            color: #6c757d;
            cursor: pointer;
        }

        .quantity-display {
            font-size: 18px;
            font-weight: 500;
        }

        .badge-container {
            font-size: 12px;
            color: #6c757d;
            margin-bottom: 5px;
        }

        .back-button {
            color: #212529;
            text-decoration: none;
            display: flex;
            align-items: center;
        }

        .pagination-info {
            color: #6c757d;
            font-size: 14px;
        }
    </style>
    <style>
        /*Phần style cho popup=======================================*/
        /*style cho form popup*/
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

        .titile-modal-llh {
            font-size: 12px;
            font-weight: 400;
            color: #4E5A73;
        }

        .content-modal-llh {
            font-size: 16px;
            font-weight: 400;
            color: #021337;
            padding-bottom: 30px;
        }

        .form-label {
            font-size: 14px;
            color: #10182899;
        }

        /*style cho form popup*/

        .product-name {
            margin-bottom: 0.5rem;
            /* Khoảng cách nhỏ dưới tên */
            font-weight: bold;
            /* Làm nổi bật tên */
        }

        .product-price-popup {
            margin-bottom: 0.5rem;
            /* Khoảng cách nhỏ dưới giá */
            font-weight: bold;
            /* Làm nổi bật giá */
            color: blue;
        }

        .product-status {
            margin-bottom: 0.5rem;
            /* In nghiêng trạng thái */
            font-weight: bold;
            /* Làm nổi bật tính trạng */
        }

        /*Style cho tiêu đề Kích cỡ///////////////////////////////////*/
        .size-container {
            gap: 5px;
            /* Khoảng cách giữa các size-option */
        }

        .size-option {
            display: flex;
            /* Để căn chỉnh input, label và span trên cùng dòng */
            align-items: center;
            /* Căn chỉnh dọc các phần tử */
        }

        .size-price {
            display: block;
            /* Hiển thị giá trên dòng riêng */
            margin-left: auto;
            /* Đẩy giá về bên phải (nếu muốn) */
        }

        /* Tùy chỉnh khoảng cách giữa các radio button nếu cần thiết */
        .me-2 {
            margin-right: 1rem !important;
            /* Tăng khoảng cách bên phải */
        }

        .size-title {
            background-color: #e0f2f7;
            /* Màu xanh nhạt (tùy chỉnh) */
            padding: 5px 10px;
            /* Khoảng trắng bên trong khung */
            border-radius: 5px;
            /* Bo tròn góc (tùy chọn) */
            margin-bottom: 1rem;
            /* Tạo khoảng cách với các tùy chọn bên dưới */
            /*display: inline-block; /* Chỉ chiếm vừa đủ không gian của nội dung */
        }

        /* Style cho tiêu đề "Đường" /////////////////////////*/
        .sugar-title {
            background-color: #e0f2f7;
            /* Màu xanh nhạt (tùy chỉnh) */
            padding: 5px 10px;
            /* Khoảng trắng bên trong khung */
            border-radius: 5px;
            /* Bo tròn góc (tùy chọn) */
            margin-bottom: 1rem;
            /* Tạo khoảng cách với các tùy chọn bên dưới */
            /*display: inline-block; /* Chỉ chiếm vừa đủ không gian của nội dung */
        }

        /* Tăng khoảng cách giữa các radio button và label */
        .sugar-option {
            /*margin-bottom: 0.5rem; /* Khoảng cách giữa các tùy chọn đường */
            display: block;
            /* Mỗi tùy chọn trên một dòng */
        }

        .me-2 {
            margin-right: 0.5rem !important;
            /* Khoảng cách bên phải input radio */
        }

        /* Style cho tiêu đề "Đá" /////////////////////////*/
        .ice-title {
            background-color: #e0f2f7;
            /* Màu xanh nhạt (tùy chỉnh) */
            padding: 5px 10px;
            /* Khoảng trắng bên trong khung */
            border-radius: 5px;
            /* Bo tròn góc (tùy chọn) */
            margin-bottom: 1rem;
            /* Tạo khoảng cách với các tùy chọn bên dưới */
            /*display: inline-block; /* Chỉ chiếm vừa đủ không gian của nội dung */
        }

        /* Tăng khoảng cách giữa các radio button và label */
        .ice-option {
            /*margin-bottom: 0.5rem; /* Khoảng cách giữa các tùy chọn đá */
            display: block;
            /* Mỗi tùy chọn trên một dòng */
        }

        .wrap-orderpick {
            max-width: 1320px;
            margin: 0 auto;
            padding: 0 12px;
        }
    </style>

</head>

<body>
    <div class="container-fluid py-3" style="padding-bottom: 0!important;background-color: #fff;">
        <div class="wrap-orderpick">
              <!-- Header -->
              <div class="d-flex justify-content-between align-items-center mb-3">
                  <a href="processing" class="back-button">
                      <i class="bi bi-arrow-left me-2"></i>
                      <span class="fw-medium">Đặt hàng</span>
                  </a>
                  <div class="d-flex align-items-center">
                      <div class="notification-icon">
                          <i class="bi bi-bell small"></i>
                      </div>
                      <div class="user-avatar">
                          <img src="imgs/Avatar.png" alt="User" class="w-100 h-100">
                      </div>
                  </div>
              </div>

              <!-- Navigation Tabs -->
              <div class="wrap-control" style="display: flex; flex-wrap: nowrap; justify-content: space-between;">
                  <div class="wrap-tabs">
                      <ul class="nav nav-tabs border-0 mb-4" id="categoryTabs" style="margin-bottom: 0!important;">
                          <li class="nav-item">
                              <a class="nav-link active" href="#">Cà phê</a>
                          </li>
                          <li class="nav-item">
                              <a class="nav-link" href="#">Trà sữa & Trà trái cây</a>
                          </li>
                          <li class="nav-item">
                              <a class="nav-link" href="#">Sinh tố & nước ép</a>
                          </li>
                          <li class="nav-item">
                              <a class="nav-link" href="#">Đồ uống đá xay</a>
                          </li>
                      </ul>
                  </div>

                  <!-- Search Bar -->
                  <div class="d-flex justify-content-between align-items-center mb-4" style="margin-bottom: 0!important;">
                      <div class="position-relative w-100 me-3">
                          <i class="bi bi-search position-absolute" style="left: 15px; top: 10px;"></i>
                          <input id="input-search" type="text" class="form-control ps-5 py-2" placeholder="Tìm kiếm"
                                 style="border-radius: 20px;">
                      </div>
                      <!--button bi bi-cart-->
                      <a class="btn-cart btn btn-outline-secondary" href="#"
                         style="border-radius: 50%; width: 40px; height: 40px;">
                          <i class="bi bi-cart"></i>
                      </a>
                  </div>
              </div>
        </div>
    </div>
    
    <div style="width: 100%;border-bottom: 1px solid #dee2e6;"></div>
    
    <div class="container-fluid py-3">
        <div class="wrap-orderpick">
            <!-- Pagination Info -->

            <!-- Product Grid -->
            <div id="product-list" class="row g-4">
                <!-- Product 1 -->
                <div class="col-6 col-md-4 col-lg-3">
                    <div class="product-card">
                        <div class="product-img-container">
                            <img src="imgs/Head.png" alt="Cà phê đen(Nóng)" class="product-img">
                        </div>
                        <div class=" product-info">
                            <div class="badge-container">Còn</div>
                            <h5 class="product-title">Cà phê đen(Nóng)</h5>
                            <div class="d-flex justify-content-end">
                                <div class="product-price">10.000đ</div>
                            </div>
                            <div class="quantity-control">
                                <button class="quantity-btn">−</button>
                                <div class="quantity-display">0</div>
                                <button class="quantity-btn">+</button>
                            </div>
                        </div>
                    </div>
                </div>

                <!-- Product 2 -->
                <div class="col-6 col-md-4 col-lg-3">
                    <div class="product-card">
                        <div class="product-img-container">
                            <img src="imgs/Head.png" alt="Cà phê đen(Lạnh)" class="product-img">
                        </div>
                        <div class="product-info">
                            <div class="badge-container">Còn</div>
                            <h5 class="product-title">Cà phê đen(Lạnh)</h5>
                            <div class="d-flex justify-content-end">
                                <div class="product-price">15.000đ</div>
                            </div>
                            <div class="quantity-control">
                                <button class="quantity-btn">−</button>
                                <div class="quantity-display">0</div>
                                <button class="quantity-btn">+</button>
                            </div>
                        </div>
                    </div>
                </div>

                <!-- Product 3 -->
                <div class="col-6 col-md-4 col-lg-3">
                    <div class="product-card">
                        <div class="product-img-container">
                            <img src="imgs/Head.png" alt="Cà phê sữa(Lạnh)" class="product-img">
                        </div>
                        <div class="product-info">
                            <div class="badge-container">Còn</div>
                            <h5 class="product-title">Cà phê sữa(Lạnh)</h5>
                            <div class="d-flex justify-content-end">
                                <div class="product-price">15.000đ</div>
                            </div>
                            <div class="quantity-control">
                                <button class="quantity-btn">−</button>
                                <div class="quantity-display">0</div>
                                <button class="quantity-btn">+</button>
                            </div>
                        </div>
                    </div>
                </div>

                <!-- Product 4 -->
                <div class="col-6 col-md-4 col-lg-3">
                    <div class="product-card">
                        <div class="product-img-container">
                            <img src="imgs/Head.png" alt="Cà phê sữa(Nóng)" class="product-img">
                        </div>
                        <div class="product-info">
                            <div class="badge-container">Còn</div>
                            <h5 class="product-title">Cà phê sữa(Nóng)</h5>
                            <div class="d-flex justify-content-end">
                                <div class="product-price">30.000đ</div>
                            </div>
                            <div class="quantity-control">
                                <button class="quantity-btn">−</button>
                                <div class="quantity-display">0</div>
                                <button class="quantity-btn">+</button>
                            </div>
                        </div>
                    </div>
                </div>

                <!-- Product 5 -->
                <div class="col-6 col-md-4 col-lg-3">
                    <div class="product-card">
                        <div class="product-img-container">
                            <img src="imgs/Head.png" alt="Cà phê dừa" class="product-img">
                        </div>
                        <div class="product-info">
                            <div class="badge-container">Còn</div>
                            <h5 class="product-title">Cà phê dừa</h5>
                            <div class="d-flex justify-content-end">
                                <div class="product-price">30.000đ</div>
                            </div>
                            <div class="quantity-control">
                                <button class="quantity-btn">−</button>
                                <div class="quantity-display">0</div>
                                <button class="quantity-btn">+</button>
                            </div>
                        </div>
                    </div>
                </div>
            </div>
        </div>
    </div>

    <!--html cho phần popup - modal create///////////////////////////////-->
    <!--Modals create-->
    <div class="modal fade right" id="create-modal" tabindex="-1" aria-hidden="true">
        <div class="modal-dialog">
            <div class="modal-content" style="height: 100%;">
                <!--Modal - header - OK-->
                <div class="modal-header">
                    <div class="wrap-header-modal">
                        <h5>Chi tiết món</h5>
                    </div>
                    <button type="button" class="btn-close" data-bs-dismiss="modal" aria-label="Đóng"></button>
                </div>

                <!--Modal - body-->
                <div class="modal-body">
                    <div class="row align-items-center">
                        <div class="col-md-4">
                            <img id="img-product-selected" src="imgs/product-image.png" alt="[Tên sản phẩm]"
                                class="img-fluid product-image"
                                style="max-width: 100%; height: auto; object-fit: contain;" />
                        </div>
                        <div class="col-md-8 product-info">
                            <h6 class="product-name">[Tên sản phẩm]</h6>
                            <p class="product-price-popup">[Giá sản phẩm]</p>
                            <p class="product-status">[Tình trạng]</p>
                        </div>
                    </div>

                    <!-- kích cỡ -->
                    <div class="row align-items-center full-width-heading">
                        <h6 class="size-title">Kích cỡ</h6>
                    </div>
                    <div class="mb-3 mt-3">
                        <!--<h6 class="size-title">Kích cỡ</h6>-->
                        <div class="size-container d-flex flex-column">
                            <!-- S -->
                            <div class="size-option">
                                <input type="radio" name="size" value="S" id="sizeS" class="me-2" />
                                <label for="sizeS" class="me-2">S</label>
                                <span class="size-price" data-size="S">0đ</span>
                            </div>
                            <!-- M -->
                            <div class="size-option">
                                <input type="radio" name="size" value="M" id="sizeM" class="me-2" />
                                <label for="sizeM" class="me-2">M</label>
                                <span class="size-price" data-size="M">5.000đ</span>
                            </div>
                            <!-- L -->
                            <div class="size-option">
                                <input type="radio" name="size" value="L" id="sizeL" class="me-2" />
                                <label for="sizeL" class="me-2">L</label>
                                <span class="size-price" data-size="L">10.000đ</span>
                            </div>
                        </div>
                    </div>

                    <!-- Kiểu đồ uống -->
                    <div class="drink-type row align-items-center full-width-heading">
                        <h6 class="sugar-title">Kiểu đồ uống</h6>
                        <div class="mb-3">
                            <!--<h6 class="ice-title">Đá</h6>-->
                            <div class="type-options">
                                <label id="label-hot" class="sugar-option">
                                    <input type="radio" name="type" value="1" class="me-2">
                                    Nóng
                                </label>
                                <label id="label-cool" class="sugar-option">
                                    <input type="radio" name="type" value="2" class="me-2">
                                    Lạnh
                                </label>
                            </div>
                        </div>
                    </div>


                    <!-- Đá -->
                    <div class="ice-percent row align-items-center full-width-heading">
                        <h6 class="ice-title">Đá</h6>
                        <div class="mb-3">
                            <!--<h6 class="ice-title">Đá</h6>-->
                            <div class="ice-options">
                                <label class="ice-option">
                                    <input type="radio" name="ice" value="100" class="me-2">
                                    100%
                                </label>
                                <label class="ice-option">
                                    <input type="radio" name="ice" value="50" class="me-2">
                                    50%
                                </label>
                                <label class="ice-option form-check-label">
                                    <input type="radio" name="ice" value="0" class="me-2">
                                    0%
                                </label>
                            </div>
                        </div>
                    </div>


                    <!-- Đường -->
                    <div class="row align-items-center full-width-heading">
                        <h6 class="sugar-title">Đường</h6>
                    </div>
                    <div class="mb-3">
                        <!--<h6 class="sugar-title">Đường</h6>-->
                        <div class="sugar-options">
                            <label class="sugar-option">
                                <input type="radio" name="sugar" value="100" class="me-2">
                                100%
                            </label>
                            <label class="sugar-option">
                                <input type="radio" name="sugar" value="50" class="me-2">
                                50%
                            </label>
                            <label class="sugar-option form-check-label">
                                <input type="radio" name="sugar" value="0" class="me-2">
                                0%
                            </label>
                        </div>
                    </div>



                </div>

                <!--Modal - footer - OK-->
                <div class="modal-footer">
                    <button id="btn-add-to-cart" type="button"
                        class="btn btn-add btn-primary w-100 btn-continue rounded-pill">Thêm vào giỏ hàng -
                        30.000đ</button>
                    <!--<button type="button" class="btn btn-secondary" data-bs-dismiss="modal" style="background-color: #1F75FF">Thêm vào giỏ hàng - 30.000đ</button>-->
                </div>
            </div>
        </div>
    </div>

</body>
<%@ include file="toast.jsp" %>
<script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0-alpha1/dist/js/bootstrap.bundle.min.js"></script>
<script src="https://code.jquery.com/jquery-3.6.0.min.js"></script>
<script src="js/action.js"></script>
<script>
    $(document).ready(function () {
        // VÙNG 1: VÙNG KHAI BÁO BIẾN TOÀN CỤC
        const BASE_URL = "http://localhost:8080";
        let gPage = 1;
        let gSize = 12;
        let gTotalPage = null;
        let gIsLoading = false;
        let currentCategoryId = null;
        let gCurrentQuantity = 0;
        let debounceTimer;

        // VÙNG 2: VÙNG GÁN VÀ THỰC THI SỰ KIỆN CHO CÁC ELEMENT
        onPageLoading();

        $('#product-list').on('click', ".quantity-btn", function () {
            onChangeQuantityClick(this);
        });

        // Change price when checkbox size
        $('.size-container').on('change', 'input[type=radio][name=size]', function () {
            const selectedSize = $(this).val();
            const price = $(this).closest('.size-option').find('.size-price').text();
            $('.btn-add').html("Thêm vào giỏ hàng - " + price);
            $(".product-price-popup").html(price);
        });

        // Change display ice percent when change selection
        $('input[name="type"]').on('change', function () {
            const selectedValue = $('input[name="type"]:checked').val();
            onChangeHaveType(selectedValue);
        });

        // Product card click to show modal
        $('#product-list').on('click', '.product-img-container', function () {
            let productId = $(this).closest('.product-card').attr('id');
            $('#create-modal').modal('show');
            callApiToGetDetailsProduct(productId);
            gCurrentQuantity = $(this).closest('.product-card').find('.quantity-display').html();
            if (gCurrentQuantity == 0) {
                gCurrentQuantity = 1;
            }
        });

        // Click btn add to card
        $(document).on('click', '#btn-add-to-cart', function () {
            onBtnAddToCardClick();
        });

        $(window).on('scroll', function () {
            if ($(window).scrollTop() + $(window).height() >= $(document).height() - 200) {
                if (currentCategoryId) {
                    callAPIToloadProductByCategory(currentCategoryId);
                }
            }
        });

        $("#input-search").on("keyup", function () {
            clearTimeout(debounceTimer);

            debounceTimer = setTimeout(function () {
                resetPagination();
                callAPIToloadProductByCategory(currentCategoryId);
            }, 400); // chờ 400ms sau khi ngừng gõ
        });
        
        $("#input-search").on("click", function () {
            $(this).val("");
        });


        $(".btn-cart").on("click", function () {
            let cart = JSON.parse(localStorage.getItem('cart')) || [];
            if (cart.length > 0) {
                window.location.href = "orderpick";
            } else {
                showToast("Giỏ hàng trống!", "warning");
            }
        });

        // VÙNG 3: VÙNG VIẾT CÁC HÀM XỬ LÝ SỰ KIỆN
        function onPageLoading() {
            callAPIToloadProductByCategory(1);
            callApiToLoadCategories();
        }

        function onChangeQuantityClick(element) {
            var $display = $(element).parent().find('.quantity-display');
            var quantity = parseInt($display.text());

            if ($(element).text() === '+') {
                quantity++;
            } else if ($(element).text() === '−' && quantity > 0) {
                quantity--;
            }

            $display.text(quantity);
        }

        // Hàm thêm món vào giỏ hàng, khi thêm thì lưu vào localstorage
        function onBtnAddToCardClick() {
            let product = getProductDataToAddCart();
            let cart = JSON.parse(localStorage.getItem('cart')) || [];
            const existingProductIndex = cart.findIndex(item => item.variantId === product.variantId && String(item.type) === product.type);
            if (existingProductIndex > -1) {
                cart[existingProductIndex].quantity += product.quantity;
            } else {
                cart.push(product);
            }

            localStorage.setItem('cart', JSON.stringify(cart));

            $("#create-modal").modal("hide");
        }
        // VÙNG 4: VÙNG VIẾT CÁC HÀM DÙNG CHUNG

        function callApiToGetDetailsProduct(productId) {
            let vHeaders = {
                    Authorization: "Token " + getCookie("token")
            };
            $.ajax({
                url: BASE_URL + "/products/" + productId + "/details",
                method: "GET",
                headers: vHeaders,
                success: function (response) {
                    loadDetailProductToPopupOrder(response);
                },
                error: function (xhr, status, error) {
                    console.error("Error loading products:", error);
                }
            });
        }

        function loadDetailProductToPopupOrder(responseProductData) {
            $(".product-name").text(responseProductData.productName);
            var productStatus = responseProductData.isAvailable == true ? "còn" : "hết";
            $(".product-status").text(productStatus);
            var imgUrl = BASE_URL + responseProductData.urlImage;
            $(".product-image").attr('src', imgUrl);



            var vSizeContainer = $(".size-container");
            vSizeContainer.empty();
            $.each(responseProductData.variants, function (index, size) {
                let price = size.price.toLocaleString('vi-VN') + ' đ';
                let checked = index === 0 ? 'checked' : '';
                let vSize = `<div class="size-option">
                                <input variant-id="`+ size.variantId + `" type="radio" name="size" value="` + size.sizeName + `" class="size me-2" ` + checked + `/>
                                <label for="size`+ size.sizeName + `" class="me-2">` + size.sizeName + `</label>
                                <span class="size-price" data-size="`+ size.sizeName + `">` + price + `</span>
                            </div>`;
                vSizeContainer.append(vSize);
            });

            // Display type and ice percent
            resetTypeSelect()

            if (responseProductData.haveType == 1) {
                $("#label-cool").hide();
                $("#label-hot input").prop("checked", true).prop('disabled', true);
            } else if (responseProductData.haveType == 2) {
                $("#label-hot").hide();
                $(".ice-percent").show();
                $("#label-cool input").prop("checked", true).prop('disabled', true);
            } else if (responseProductData.haveType == 3) {
                $("#label-hot input").prop("checked", true);
            }

            let selected = $('input[type=radio][name=size]:checked');
            let selectedPrice = selected.closest('.size-option').find('.size-price').text();
            $('.btn-add').html("Thêm vào giỏ hàng - " + selectedPrice);
            $(".product-price-popup").html(selectedPrice);
        }

        function callAPIToloadProductByCategory(categoryId) {
            if (gIsLoading || (gTotalPage !== null && gPage > gTotalPage)) return;
            gIsLoading = true;
            currentCategoryId = categoryId;

            let vSearchValue = $("#input-search").val();
            let vHeaders = {
                    Authorization: "Token " + getCookie("token")
            };

            $.ajax({
                url: BASE_URL + "/categories/" + categoryId + "/products?page=" + gPage + "&size=" + gSize + "&keyword=" + vSearchValue,
                method: "GET",
                headers: vHeaders,
                success: function (response) {
                    if (gPage === 1) {
                        $('#product-list').empty();
                    }

                    loadProducts(response);
                    gTotalPage = response.totalPages;
                    if (gPage <= gTotalPage) {
                        gPage++;
                    }
                    gIsLoading = false;
                },
                error: function (error) {
                    console.error("Error loading products:", error);
                    gIsLoading = false;
                    if (error.status === 403) {
                        deleteCookie("token");
                        window.location.href = "login";
                    }
                }
            });
        }

        // Hàm load product vào 
        function loadProducts(response) {
            // Render danh sách sản phẩm
            $.each(response.contents, function (index, product) {
                var price = product.listPrice.split(',')[0].trim();
                var priceNum = Number(price.replace(/\D/g, '')); // bỏ ký tự không phải số
                var vprice = priceNum.toLocaleString('vi-VN') + ' đ';
                var urlImage = BASE_URL + product.urlImage;
                var status = product.isAvailable === true ? "còn" : "hết";
                var productCard = `
                        <div class="col-6 col-md-4 col-lg-3">
                            <div id="` + product.productId + `"" class="product-card">
                                <div class="product-img-container">
                                    <img src="` + urlImage + `" alt="` + product.productName + `" class="product-img">
                                </div>
                                <div class="product-info">
                                    <div class="badge-container">` + status + `</div>
                                    <h5 class="product-title">` + product.productName + `</h5>
                                    <div class="d-flex justify-content-end">
                                        <div class="product-price">` + vprice + `</div>
                                    </div>
                                    <div class="quantity-control">
                                        <button class="quantity-btn">−</button>
                                        <div class="quantity-display">0</div>
                                        <button class="quantity-btn">+</button>
                                    </div>
                                </div>
                            </div>
                        </div>
                    `;
                $('#product-list').append(productCard);
            });
        }

        // Hàm gọi API để load category vào thanh tag
        function callApiToLoadCategories() {
            let vHeaders = {
                    Authorization: "Token " + getCookie("token")
            };
            $.ajax({
                url: BASE_URL + "/categories/",
                method: "GET",
                headers: vHeaders,
                success: function (data) {
                    loadResponseCategory(data);

                },
                error: function (error) {
                    console.error("Không thể tải danh sách danh mục!");
                    if (error.status === 403) {
                        deleteCookie("token");
                        window.location.href = "login";
                    }
                }
            });
        }

        function loadResponseCategory(response) {
            const $tabs = $('#categoryTabs');
            $tabs.empty();

            $.each(response.data, function (index, category) {
                const activeClass = index === 0 ? 'active' : '';
                const tab = `
                    <li class="nav-item">
                        <a class="nav-link `+ activeClass + `" href="#" data-id="` + category.id + `">` + category.categoryName + `</a>
                    </li>
                `;
                $tabs.append(tab);
            });

            // Bắt sự kiện click sau khi render tab
            $('#categoryTabs .nav-link').on('click', function (e) {
                e.preventDefault();
                $('#categoryTabs .nav-link').removeClass('active');
                $(this).addClass('active');
                const categoryId = $(this).data('id');
                resetPagination();
                callAPIToloadProductByCategory(categoryId);
            });
        }

        function onChangeHaveType(haveType) {
            resetTypeSelect();
            if (haveType == 1) {
                $("#label-hot input").prop("checked", true);
            } else if (haveType == 2) {
                $(".ice-percent").show();
                $("#label-cool input").prop("checked", true);
            }

        }

        function resetPagination() {
            gPage = 1;
            gTotalPage = null;
            gIsLoading = false;
            $("#product-list").empty();
        }

        function resetTypeSelect() {
            const $labelHot = $("#label-hot");
            const $labelCool = $("#label-cool");
            const $inputHot = $("#label-hot input");
            const $inputCool = $("#label-cool input");
            const $icePercent = $(".ice-percent");

            // Reset tất cả về trạng thái mặc định
            $labelHot.show();
            $labelCool.show();
            $inputHot.prop("checked", false).prop("disabled", false);
            $inputCool.prop("checked", false).prop("disabled", false);
            $icePercent.hide();
            $('.ice-options input[name="ice"][value="100"]').prop('checked', true);
            $('.sugar-options input[name="sugar"][value="100"]').prop('checked', true);
        }

        // Hàm lấy thông tin sản phẩm để thêm vào giỏ hàng
        function getProductDataToAddCart() {
            var product = {
                variantId: 0,
                quantity: 0,
                productName: "",
                priceEach: 0,
                imgUrl: "",
                type: "",
                size: "",
                sugar: "",
                ice: ""
            }

            product.productName = $(".product-name").html();
            product.quantity = gCurrentQuantity;
            let selectedRadio = $('input[name="size"]:checked');
            product.size = selectedRadio.val(); // "S" hoặc "M"
            product.variantId = selectedRadio.attr('variant-id');
            product.priceEach = $(".product-price-popup").html();
            product.imgUrl = $("#img-product-selected").attr("src");
            product.type = $('input[name = "type"]:checked').val();
            let icePercent = $('input[name = "ice"]:checked').val();
            product.ice = product.type == 2 ? icePercent : "-1";
            product.sugar = $('input[name = "sugar"]:checked').val();

            return product;
        }
        
        function navigateToCorrectPage() {
            const token = getCookie("token");
            if (token && isTokenValid(token)) {
                const role = getUserRoleFromToken(token);
                    
                switch (role) {
                    case "ADMIN":
                        break;
                    case "STAFF":
                        break;
                    case "MANAGER":
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

</html>