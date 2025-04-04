package com.icafe.demo.dto;

import java.math.BigDecimal;

import lombok.AllArgsConstructor;
import lombok.Data;

@Data
@AllArgsConstructor
public class ProductResponseDTO {
    private Integer productId;
    private String productCode;
    private String productName;
    private String categoryName;
    private BigDecimal basePrice;
    private String listPrice;
    private Boolean isAvailable;
    private String urlImage;
    private String sizes;
}
