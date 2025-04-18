package com.icafe.demo.repository;

import java.util.Optional;

import org.springframework.data.jpa.repository.JpaRepository;
import org.springframework.stereotype.Repository;

import com.icafe.demo.models.Warehouse;


@Repository
public interface IWarehouseRepository extends JpaRepository<Warehouse, Integer>{
    Optional<Warehouse> findByName(String name);
}
