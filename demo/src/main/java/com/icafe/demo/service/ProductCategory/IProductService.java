package com.icafe.demo.service.ProductCategory;

import java.util.List;

import com.icafe.demo.dto.ProductCreateDTO;
import com.icafe.demo.models.Product;

public interface IProductService {
    List<Product> getListProductByCategory(int categoryId);
    public ProductCreateDTO createNewProduct(ProductCreateDTO newProduct);
}
