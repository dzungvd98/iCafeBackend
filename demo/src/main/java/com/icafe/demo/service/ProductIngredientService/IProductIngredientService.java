package com.icafe.demo.service.ProductIngredientService;

import java.util.List;

import com.icafe.demo.dto.ProductIngredientRequestDTO;
import com.icafe.demo.dto.RecipeResponseDTO;
import com.icafe.demo.models.ProductIngredient;

public interface IProductIngredientService {
    List<RecipeResponseDTO> getAllIngredientsOfProduct(int productId);
    List<ProductIngredient> createNewProductIngredients(int productId, List<ProductIngredientRequestDTO> productIngredientRequestList);
    List<ProductIngredient> updateProductIngredients(int productId, List<ProductIngredientRequestDTO> productIngredientRequestList);
    void deleteProductIngredientsOfProductId(int productId);
}
