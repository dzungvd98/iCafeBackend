package com.icafe.demo.dto;

import java.math.BigDecimal;

import lombok.Data;

@Data
public class ProductVariantResponseDTO {
    private String sizeName;
    private BigDecimal basePrice;

    public ProductVariantResponseDTO(String sizeName, BigDecimal basePrice) {
        this.sizeName = sizeName;
        this.basePrice = basePrice;
    }
}
