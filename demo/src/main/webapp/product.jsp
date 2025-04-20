<%-- 
    Document   : MenuAdmin
    Created on : Mar 28, 2025, 11:07:42 AM
    Author     : ADMIN
--%>

<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
    <head>
        
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
    <title>Quản lý sản phẩm</title>
    <link rel="stylesheet" href="css/style_menu.css"/>
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
          overflow: hidden; /* Ẩn phần hình ảnh vượt quá khung */
          position: relative; /* Để định vị tuyệt đối hình ảnh bên trong */
      }

      .preview-image {
          position: absolute;
          top: 0;
          left: 0;
          width: 100%;
          height: 100%;
          object-fit: cover; /* Scale hình ảnh để lấp đầy khung, cắt phần dư */
          object-position: center; /* Đảm bảo tâm của hình ảnh ở giữa */
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
  <div class="sidebar">
    <div class="logo-container">
           <a href="product">
            <img src="imgs/Logo.png" alt="alt"/>
        </a>
    </div>

    <div class="wrap-order-button" style="display: flex; justify-content: center;">
        <div class="order-button">
            <a href="order" style="text-decoration: none;">Đặt hàng</a>
        </div>
    </div>
    <div class="wrap-nav">
        <div class="nav-item nav-product active">
                <a href="product">
                    <i class="bi bi-cup-straw"></i>
                    Sản phẩm
                </a>
            </div>

            <div class="nav-item nav-order ">
                <a href="processing">
                    <i class="bi bi-cart"></i>
                    Đơn hàng
                </a>

            </div>

            <div class="nav-item nav-report">
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
        <span class="fw-medium">Sản Phẩm</span>
        
        
        <button onclick="showToast()">Hiển thị Toast</button>
        
        
        
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
          <!--<div>${Message}</div>-->
          <div class="d-flex gap-2 flex-wrap">
                  <div class="search-container mb-2">
                      <i class="bi bi-search"></i>
                      <input type="text" value="${search}" name="search" class="form-control search-input" placeholder="Tìm kiếm">
                  </div>

                  <button class="btn btn-outline-secondary mb-2" hidden>
                  Xuất dữ liệu
              </button>

              <button class="btn btn-primary add-button mb-2" data-bs-toggle="modal" data-bs-target="#create-modal">
                  <i class="bi bi-plus"></i> Thêm
              </button>
          </div>
      </div>
    </div>
    <div style="border-bottom: 1px solid var(--border-color); width: 100%;"></div>
    <div class="content-area" >
      <div class="d-flex justify-content-between mb-4 flex-wrap">
        <div class="mb-2">
          <button class="btn btn-outline-secondary sort-button">
            Sắp xếp: Danh mục
            <span class="sort-icon"><img src="imgs/arrows-down.png" alt="alt"/>️</span>
          </button>
        </div>
        
          <div class="d-flex gap-2 flex-wrap" style="align-items: center;">
              <div class="page-info"> ${CurrentPage} - ${TotalPage} trong số ${PageSize} </div>
              <div class="d-flex gap-2 align-items-center" ">
                    <form action="product"  method="GET">
                          <input class="page-previous" value="${PagePrevious}" name="page" hidden/>
                          <button class="btn btn-sm btn-light">
                            <i class="bi bi-chevron-left"></i>
                          </button>
                    </form>
                    <form action="product" method="GET">
                        <input  class="page-next" value="${PageNext}" name="page" hidden/>
                        <button class="btn btn-sm btn-light">
                            <i class="bi bi-chevron-right"></i>
                        </button>
                    </form>
                    <button class="btn btn-sm btn-light" hidden>
                        <i class="bi bi-funnel"></i>
                    </button>
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
          <tbody id="load-product">
                <% 
                   List<Product> listProducts = (List<Product>) request.getAttribute("Products");
                %>
           
                <%
                if (listProducts != null) {
                    DecimalFormat df = new DecimalFormat("#,###");
                    for (Product product : listProducts) {
                        %>
                    <tr class="product-row" data-id="<%= product.getProductId()%>" data-bs-toggle="modal" data-bs-target="#slideModal">
                        <td class="id-product"><%= product.getProductId()%></td>
                        <td>
                            <img src="http://localhost:8080<%=product.getUrlImage() %>" alt="Cà phê sữa" class="product-image">
                        </td>
                        <td class="name-product"><%= product.getProductName()%></td>
                        <td><%= product.getCategoryName() %></td>
                        <td><%= product.getSizes() %></td>
                        <%
                            String listPrice = "";
                            String[] numberArray = product.getListPrice().split(",");
                            for (int i = 0; i < numberArray.length; i++) {
                                if(i == numberArray.length-1)
                                {
                                    listPrice += df.format(Integer.parseInt(numberArray[i].trim())).toString()+ " đ";
                                } else {
                                    listPrice += df.format(Integer.parseInt(numberArray[i].trim())).toString() + " đ" +", " ;
                                }
                            }
                        %>
                        
                        <td><%= listPrice %></td>
                       
                        <td>
                            <%
                                if(product.isAvailable())
                                {
                                %><span class="status-badge status-in">Còn</span><%
                                } else {
                                %><span class="status-badge status-out">Hết</span><%
                                }
                            %>
                        <td>
                            <button class="action-button edit-btn" data-bs-toggle="modal" data-bs-target="#edit-modal" data-id="<%= product.getProductId()%>" >
                                <i class="bi bi-pencil" style="color: black;"></i>
                            </button>
                            <button class="action-button delete-btn" data-bs-toggle="modal" data-bs-target="#confirmationModal" data-id="<%= product.getProductId()%>">
                                <i class="bi bi-trash"></i>
                            </button>
                        </td>
                    </tr>
                        <%
                    }
                }%>
          </tbody>
        </table>
      </div>
    </div>
  </div>
            
            
  <!--Modals delete-->
   <div class="modal fade" id="confirmationModal" tabindex="-1" aria-labelledby="confirmationModalLabel" aria-hidden="true">
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
            <button type="button" class="btn btn-confirm" style="background-color: #1F75FF; color: #fff;">Xác nhận</button>
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
                </div>
                <button type="button" class="btn-close" data-bs-dismiss="modal" aria-label="Đóng"></button>
            </div>
            
            <div class="modal-body" >
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
                        <input class="form-check-input" checked type="checkbox" name="directSale" id="buy" value="isDirectSale" disabled>
                        <label class="form-check-label content-modal-llh" for="buy">Bán trực tiếp</label>
                    </div>
                </div>
            </div>
            
<!--            <div class="modal-footer">
                <button class="action-button edit-btn" data-bs-toggle="modal" data-bs-target="#edit-modal" data-id="1" style="width: 40px;height: 40px;border: 1px solid #EAECF0;border-radius: 50px;">
                    <i class="bi bi-pencil" style="color: black;"></i>
                </button>
                <button class="action-button delete-btn" data-bs-toggle="modal" data-bs-target="#confirmationModal" data-id="1" style="width: 40px;height: 40px;border: 1px solid #EAECF0;border-radius: 50px;">
                    <i class="bi bi-trash"></i>
                </button>
            </div>-->
            
        </div>
    </div>
</div>
    
    
    <style>
        #create-modal .form-control,
        #create-modal .form-select{
            height: 46px;
        }
    </style>
    
   <!--Modals create-->    
<div class="modal fade right" id="create-modal" tabindex="-1" aria-hidden="true">
    <div class="modal-dialog">
       
        <div class="modal-content" style="height: 100%;">
            <form action="product" method="post" enctype="multipart/form-data" style="height:100%; display: flex; flex-direction: column;" >
                <div class="modal-header">
                    <div class="wrap-header-modal">
                        <div style="font-size: 20px; font-weight: 500">Thêm món</div>
                    </div>
                    <button type="button" class="btn-close" data-bs-dismiss="modal" aria-label="Đóng"></button>
                </div>
                <div class="modal-body" >
                    <div class="mb-3">
                        <input type="text" placeholder="Tên" name="productName" class="form-control" id="productName" value="">
                    </div>
                    <div class="mb-3">
                          <select class="form-select" id="category" name="category">
                                <option value="-1" selected>Danh mục</option>
                            <% 
                                List<Category> categries = (List<Category>) request.getAttribute("categries");
                            %>
                            <%
                                if (categries != null) {
                                    for (Category c : categries) {
                                    %>
                                        <option value="<%= c.getId()%>"><%= c.getCategoryName()%></option>
                                    <%
                                }
                            }%>
                          </select>
                    </div>
                    <div class="mb-3">
                          <div class="input-group">
                             <input type="text" placeholder="Giá gốc" name="productPrice" class="form-control" id="price" value="" style="width: 100%">
                            <span class="" style="position: fixed; right: 7%; padding-top: 10px; z-index: 99;">đ</span>
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
                                    <input type="text" readonly name="productSizeS" class="form-control col-md-6" value="S" style="width: 48%; margin-right: 2%">
                                    <input type="text" name="productPriceOfSizeS" class="form-control col-md-6" value="" style="width: 48%; margin-left: 2%">
                                    <span style="position: fixed; right: -88%; padding-top: 10px;">đ</span>
                                </div>

                                <div class="row" style="padding: 0 15px; padding-bottom: 15px;">
                                    <input type="text" readonly name="productSizeM" class="form-control col-md-6" value="M" style="width: 48%; margin-right: 2%">
                                    <input type="text" name="productPriceOfSizeM" class="form-control col-md-6" value="" style="width: 48%; margin-left: 2%">
                                    <span style="position: fixed; right: -88%; padding-top: 10px;">đ</span>
                                </div>

                                 <div class="row" style="padding: 0 15px;">
                                    <input type="text" readonly name="productSizeL" class="form-control col-md-6" value="L" style="width: 48%; margin-right: 2%">
                                    <input type="text" name="productPriceOfSizeL" class="form-control col-md-6" value="" style="width: 48%; margin-left: 2%">
                                    <span style="position: fixed; right: -88%; padding-top: 10px;">đ</span>
                                </div>
                            </div>
                    </div>
                    <div class="mb-3">
                            <label for="type" class="form-label">Trạng thái</label>
                            <div style="display: flex;">
                                <div class="form-check form-check-inline" style="width: 50%;">
                                  <input class="form-check-input" type="radio" name="availability" id="edit-available" value="true" checked>
                                  <label class="form-check-label" for="edit-available">Còn</label>
                                </div>
                                <div class="form-check form-check-inline" style="width: 50%;">
                                  <input class="form-check-input" type="radio" name="availability" id="edit-outOfStock" value="false">
                                  <label class="form-check-label" for="edit-outOfStock">Hết</label>
                                </div>
                            </div>
                    </div>
                    <div class="mb-3">
                            <label for="type" class="form-label">Mô tả hình ảnh</label>
                            <div class="image-upload-container row" style="padding-left: 10px;">
                                <input type="file" name="productImage" accept="image/*" id="create-productImage" hidden/>
                                <div class="col-md-2 update-load-imgs pick-image">
                                    <img src="imgs/Button.png" alt="alt"/>
                                </div>
                                
                                <div class="col-md-2 update-load-imgs wrap-upload">
                                    <div class="frame-pick-image">
                                        <img src="imgs/Button.png" alt="alt" class="preview-image"/>
                                    </div>
                                    <div class="upload-preview">
                                        <i class="bi bi-x image-delete" style="background-color: #5e5e5e8a;border-radius: 50%;color: #fff;cursor: pointer;"></i>
                                    </div>
                                </div>
                            </div>
                    </div>
                    <div class="mb-3">
                            <input class="form-check-input" type="checkbox" name="directSale" id="create-buy" value="isDirectSale">
                            <label class="form-check-label" for="create-buy">Bán trực tiếp</label>
                    </div>
                </div>
                <div class="modal-footer" style="justify-content: center;">
                    <button type="submit" class="btn btn-secondary" data-bs-dismiss="modal" style="background-color: #1F75FF;width: 200px;">Tạo</button>
                </div>
            </form>
        </div>
    </div>               
</div>
   
                          <style>
                                #edit-modal .form-label
                                {
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
            <form action="product" method="post" enctype="multipart/form-data" style="height:100%; display: flex; flex-direction: column;" >
                <div class="modal-header">
                    <div class="wrap-header-modal">
                        <div style="font-size: 20px; font-weight: 500">Chỉnh sửa món</div>
                    </div>
                    <button type="button" class="btn-close" data-bs-dismiss="modal" aria-label="Đóng"></button>
                </div>
                <div class="modal-body" >
                    <div class="mb-3">
                        <label for="size" class="form-label">Tên</label>
                        <input type="text" name="productName" class="form-control edit-productname" value="">
                    </div>
                    <div class="mb-3">
                        <label for="size" class="form-label">Danh mục</label>
                        <select class="form-select" id="edit-category" name="category">
                            <% 
                                List<Category> editCategries = (List<Category>) request.getAttribute("categries");
                            %>
                            <%
                                if (categries != null) {
                                    for (Category c : editCategries) {
                                    %>
                                        <option value="<%= c.getId()%>"><%= c.getCategoryName()%></option>
                                    <%
                                }
                            }%>
                        </select>
                    </div>
                    <div class="mb-3">
                        <label for="size" class="form-label">Giá gốc</label>
                        <div class="input-group">
                            <input type="number" name="productPrice" class="form-control edit-baseprice" id="price" value="" style="width: 100%">
                            <span class="" style="position: fixed; right: 7%; padding-top: 10px; z-index: 99;">đ</span>
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
                                <input type="text" readonly name="productSizeS" class="form-control col-md-6" value="S" style="width: 48%; margin-right: 2%">
                                <input type="number" name="productPriceOfSizeS" class="form-control col-md-6 edit-productPriceOfSizeS" value="" style="width: 48%; margin-left: 2%">
                                <span style="position: fixed; right: -88%; padding-top: 10px;">đ</span>
                            </div>

                            <div class="row" style="padding: 0 15px; padding-bottom: 15px;">
                                <input type="text" readonly name="productSizeM" class="form-control col-md-6" value="M" style="width: 48%; margin-right: 2%">
                                <input type="number" name="productPriceOfSizeM" class="form-control col-md-6  edit-productPriceOfSizeM" value="" style="width: 48%; margin-left: 2%">
                                <span style="position: fixed; right: -88%; padding-top: 10px;">đ</span>
                            </div>

                            <div class="row" style="padding: 0 15px;">
                                <input type="text" readonly name="productSizeL" class="form-control col-md-6" value="L" style="width: 48%; margin-right: 2%">
                                <input type="number" name="productPriceOfSizeL" class="form-control col-md-6  edit-productPriceOfSizeL" value="" style="width: 48%; margin-left: 2%">
                                <span style="position: fixed; right: -88%; padding-top: 10px;">đ</span>
                            </div>
                        </div>
                    </div>
                    <div class="mb-3">
                        <label for="type" class="form-label">Trạng thái</label>
                        <div style="display: flex;">
                            <div class="form-check form-check-inline" style="width: 50%;">
                                <input class="form-check-input edit-radio-true" type="radio" name="availability" id="r-available" value="true">
                                <label class="form-check-label" for="r-available">Còn</label>
                            </div>
                            <div class="form-check form-check-inline" style="width: 50%;">
                                <input class="form-check-input edit-radio-false" type="radio" name="availability" id="r-outOfStock" value="false">
                                <label class="form-check-label" for="r-outOfStock">Hết</label>
                            </div>
                        </div>
                    </div>
                    <div class="mb-3">
                        <label for="type" class="form-label">Mô tả hình ảnh</label>
                        <div class="image-upload-container row" style="padding-left: 10px;">
                            <input type="file" name="productImage" accept="image/*" id="edit-productImage" hidden/>
                            <div class="col-md-2 update-load-imgs edit-pick-image">
                                <img src="imgs/Button.png" alt="alt"/>
                            </div>

                            <div class="col-md-2 update-load-imgs edit-wrap-upload">
                                <div class="frame-pick-image">
                                    <img src="imgs/Button.png" alt="alt" class="edit-preview-image"/>
                                </div>
                                <div class="upload-preview">
                                    <i class="bi bi-x edit-image-delete" style="background-color: #5e5e5e8a;border-radius: 50%;color: #fff;cursor: pointer;"></i>
                                </div>
                            </div>
                        </div>
                    </div>
                    <div class="mb-3">
                        <input class="form-check-input edit-checkbox" type="checkbox" name="directSale" id="edit-buy" value="isDirectSale">
                        <label class="form-check-label" for="edit-buy">Bán trực tiếp</label>
                    </div>
                </div>
                <div class="modal-footer" style="justify-content: center;">
                    <input type="text" name="id" class="edit-productid" value="" hidden/>
                    <button type="submit" id="edit-update" class="btn btn-secondary" data-bs-dismiss="modal" style="background-color: #1F75FF; width: 200px;" >Cập nhật</button>
                </div>
            </form>
        </div>
    </div>               
</div>
   
    <%@ include file="toast.jsp" %>

  <!-- Bootstrap 5 JS Bundle with Popper -->
  <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.2/dist/js/bootstrap.bundle.min.js"></script>
  <script
  src="https://code.jquery.com/jquery-3.7.1.min.js"
  integrity="sha256-/JqT3SQfawRcv/BIHPThkBvs0OEvtFFmqPF/lYI/Cxo="
  crossorigin="anonymous"></script>
  <script src="js/action.js"></script>
  
  <!-- Custom JavaScript -->
  <script>
    // Mobile menu toggle
    document.querySelector('.mobile-menu-toggle')?.addEventListener('click', function() {
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
            $('.action-button').click(function(e) {
                e.preventDefault(); // Ngăn hành vi mặc định nếu cần
                const productName = $(this).closest('tr').find('.name-product').html();
                const productId = $(this).closest('tr').find('.id-product').html();
                $('#ProductNameJquery').html(productName);
            });
        });
//delete        
        $(document).ready(function() {
            let currentDeleteId = null;
            $(document).on('click', '.delete-btn', function(e) {
              e.preventDefault();
              const itemId = $(this).data('id');
              currentDeleteId = itemId;
            });

            $('.btn-confirm').click(function() {
                if (currentDeleteId) {
                  $.ajax({
                    url: 'product',
                    type: 'POST',
                    data: {
                      action: "delete",
                      deleteID: currentDeleteId
                    },
                    dataType: 'json',
                    success: function(response) {
                      if (response.status === 'success') {
                        console.log(response.message);
                        location.reload();
                      } else {
                          console.log(response.status);
                      }
                    },
                    error: function() {
                        console.log(response.status);
                    }
                  });
                }

                currentDeleteId = null;
             });

            // Xử lý khi click Cancel
            $('.cancel-btn').click(function() {
              currentDeleteId = null;
              $('#confirmDeleteModal').modal('close');
            });
      });
//detail
        $(document).ready(function() {
            $(document).on('click', '.product-row', function(e) {
              e.preventDefault();
              const itemId = $(this).data('id');
              if (itemId) {
                $(".wrap-productsizes").empty();

                $.ajax({
                     url: 'product',
                     type: 'POST',
                     data: { 
                        action: "detail",
                        detailID: itemId
                     },
                     dataType: 'json',
                     success: function(response) {
                         
                         var title = "#"+response.productId +" - "+ response.productName;
                         var available = response.isAvailable? "Còn":"Hết";
                         $('.detail-title').html(title);
                         $('.detail-categoryName').html(response.categoryName);
                         $('.detail-baseprice').html(formatMoney(response.basePrice) + " đ");
                         $('.detail-available').html(available);
                         
                         var type = "";
                         if(response.haveType == 1)
                         {
                             type = "Nóng"
                         }
                         
                         if(response.haveType == 2)
                         {
                             type = "Lạnh"
                         }
                         
                         if(response.haveType == 3)
                         {
                             type = "Nóng và lạnh"
                         }
                         $('.detail-havetype').html(type);
                        
                        $.each(response.variants, function(index, variant) {
                            console.log(variant.price);
                              var variantsHtml = `
                                <div class="col-md-6">
                                    <div class="lable-detail">Kich cỡ</div>
                                    <div class="content-modal-llh">` + variant.sizeName + `</div>
                                </div>
                                <div class="col-md-6">
                                    <div class="lable-detail">Giá</div>
                                    <div class="content-modal-llh">` + formatMoney(variant.price) + ` đ</div>
                                </div>
                            `;
                            $('.wrap-productsizes').append(variantsHtml);
                        });
                     },
                     error: function() {
                         console.log(response.status);
                     }
                   });
                }
            });
      });
      
     
//edit      
      $(document).ready(function() {
            $(document).on('click', '.edit-btn', function(e) {
              e.preventDefault();
              const itemId = $(this).data('id');
              if (itemId) {
                $.ajax({
                     url: 'product',
                     type: 'POST',
                     data: { 
                        action: "detail",
                        detailID: itemId
                     },
                     dataType: 'json',
                     success: function(response) {
                        $('.edit-productid').attr('value', response.productId);;
                        $('.edit-productname').val(response.productName);
                        $('.edit-baseprice').val(response.basePrice);
                        $('#edit-category option[value='+response.categoryId+']').prop('selected', true);
                        $('#edit-haveType option[value='+response.haveType+']').prop('selected', true);
                        $('.edit-preview-image').attr('src', 'http://localhost:8080'+response.urlImage).show();
                        
                        if(response.isAvailable)
                        {
                            $('.edit-radio-true').prop('checked', true);
                        }else {
                            $('.edit-radio-false').prop('checked', true);
                        }
                        
                        if(response.isDirectSale)
                        {
                            $('.edit-checkbox').prop('checked', true);
                        }else {
                            $('.edit-checkbox').prop('checked', false);
                        }
                        
                        $.each(response.variants, function(index, variant) {
                            if(variant.sizeName == "S")
                            {
                                $('.edit-productPriceOfSizeS').val(variant.price);
                            }
                            if(variant.sizeName == "M")
                            {
                                $('.edit-productPriceOfSizeM').val(variant.price);
                            }
                            if(variant.sizeName == "L")
                            {
                                $('.edit-productPriceOfSizeL').val(variant.price);
                            }
                        });
                     },
                     error: function() {
                         console.log(response.status);
                     }
                   });
                }
            });
      });
      
    $(document).ready(function() {
        $(document).on('click', '.pick-image', function(e) {
            $('#create-productImage').click();
        });
        
        $('#create-productImage').change(function() {
            if (this.files && this.files[0]) {
                var reader = new FileReader();

                reader.onload = function(e) {
                    $('.preview-image').attr('src', e.target.result).show();
                    $('.wrap-upload').css("display", "block");
                    $('.pick-image').css("z-index", "-1");
                }

                reader.readAsDataURL(this.files[0]);
                } else {
                    $('.preview-image').attr('src', '#').hide();
                    console.log("delete");
                }
        });
        
          $(document).on('click', '.image-delete', function(e) {
            $('#create-productImage').val('');
            $('.pick-image').css("z-index", "1");
            $('.wrap-upload').css("display", "none");
        });
    });
    
    $(document).ready(function() {
        $(document).on('click', '.edit-image-delete', function(e) {
            $('#edit-productImage').val('');
            $('.edit-pick-image').css("z-index", "1");
            $('.edit-wrap-upload').css("display", "none");
        });
        
        $(document).on('click', '.edit-pick-image', function(e) {
             $('#edit-productImage').click();
        });
        
         $('#edit-productImage').change(function() {
            if (this.files && this.files[0]) {
                var reader = new FileReader();

                reader.onload = function(e) {
                    $('.edit-preview-image').attr('src', e.target.result).show();
                    $('.edit-wrap-upload').css("display", "block");
                    $('.edit-pick-image').css("z-index", "-1");
                }

                reader.readAsDataURL(this.files[0]);
                } else {
                    $('.edit-preview-image').attr('src', '#').hide();
                }
        });
    });
    
    $(document).ready(function() {
        $('.search-input').on('input', function() {
            var text = $(this).val();
                $.ajax({
                     url: 'product',
                     type: 'GET',
                     data: { 
                        action: "search",
                        search: text
                     },
                     dataType: 'json',
                     success: function(response) {
                        $('#load-product').empty();
                        
                        var info = response.data.pageNumber + "-" + response.data.totalPages + " trong số " + response.data.pageSize;

                        $('.page-info').html(info);
                        
                        var pageMin = response.data.pageNumber - 1;
                        if(pageMin < 1)
                        {
                            pageMin = 1;
                        }
                        
                        var pageMax = response.data.pageNumber + 1;
                        if(pageMax >= response.totalPages)
                        {
                            pageMax = response.totalPages;
                        }
                        
                        $('.page-previous').attr('value', pageMin);
                        $('.page-next').attr('value', pageMax);
                        
                        
                        let products = response.data.contents;
                        var htmlAvailable ='';
                        products.forEach(function(product, index) {
                            var listPrice = product.listPrice.split(',');
                            var formattedList = listPrice.map(function(item) {
                                return formatMoney(item);
                            });
                            var resultString = formattedList.join(", ");
                            if(product.isAvailable)
                            {
                               htmlAvailable = '<span class="status-badge status-in">Còn</span>'
                            } else {
                               htmlAvailable = '<span class="status-badge status-out">Hết</span>'
                            }
                            
                            var item = `
                                <tr class="product-row" data-id="` + product.productId + `"" data-bs-toggle="modal" data-bs-target="#slideModal">
                                    <td class="id-product">` + product.productId + `</td>
                                    <td>
                                        <img src="http://localhost:8080` +product.urlImage+ `"" alt="` + product.productName + `"" class="product-image">
                                    </td>
                                    <td class="name-product">` + product.productName + `</td>
                                    <td>` + product.categoryName + `</td>
                                    <td>` + product.sizes + `</td>
                                    <td>` + resultString + `</td>
                                    <td>
                                        ` + htmlAvailable + `
                                    </td>
                                    <td>
                                        <button class="action-button edit-btn" data-bs-toggle="modal" data-bs-target="#edit-modal" data-id="` + product.productId + `"">
                                            <i class="bi bi-pencil" style="color: black;"></i>
                                        </button>
                                        <button class="action-button delete-btn" data-bs-toggle="modal" data-bs-target="#confirmationModal" data-id="` + product.productId + `"">
                                            <i class="bi bi-trash"></i>
                                        </button>
                                    </td>
                                </tr>
                                `;
                            $('#load-product').append(item);
                        });
                     },
                     error: function() {
                         console.log(response.status);
                     }
                });
        });
    });
    function formatMoney(number) {
      return number.toString().replace(/\B(?=(\d{3})+(?!\d))/g, ".");
    }
  </script>
  
  <script>
      
  function showToast() {
    var toastEl = document.getElementById('myToast');
    var toast = new bootstrap.Toast(toastEl);
    toast.show();
  }
          
            function navigateToCorrectPage() {
                const token = getCookie("token");
                if (token && isTokenValid(token)) {
                    const role = getUserRoleFromToken(token);
                    
                    switch (role) {
                        case "ADMIN":
                            $(".nav-account").attr("hidden", false);
                            break;
                        case "STAFF":
                            window.location.href = "order";
                            break;
                        case "MANAGER":
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
  $(document).ready(function() {
      navigateToCorrectPage();
  });
</script>
</body>
</html>
