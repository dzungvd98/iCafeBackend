package com.icafe.demo.repository;

import org.springframework.data.jpa.repository.JpaRepository;
import org.springframework.stereotype.Repository;

import com.icafe.demo.entity.Token;

@Repository
public interface ITokenRepository extends JpaRepository<Token, Integer>{
    Token findByToken(String token);
}
