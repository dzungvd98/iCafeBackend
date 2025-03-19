package com.icafe.demo.repository;

import org.springframework.data.jpa.repository.JpaRepository;

import com.icafe.demo.entity.Token;

public interface ITokenRepository extends JpaRepository<Token, Integer>{
    Token findByToken(String token);
}
