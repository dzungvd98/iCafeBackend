package com.icafe.demo.repository;

import org.springframework.data.repository.CrudRepository;
import org.springframework.stereotype.Repository;

import com.icafe.demo.entity.RedisToken;

@Repository
public interface RedisTokenRepository extends CrudRepository<RedisToken, String>{
    
}
