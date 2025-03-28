package com.icafe.demo.service.ProductCategory;

import java.util.ArrayList;
import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import com.icafe.demo.dto.ProductRequestDTO;
import com.icafe.demo.dto.ProductVariantRequestDTO;
import com.icafe.demo.mapper.ProductMapper;
import com.icafe.demo.mapper.ProductVariantMapper;
import com.icafe.demo.models.Category;
import com.icafe.demo.models.Product;
import com.icafe.demo.models.ProductVariant;
import com.icafe.demo.models.Size;
import com.icafe.demo.repository.ICategoryRepository;
import com.icafe.demo.repository.IProductRepository;
import com.icafe.demo.repository.IProductVariantRepository;
import com.icafe.demo.repository.ISizeRepository;

@Service
public class ProductService implements IProductService{
    @Autowired
    private IProductRepository productRepository;

    @Autowired
    private ICategoryRepository categoryRepository;

    @Autowired
    private IProductVariantRepository productVariantRepository;

    @Autowired
    private ISizeRepository sizeRepository;

    @Autowired
    private ProductMapper productMapper;

    @Autowired
    private ProductVariantMapper productVariantMapper;

    public List<Product> getListProductByCategory(int categoryId) {
        return productRepository.findByCategoryId(categoryId);
    }

    @Transactional
    public Product createNewProduct(ProductRequestDTO request) {
        Category category = categoryRepository.findById(request.getCategoryId())
                .orElseThrow(() -> new RuntimeException("Category not found!"));
        Product product = productMapper.toEntity(request, category);

        List<ProductVariant> variants = new ArrayList<>();
        for(ProductVariantRequestDTO variantRequest : request.getProductVariants()) {
            ProductVariant variant = productVariantMapper.toEntity(variantRequest, product);
            Size size = sizeRepository.findBySizeName(variantRequest.getSize())
                .orElseGet(() -> sizeRepository.save(new Size(variantRequest.getSize())));
            variant.setSize(size);
            variants.add(variant);
        }
        product.setProductVariants(variants);
        return productRepository.save(product);
    }

    

    @Override
    public void deleteProductById(int productId) {
        productRepository.deleteById(productId);
    }

    @Transactional
    public Product updateProduct(int productId, ProductRequestDTO request) {
        Product product = productRepository.findById(productId)
            .orElseThrow(() -> new RuntimeException("Product not found!"));
        
        Category category = categoryRepository.findById(request.getCategoryId())
            .orElseThrow(() -> new RuntimeException("Category not found"));
    
        product.setProductCode(request.getProductCode());
        product.setCategory(category);
        product.setBasePrice(request.getBasePrice());
        product.setHaveType(request.getHaveType());
        product.setImageUrl(request.getImageUrl());
        product.setProductName(request.getProductName());

        productVariantRepository.deleteByProductId(productId);

        List<ProductVariant> variants = new ArrayList<>();
        for(ProductVariantRequestDTO variantRequest : request.getProductVariants()) {
            ProductVariant variant = productVariantMapper.toEntity(variantRequest, product);
            Size size = sizeRepository.findBySizeName(variantRequest.getSize())
                .orElseGet(() -> sizeRepository.save(new Size(variantRequest.getSize())));
            variant.setSize(size);
            variants.add(variant);
        }
        product.setProductVariants(variants);
        return productRepository.save(product);
    }

}
