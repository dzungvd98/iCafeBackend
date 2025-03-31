package com.icafe.demo.repository;

import java.util.List;

import org.springframework.data.jpa.repository.JpaRepository;
import org.springframework.stereotype.Repository;

import com.icafe.demo.models.ProductIngredient;

@Repository
public interface IProductIngredientRepository extends JpaRepository<ProductIngredient, Integer>{
    void deleteByProductId(int productId);
    List<ProductIngredient> findByProductId(int productId);
}
