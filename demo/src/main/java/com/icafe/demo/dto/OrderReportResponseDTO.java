package com.icafe.demo.dto;

import lombok.Data;

@Data
public class OrderReportResponseDTO {
    private Long totalOrderQuantity;
    private Double avgOrderValue;
    private Double revenue;
    private Double profit;
}
