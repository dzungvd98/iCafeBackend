package com.icafe.demo.dto;

import lombok.Builder;
import lombok.Data;

@Data
@Builder
public class ProductIngredientRequestDTO {
    private Integer ingredientId;
    private Integer quantity;
}
