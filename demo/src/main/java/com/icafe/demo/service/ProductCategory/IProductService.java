package com.icafe.demo.service.ProductCategory;

import java.util.List;

import com.icafe.demo.dto.ProductRequestDTO;
import com.icafe.demo.models.Product;

public interface IProductService {
    List<Product> getListProductByCategory(int categoryId);
    Product createNewProduct(ProductRequestDTO request);
    Product updateProduct(int productId, ProductRequestDTO request);
    void deleteProductById(int productId);

}
