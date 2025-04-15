package com.icafe.demo.service.TokenService;

import com.icafe.demo.entity.Token;

public interface ITokenService {
    Token createToken(Token token);
    Token findByToken(String token);
    void deleteToken(String token);
    void deleteUserToken(Integer userId);
} 
