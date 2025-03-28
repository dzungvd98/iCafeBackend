package com.icafe.demo.mapper;
import org.modelmapper.ModelMapper;
import org.springframework.stereotype.Service;

import com.icafe.demo.dto.ProductRequestDTO;
import com.icafe.demo.enums.Status;
import com.icafe.demo.models.Category;
import com.icafe.demo.models.Product;

@Service
public class ProductMapper {
    private final ModelMapper modelMapper;

    public ProductMapper(ModelMapper modelMapper) {
        this.modelMapper = modelMapper;
    }

    public Product toEntity(ProductRequestDTO dto, Category category) {
        Product product = modelMapper.map(dto, Product.class);
        product.setId(null);
        product.setCategory(category);
        product.setStatus(Status.AVAILABLE); // Gán status mặc định
        return product;
    }

    public ProductRequestDTO toDTO(Product product) {
        return modelMapper.map(product, ProductRequestDTO.class);
    }
    
}