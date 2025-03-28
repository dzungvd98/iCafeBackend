package com.icafe.demo.mapper;

import org.modelmapper.ModelMapper;
import org.springframework.stereotype.Service;

import com.icafe.demo.dto.ProductVariantRequestDTO;
import com.icafe.demo.models.Product;
import com.icafe.demo.models.ProductVariant;

@Service
public class ProductVariantMapper {
    private final ModelMapper modelMapper;

    public ProductVariantMapper(ModelMapper modelMapper) {
        this.modelMapper = modelMapper;
    }

    public ProductVariant toEntity(ProductVariantRequestDTO productVariantRequestDTO, Product product) {
        ProductVariant productVariant = modelMapper.map(productVariantRequestDTO, ProductVariant.class);
        productVariant.setProduct(product);
        return productVariant;
    }

    public ProductVariantRequestDTO toDTO(ProductVariant productVariant) {
        return modelMapper.map(productVariant, ProductVariantRequestDTO.class);
    }
}
