package com.icafe.demo.repository;

import org.springframework.data.jpa.repository.JpaRepository;

import com.icafe.demo.models.Import;

public interface IImportRepository extends JpaRepository<Import, Integer>{
    
}
