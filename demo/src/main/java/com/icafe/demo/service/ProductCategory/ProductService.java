package com.icafe.demo.service.ProductCategory;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.icafe.demo.dto.ProductCreateDTO;
import com.icafe.demo.mapper.ProductMapper;
import com.icafe.demo.models.Category;
import com.icafe.demo.models.Product;
import com.icafe.demo.repository.ICategoryRepository;
import com.icafe.demo.repository.IProductRepository;

@Service
public class ProductService implements IProductService{
    @Autowired
    private IProductRepository productRepository;

    @Autowired
    private ICategoryRepository categoryRepository;

    private ProductMapper productMapper;

    public List<Product> getListProductByCategory(int categoryId) {
        return productRepository.findByCategoryId(categoryId);
    }

    public ProductCreateDTO createNewProduct(ProductCreateDTO newProduct) {
        Category category = categoryRepository.findById(newProduct.getCategoryId())
                .orElseThrow(() -> new RuntimeException("Category not found!"));
        Product product = productMapper.toEntity(newProduct, category);
        product = productRepository.save(product);
        return productMapper.toDTO(product);
    }

}
