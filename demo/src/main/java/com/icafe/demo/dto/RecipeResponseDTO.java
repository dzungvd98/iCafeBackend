package com.icafe.demo.dto;

import lombok.Builder;
import lombok.Data;

@Data
@Builder
public class RecipeResponseDTO {
    private String ingredientName;
    private String unit;
    private Integer quantity;
}
