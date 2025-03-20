package com.icafe.demo.repository;

import org.springframework.data.jpa.repository.JpaRepository;
import org.springframework.stereotype.Repository;

import com.icafe.demo.models.Unit;

@Repository
public interface IUnitRepository extends JpaRepository<Unit, Integer>{
    
}
