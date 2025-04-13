package com.icafe.demo.service.TokenService;

import java.util.Date;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.icafe.demo.entity.Token;
import com.icafe.demo.repository.ITokenRepository;

@Service
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

    @Override
    public void deleteToken(String tokenStr) {
        Token token = tokenRepository.findByToken(tokenStr);
        token.setDeleted(true);
        token.setTokenExpDate(new Date(System.currentTimeMillis()));
        tokenRepository.save(token);
    }
    
}
