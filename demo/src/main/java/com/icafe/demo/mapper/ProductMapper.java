package com.icafe.demo.mapper;
import org.modelmapper.ModelMapper;
import org.springframework.stereotype.Service;

import com.icafe.demo.dto.ProductCreateDTO;
import com.icafe.demo.enums.Status;
import com.icafe.demo.models.Category;
import com.icafe.demo.models.Product;

@Service
public class ProductMapper {
    private final ModelMapper modelMapper;

    public ProductMapper(ModelMapper modelMapper) {
        this.modelMapper = modelMapper;
    }

    public Product toEntity(ProductCreateDTO dto, Category category) {
        Product product = modelMapper.map(dto, Product.class);
        product.setCategory(category);
        product.setStatus(Status.AVAILABLE); // Gán status mặc định
        return product;
    }

    public ProductCreateDTO toDTO(Product product) {
        return modelMapper.map(product, ProductCreateDTO.class);
    }
    
   
}