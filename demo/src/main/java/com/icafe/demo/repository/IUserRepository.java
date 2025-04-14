package com.icafe.demo.repository;


import org.springframework.data.jpa.repository.JpaRepository;
import org.springframework.data.jpa.repository.JpaSpecificationExecutor;
import org.springframework.stereotype.Repository;

import com.icafe.demo.models.User;

@Repository
public interface IUserRepository extends JpaRepository<User, Integer>, JpaSpecificationExecutor<User>{
    User findByUsername(String username);
}
