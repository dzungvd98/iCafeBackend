package com.icafe.demo.dto;

import java.math.BigDecimal;

import lombok.AllArgsConstructor;
import lombok.Data;

@Data
@AllArgsConstructor
public class TopSellingProductResponseDTO {
    private String productCode;
    private String productName;
    private Integer quantitySold;
    private BigDecimal productRevenue;
}
