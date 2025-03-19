package com.icafe.demo.repository;

import org.springframework.data.jpa.repository.JpaRepository;

import com.icafe.demo.models.User;

public interface IUserRepository extends JpaRepository<User, Integer>{
    User findByUsername(String username);
}
