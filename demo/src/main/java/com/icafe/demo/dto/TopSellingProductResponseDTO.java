package com.icafe.demo.dto;

import java.math.BigDecimal;

import com.icafe.demo.models.OrderProduct;

import lombok.AllArgsConstructor;
import lombok.Data;

@Data
@AllArgsConstructor
public class TopSellingProductResponseDTO {
    private String productCode;
    private String productName;
    private Long quantitySold;
    private BigDecimal productRevenue;
    
    public static TopSellingProductResponseDTO fromEntity(OrderProduct orderProduct) {
        return new TopSellingProductResponseDTO(
                orderProduct.getProduct().getProductCode(),
                orderProduct.getProduct().getProductName(),
                orderProduct.getQuantity().longValue(),  
                orderProduct.getPriceEach().multiply(new BigDecimal(orderProduct.getQuantity()))
        );
    }
        
            
}
