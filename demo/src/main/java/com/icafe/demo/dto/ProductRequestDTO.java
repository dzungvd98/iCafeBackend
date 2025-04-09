package com.icafe.demo.dto;

import java.math.BigDecimal;
import java.util.List;

import lombok.Builder;
import lombok.Data;

@Data
@Builder
public class ProductRequestDTO {
    private String productName;
    private BigDecimal basePrice;
    private Integer categoryId;
    private Integer haveType;
    private List<ProductVariantRequestDTO> productVariants;
    private Boolean isDirectSale;
    @Builder.Default
    private boolean isAvailable = true;
    // private WarehouseRequestDTO item;

}   
