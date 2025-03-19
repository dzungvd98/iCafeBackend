package com.icafe.demo.repository;

import org.springframework.data.jpa.repository.JpaRepository;

import com.icafe.demo.models.OrderProduct;

public interface IOrderProductRepository extends JpaRepository<OrderProduct, Integer>{
    
}
