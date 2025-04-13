package com.icafe.demo.dto;

import java.math.BigDecimal;

import lombok.Builder;
import lombok.Data;

@Data
@Builder
public class OrderProductResponseDTO {
    private Integer productVariantId;
    private String productName;
    private String size;
    private String percentIce;
    private String percentSugar;
    private String productImgUrl;
    private Integer quantity;
    private BigDecimal priceEach;
}
