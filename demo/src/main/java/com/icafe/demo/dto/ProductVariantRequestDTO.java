package com.icafe.demo.dto;

import java.math.BigDecimal;


import lombok.Builder;
import lombok.Data;

@Data
@Builder
public class ProductVariantRequestDTO {
    private String size;
    private BigDecimal price;
}
