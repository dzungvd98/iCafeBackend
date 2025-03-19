package com.icafe.demo.repository;

import org.springframework.data.jpa.repository.JpaRepository;

import com.icafe.demo.models.Size;

public interface ISizeRepository extends JpaRepository<Size, Integer>{
    
}
