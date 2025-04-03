package com.icafe.demo.dto;

import java.math.BigDecimal;
import java.util.List;

import lombok.Builder;
import lombok.Data;

@Data
@Builder
public class ProductDetailResponseDTO {
    private Integer productId;
    private String productCode;
    private String productName;
    private Boolean haveType;
    private String urlImage;
    private Integer categoryId;
    private String categoryName;
    private BigDecimal basePrice;
    private Boolean isAvailable;
    private Boolean isDirectSale;
    List<ProductVariantResponseDTO> variants;
}
