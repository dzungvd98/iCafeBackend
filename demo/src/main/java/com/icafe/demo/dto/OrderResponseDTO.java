package com.icafe.demo.dto;

import java.math.BigDecimal;
import java.util.List;

import lombok.Data;

@Data
public class OrderResponseDTO {

    private String orderCode;
    private List<OrderProductResponseDTO> orderProducts;
    private String timeCreated;
    private BigDecimal price;
    private String status;
    
    public OrderResponseDTO(String orderCode, List<OrderProductResponseDTO> orderProducts, String timeCreated, 
                          BigDecimal price, String status) {
        this.orderCode = orderCode;
        this.orderProducts = orderProducts;
        this.timeCreated = timeCreated;
        this.price = price;
        this.status = status;
    }

    
}
