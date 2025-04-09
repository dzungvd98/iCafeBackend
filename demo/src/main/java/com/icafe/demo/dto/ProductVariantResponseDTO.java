package com.icafe.demo.dto;

import java.math.BigDecimal;

import lombok.Data;

@Data
public class ProductVariantResponseDTO {
    private Integer variantId;
    private String sizeName;
    private BigDecimal price;
    
    public ProductVariantResponseDTO(Integer variantId, String sizeName, BigDecimal price) {
        this.variantId = variantId;
        this.sizeName = sizeName;
        this.price = price;
    }

    
}
