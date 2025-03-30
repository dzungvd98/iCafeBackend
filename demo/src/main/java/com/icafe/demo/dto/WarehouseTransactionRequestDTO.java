package com.icafe.demo.dto;

import java.math.BigDecimal;

import com.icafe.demo.enums.TransactionType;

import lombok.Builder;
import lombok.Data;

@Data
@Builder
public class WarehouseTransactionRequestDTO {
    private Integer wareHouseId;
    private Integer quantity;
    private TransactionType type;
    private Integer timeUse;
    private BigDecimal totalPrice;
}
