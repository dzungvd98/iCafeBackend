package com.icafe.demo.repository;

import java.util.List;
import java.util.Optional;

import org.springframework.data.jpa.repository.JpaRepository;
import org.springframework.stereotype.Repository;

import com.icafe.demo.models.Product;

@Repository
public interface IProductRepository extends JpaRepository<Product, Integer>{
    List<Product> findByCategoryId(int categoryId);
    Optional<Product> findByProductCode(String productCode);
}
