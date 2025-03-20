package com.icafe.demo.repository;

import org.springframework.data.jpa.repository.JpaRepository;
import org.springframework.stereotype.Repository;

import com.icafe.demo.models.Type;

@Repository
public interface ITypeRepository extends JpaRepository<Type, Integer>{
    
}
