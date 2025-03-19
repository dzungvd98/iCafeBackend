package com.icafe.demo.repository;

import org.springframework.data.jpa.repository.JpaRepository;

import com.icafe.demo.models.ProductVariant;

public interface IProductVariantRepository extends JpaRepository<ProductVariant, Integer>{
    
}
