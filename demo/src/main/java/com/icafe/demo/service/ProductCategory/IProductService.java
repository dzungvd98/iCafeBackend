package com.icafe.demo.service.ProductCategory;

import java.util.List;

import com.icafe.demo.dto.ProductRequestDTO;
import com.icafe.demo.enums.Status;
import com.icafe.demo.models.Product;

public interface IProductService {
    List<Product> getListProductByCategory(int categoryId);
    List<Product> getAllProducts();
    Product createNewProduct(ProductRequestDTO request);
    Product updateProduct(int productId, ProductRequestDTO request);
    void deleteProductById(int productId);
    void recoverDeletedProduct(int productId);
    void changeProductStatus(int productId, Status status);
}
