package com.icafe.demo.repository;

import org.springframework.data.jpa.repository.JpaRepository;

import com.icafe.demo.models.Role;

public interface IRoleRepository extends JpaRepository<Role, Integer>{
    
}
