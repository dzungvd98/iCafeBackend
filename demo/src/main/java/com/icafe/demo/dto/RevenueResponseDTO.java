package com.icafe.demo.dto;

import java.math.BigDecimal;

import lombok.Data;

@Data
public class RevenueResponseDTO {
    private String period;
    private BigDecimal revenue;
    private BigDecimal profit;

    public RevenueResponseDTO(String period, BigDecimal revenue, BigDecimal profit) {
        this.period = period;
        this.revenue = revenue;
        this.profit = profit;
    }
}
