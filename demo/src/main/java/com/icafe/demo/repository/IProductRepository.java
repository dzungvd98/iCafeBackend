package com.icafe.demo.repository;

import org.springframework.data.jpa.repository.JpaRepository;
import org.springframework.stereotype.Repository;

import com.icafe.demo.models.Product;

@Repository
public interface IProductRepository extends JpaRepository<Product, Integer>{
    
}
