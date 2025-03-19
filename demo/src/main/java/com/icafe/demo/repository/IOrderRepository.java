package com.icafe.demo.repository;

import org.springframework.data.jpa.repository.JpaRepository;

import com.icafe.demo.models.Order;

public interface IOrderRepository extends JpaRepository<Order, Integer>{
    
}
