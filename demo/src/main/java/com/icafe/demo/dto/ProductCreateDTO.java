package com.icafe.demo.dto;

import java.math.BigDecimal;

import lombok.Getter;
import lombok.Setter;

@Getter
@Setter
public class ProductCreateDTO {
    private String productCode;
    private String productName;
    private String imageUrl;
    private BigDecimal price;
    private Integer categoryId;
}
