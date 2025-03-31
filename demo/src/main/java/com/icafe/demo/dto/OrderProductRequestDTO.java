package com.icafe.demo.dto;

import com.icafe.demo.enums.ProductType;

import lombok.Builder;
import lombok.Data;

@Data
@Builder
public class OrderProductRequestDTO {
    private Integer id;
    private Integer productVariantId;
    private Integer quantity;
    private ProductType type;
}
