package com.icafe.demo.repository;

import org.springframework.data.jpa.repository.JpaRepository;
import org.springframework.stereotype.Repository;

import com.icafe.demo.models.Order;

@Repository
public interface IOrderRepository extends JpaRepository<Order, Integer>{
    
}
