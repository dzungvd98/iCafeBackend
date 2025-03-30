package com.icafe.demo.repository;

import org.springframework.data.jpa.repository.JpaRepository;
import org.springframework.stereotype.Repository;

import com.icafe.demo.models.WarehouseTransaction;

@Repository
public interface IWarehouseTransactionRepository extends JpaRepository<WarehouseTransaction, Integer>{

    
} 
