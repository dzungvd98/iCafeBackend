package com.icafe.demo.repository;

import org.springframework.data.jpa.repository.JpaRepository;
import org.springframework.stereotype.Repository;

import com.icafe.demo.models.ProductIngredient;

@Repository
public interface IProductIngredientRepository extends JpaRepository<ProductIngredient, Integer>{
    
}
