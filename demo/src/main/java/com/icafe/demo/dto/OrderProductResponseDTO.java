package com.icafe.demo.dto;

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
    private String quantity;
    private String priceEach;
}
