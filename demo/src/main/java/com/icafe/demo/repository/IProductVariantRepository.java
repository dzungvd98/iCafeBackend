package com.icafe.demo.repository;

import org.springframework.data.jpa.repository.JpaRepository;
import org.springframework.stereotype.Repository;

import com.icafe.demo.models.ProductVariant;

@Repository
public interface IProductVariantRepository extends JpaRepository<ProductVariant, Integer>{
    ProductVariant findByProductIdAndSizeSizeName(int productId, String sizeName);
}
