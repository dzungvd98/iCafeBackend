package com.icafe.demo.repository;

import org.springframework.data.jpa.repository.JpaRepository;

import com.icafe.demo.models.Type;

public interface ITypeRepository extends JpaRepository<Type, Integer>{
    
}
