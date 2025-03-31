package com.icafe.demo.service.ProductIngredientService;

import java.util.ArrayList;
import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import com.icafe.demo.dto.ProductIngredientRequestDTO;
import com.icafe.demo.dto.RecipeResponseDTO;
import com.icafe.demo.models.Product;
import com.icafe.demo.models.ProductIngredient;
import com.icafe.demo.models.Warehouse;
import com.icafe.demo.repository.IProductIngredientRepository;
import com.icafe.demo.repository.IProductRepository;
import com.icafe.demo.repository.IWarehouseRepository;

import jakarta.persistence.EntityNotFoundException;

@Service
public class ProductIngredientService implements IProductIngredientService{

    @Autowired
    private IProductIngredientRepository productIngredientRepository;

    @Autowired
    private IWarehouseRepository warehouseRepository;

    @Autowired
    private IProductRepository productRepository;
    
    @Transactional
    public List<ProductIngredient> createNewProductIngredients(int productId, List<ProductIngredientRequestDTO> productIngredientRequestList) {
        Product product = productRepository.findById(productId)
            .orElseThrow(() -> new EntityNotFoundException("Not found product with id " + productId));

        List<ProductIngredient> result = new ArrayList<>();
        for(ProductIngredientRequestDTO productIngredient : productIngredientRequestList) {
            Warehouse item = warehouseRepository.findById(productIngredient.getIngredientId())
            .orElseThrow(() -> new EntityNotFoundException("Not found item with id " + productIngredient.getIngredientId()));

            ProductIngredient newProductIngredient = new ProductIngredient();
            newProductIngredient.setIngredient(item);
            newProductIngredient.setProduct(product);
            newProductIngredient.setQuantity(productIngredient.getQuantity());
            result.add(productIngredientRepository.save(newProductIngredient));
        }
        
        return result;
    }

    @Transactional
    public List<ProductIngredient> updateProductIngredients(int productId, List<ProductIngredientRequestDTO> productIngredientRequestList) {
        Product product = productRepository.findById(productId)
            .orElseThrow(() -> new EntityNotFoundException("Not found product with id " + productId));
        
        productIngredientRepository.deleteByProductId(productId);

        List<ProductIngredient> result = new ArrayList<>();
        for(ProductIngredientRequestDTO productIngredient : productIngredientRequestList) {
            Warehouse item = warehouseRepository.findById(productIngredient.getIngredientId())
            .orElseThrow(() -> new EntityNotFoundException("Not found item with id " + productIngredient.getIngredientId()));

            ProductIngredient newProductIngredient = new ProductIngredient();
            newProductIngredient.setIngredient(item);
            newProductIngredient.setProduct(product);
            newProductIngredient.setQuantity(productIngredient.getQuantity());
            result.add(productIngredientRepository.save(newProductIngredient));
        }
        
        return result;
    }

    public void deleteProductIngredientsOfProductId(int productId) {
        productIngredientRepository.deleteByProductId(productId);
    }

    public List<RecipeResponseDTO> getAllIngredientsOfProduct(int productId) {
        List<ProductIngredient> ingredients = productIngredientRepository.findByProductId(productId);
        List<RecipeResponseDTO> result = new ArrayList<>();
        for(ProductIngredient ingredient : ingredients) {
            Warehouse item = ingredient.getIngredient();
            RecipeResponseDTO recipe = RecipeResponseDTO.builder()
                                            .ingredientName(item.getName())
                                            .unit(item.getUnit())
                                            .quantity(ingredient
                                            .getQuantity()).build();
            result.add(recipe);
        }
        return result;
    }


    
}
