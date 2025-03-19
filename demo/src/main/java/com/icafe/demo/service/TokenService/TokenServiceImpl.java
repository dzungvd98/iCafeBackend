package com.icafe.demo.service.TokenService;

import org.springframework.beans.factory.annotation.Autowired;

import com.icafe.demo.entity.Token;
import com.icafe.demo.repository.ITokenRepository;

public class TokenServiceImpl implements ITokenService{

    @Autowired
    private ITokenRepository tokenRepository;

    public Token createToken(Token token) {
        return tokenRepository.saveAndFlush(token);
    }

    @Override
    public Token findByToken(String token) {
        return tokenRepository.findByToken(token);
    }
    
}
