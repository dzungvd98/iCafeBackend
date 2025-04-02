package com.icafe.demo.service.ProductCategory;

import java.util.List;

import org.springframework.data.domain.Page;

import com.icafe.demo.dto.ProductRequestDTO;
import com.icafe.demo.dto.ProductResponseDTO;
import com.icafe.demo.enums.Status;
import com.icafe.demo.models.Product;

public interface IProductService {
    List<Product> getListProductByCategory(int categoryId);
    Page<ProductResponseDTO> getAllProducts(int page, int size);
    Product createNewProduct(ProductRequestDTO request);
    Product updateProduct(int productId, ProductRequestDTO request);
    void deleteProductById(int productId);
    void recoverDeletedProduct(int productId);
    void changeProductStatus(int productId, Status status);
}
