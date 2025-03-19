package com.icafe.demo.repository;

import org.springframework.data.jpa.repository.JpaRepository;

import com.icafe.demo.models.OrderStatus;

public interface IOrderStatusRepository extends JpaRepository<OrderStatus, Integer>{
    
}
