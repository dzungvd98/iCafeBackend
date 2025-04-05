package com.icafe.demo.service.ProductService;

import java.io.IOException;
import java.util.List;

import org.springframework.web.multipart.MultipartFile;

import com.icafe.demo.dto.PagingDataDTO;
import com.icafe.demo.dto.ProductDetailResponseDTO;
import com.icafe.demo.dto.ProductRequestDTO;
import com.icafe.demo.dto.ProductResponseDTO;
import com.icafe.demo.enums.Status;
import com.icafe.demo.models.Product;

public interface IProductService {
    List<Product> getListProductByCategory(int categoryId);
    PagingDataDTO<ProductResponseDTO> getProducts(String keyword, int page, int size);
    Product createNewProduct(ProductRequestDTO request, MultipartFile image) throws IOException;
    Product updateProduct(int productId, ProductRequestDTO request, MultipartFile image) throws IOException ;
    ProductDetailResponseDTO getProductDetail(int productId);

    void deleteProductById(int productId);
    void recoverDeletedProduct(int productId);
    void changeProductStatus(int productId, Status status);
}
