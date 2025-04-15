package com.icafe.demo.repository;

import org.springframework.data.jpa.repository.JpaRepository;
import org.springframework.data.jpa.repository.Modifying;
import org.springframework.data.jpa.repository.Query;
import org.springframework.data.repository.query.Param;
import org.springframework.stereotype.Repository;

import com.icafe.demo.entity.Token;

@Repository
public interface ITokenRepository extends JpaRepository<Token, Integer>{
    Token findByToken(String token);

    @Modifying
    @Query("UPDATE Token t SET t.deleted = true WHERE t.createdBy = :userId")
    void softDeleteActiveTokenByUser(@Param("userId") Integer userId);
}
