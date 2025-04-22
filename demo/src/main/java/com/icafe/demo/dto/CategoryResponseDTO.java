package com.icafe.demo.dto;

import lombok.AllArgsConstructor;
import lombok.Data;

@AllArgsConstructor
@Data
public class CategoryResponseDTO {
    private Integer categoryId;
    private String categoryName;
    private String timeUpdated;
    private String updatedBy;
    private int numberProduct;
}
