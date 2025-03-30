package com.icafe.demo.repository;

import org.springframework.data.jpa.repository.JpaRepository;

import com.icafe.demo.models.Warehouse;

public interface IWarehouseRepository extends JpaRepository<Integer, Warehouse>{
    
}
