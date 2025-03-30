package com.icafe.demo.repository;

import org.springframework.data.jpa.repository.JpaRepository;

import com.icafe.demo.models.ProductIngredient;

public interface IProductIngredientRepository extends JpaRepository<Integer, ProductIngredient>{
    
}
