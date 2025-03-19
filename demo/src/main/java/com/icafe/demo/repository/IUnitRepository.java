package com.icafe.demo.repository;

import org.springframework.data.jpa.repository.JpaRepository;

import com.icafe.demo.models.Unit;

public interface IUnitRepository extends JpaRepository<Unit, Integer>{
    
}
