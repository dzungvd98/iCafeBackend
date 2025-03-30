package com.icafe.demo.repository;

import org.springframework.data.jpa.repository.JpaRepository;

import com.icafe.demo.models.WarehouseTransaction;

public interface IWarehouseTransactionRepository extends JpaRepository<Integer, WarehouseTransaction>{

    
} 
