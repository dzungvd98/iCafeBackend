package com.icafe.demo.dto;

import java.math.BigDecimal;
import java.util.List;

import lombok.Builder;
import lombok.Data;

@Data
@Builder
public class ProductRequestDTO {
    private String productCode;
    private String productName;
    private String imageUrl;
    private BigDecimal basePrice;
    private Integer categoryId;
    private Boolean haveType;
    private List<ProductVariantRequestDTO> productVariants;
}   
