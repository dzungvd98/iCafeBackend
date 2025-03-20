package com.icafe.demo.repository;

import org.springframework.data.jpa.repository.JpaRepository;
import org.springframework.stereotype.Repository;

import com.icafe.demo.models.OrderStatus;

@Repository
public interface IOrderStatusRepository extends JpaRepository<OrderStatus, Integer>{
    
}
