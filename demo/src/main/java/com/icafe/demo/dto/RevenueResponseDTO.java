package com.icafe.demo.dto;

import java.math.BigDecimal;

import lombok.Data;

@Data
public class RevenueResponseDTO {
    private String period;
    private BigDecimal revenue;
    public RevenueResponseDTO(String period, BigDecimal revenue) {
        this.period = period;
        this.revenue = revenue;
    }

    
}
