package com.icafe.demo.service.ProductCategory;

import java.util.ArrayList;
import java.util.List;
import java.util.stream.Collectors;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.data.domain.Page;
import org.springframework.data.domain.PageImpl;
import org.springframework.data.domain.PageRequest;
import org.springframework.data.domain.Pageable;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import com.icafe.demo.dto.ProductRequestDTO;
import com.icafe.demo.dto.ProductResponseDTO;
import com.icafe.demo.dto.ProductVariantRequestDTO;
import com.icafe.demo.enums.Status;
import com.icafe.demo.mapper.ProductMapper;
import com.icafe.demo.mapper.ProductVariantMapper;
import com.icafe.demo.models.Category;
import com.icafe.demo.models.Product;
import com.icafe.demo.models.ProductVariant;
import com.icafe.demo.models.Size;
import com.icafe.demo.models.Warehouse;
import com.icafe.demo.repository.ICategoryRepository;
import com.icafe.demo.repository.IProductRepository;
import com.icafe.demo.repository.IProductVariantRepository;
import com.icafe.demo.repository.ISizeRepository;
import com.icafe.demo.repository.IWarehouseRepository;

import jakarta.persistence.EntityNotFoundException;

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
    private IWarehouseRepository warehouseRepository;

    @Autowired
    private ProductMapper productMapper;

    @Autowired
    private ProductVariantMapper productVariantMapper;

    @Override
    public Page<ProductResponseDTO> getAllProducts(int page, int size) {
        Pageable pageable = PageRequest.of(page, size);
        Page<Product> productPage = productRepository.findAll(pageable);
        List<ProductResponseDTO> productResponseDTOs = productPage.getContent()
            .stream()
            .map(product -> new ProductResponseDTO(
                product.getProductCode(),
                product.getProductName(),
                product.getCategory().getCategoryName(),
                product.getBasePrice(),
                product.getStatus().equals(Status.AVAILABLE) ? true : false
            )).collect(Collectors.toList());
        
        return new PageImpl<>(productResponseDTOs, pageable, productPage.getTotalElements());
    }

    public List<Product> getListProductByCategory(int categoryId) {
        return productRepository.findByCategoryIdAndStatusAndDeleted(categoryId, Status.AVAILABLE, false);
    }

    @Transactional
    public Product createNewProduct(ProductRequestDTO request) {
        Category category = categoryRepository.findById(request.getCategoryId())
                .orElseThrow(() -> new EntityNotFoundException("Category not found!"));
        Product product = productMapper.toEntity(request, category);

        List<ProductVariant> variants = new ArrayList<>();
        for(ProductVariantRequestDTO variantRequest : request.getProductVariants()) {
            ProductVariant variant = productVariantMapper.toEntity(variantRequest, product);
            Size size = sizeRepository.findBySizeName(variantRequest.getSize())
                .orElseGet(() -> sizeRepository.save(new Size(variantRequest.getSize())));
            variant.setSize(size);
            variants.add(variant);
        }
        
        if(request.getIsDirectSale()) {
            Warehouse warehouse = new Warehouse();
            warehouse.setName(product.getProductName());
            warehouse.setIsDirectSale(true);
            warehouse.setMinQuantity(request.getItem().getMinQuantity());
            warehouse.setQuantity(0);
            warehouse.setUnit(request.getItem().getUnit());

            warehouse = warehouseRepository.save(warehouse);
            product.setWarehouse(warehouse);
            product.setIsDirectSale(true);
        }


        product.setProductVariants(variants);
        return productRepository.save(product);
    }

    @Transactional
    public Product updateProduct(int productId, ProductRequestDTO request) {
        Product product = productRepository.findById(productId)
            .orElseThrow(() -> new EntityNotFoundException("Product not found!"));
        
        Category category = categoryRepository.findById(request.getCategoryId())
            .orElseThrow(() -> new EntityNotFoundException("Category not found"));
    
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

        if(product.getIsDirectSale()) {
            Warehouse warehouse = product.getWarehouse();
            warehouse.setName(request.getProductName());
            warehouse.setUnit(request.getItem().getUnit());
            warehouse.setMinQuantity(request.getItem().getMinQuantity());
        }
        
        product.setProductVariants(variants);
        return productRepository.save(product);
    }

    @Override
    public void deleteProductById(int productId) {
        Product product = productRepository.findById(productId)
            .orElseThrow(() -> new EntityNotFoundException("Product not found!"));
        
        product.setDeleted(true);
        productRepository.save(product);
    }

    

    @Override
    public void recoverDeletedProduct(int productId) {
        Product product = productRepository.findById(productId)
            .orElseThrow(() -> new EntityNotFoundException("Product not found!"));
        
        product.setDeleted(false);
        productRepository.save(product);
    }

    @Override
    public void changeProductStatus(int productId, Status status) {
        Product product = productRepository.findById(productId)
            .orElseThrow(() -> new EntityNotFoundException("Product not found!"));
        product.setStatus(status);
        productRepository.save(product);
    }

}
