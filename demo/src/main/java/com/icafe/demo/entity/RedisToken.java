package com.icafe.demo.entity;

import java.io.Serializable;

import org.springframework.data.redis.core.RedisHash;

import lombok.Builder;
import lombok.Getter;
import lombok.Setter;

@Setter
@Getter
@Builder
@RedisHash("RedisToken")
public class RedisToken implements Serializable{
    private String id;
    private String accessToken;
    private String refreshToken;
    private String resetToken;
}
