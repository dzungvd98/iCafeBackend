package com.icafe.demo.dto;

import java.io.Serializable;

import lombok.Builder;
import lombok.Getter;

@Getter
@Builder
public class TokenResponse implements Serializable{
    private String accessToken;
    private String refreshToken;
    private Integer userId;
}
