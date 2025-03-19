package com.icafe.demo.repository;

import org.springframework.data.jpa.repository.JpaRepository;

import com.icafe.demo.models.Product;

public interface IProductRepository extends JpaRepository<Product, Integer>{
    
}
