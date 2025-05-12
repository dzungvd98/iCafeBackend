package com.icafe.demo.service.RedisTokenService;

import org.springframework.stereotype.Service;

import com.icafe.demo.entity.RedisToken;
import com.icafe.demo.repository.RedisTokenRepository;

import lombok.RequiredArgsConstructor;

@Service
@RequiredArgsConstructor
public class RedisTokenService {

    private final RedisTokenRepository redisTokenRepository;
    
    public String save(RedisToken token) {
        RedisToken result =  redisTokenRepository.save(token);
        return result.getId();
    }

    public void remove(String id) {
        isExists(id);
        redisTokenRepository.deleteById(id);
    }

    public boolean isExists(String id) {
        if (!redisTokenRepository.existsById(id)) {
            throw new RuntimeException("Token not exists");
        }
        return true;
    }

    public RedisToken getById(String id) {
        return redisTokenRepository.findById(id).orElseThrow(
            () -> new RuntimeException("Redis token not found!")
        );
    }
    
}
