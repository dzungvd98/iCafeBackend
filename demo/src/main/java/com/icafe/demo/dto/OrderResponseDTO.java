package com.icafe.demo.dto;

import java.util.List;

import lombok.Data;

@Data
public class OrderResponseDTO {

    private String productCode;
    private List<String> productNameOrder;
    private String timeCreated;
    private String price;
    private String status;
    
    public OrderResponseDTO(String productCode, List<String> productNameOrder, String timeCreated, String price,
            String status) {
        this.productCode = productCode;
        this.productNameOrder = productNameOrder;
        this.timeCreated = timeCreated;
        this.price = price;
        this.status = status;
    }

    
}
