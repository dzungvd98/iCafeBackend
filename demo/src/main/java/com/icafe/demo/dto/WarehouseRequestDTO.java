package com.icafe.demo.dto;

import lombok.Builder;
import lombok.Data;

@Data
@Builder
public class WarehouseRequestDTO {
    private String name;
    private String unit;
    private Integer minQuantity;
}
