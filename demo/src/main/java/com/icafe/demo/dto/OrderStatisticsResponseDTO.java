package com.icafe.demo.dto;


import lombok.Data;

@Data
public class OrderStatisticsResponseDTO {
    private long totalOrder;
    private long successfullOrder;
    private long cancelledOrder;
    private Double averageOrderValue;
}
