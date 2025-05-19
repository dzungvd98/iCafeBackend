package com.icafe.demo.dto;

import lombok.Builder;
import lombok.Getter;
import lombok.Setter;

@Getter
@Setter
@Builder
public class UserLoginResponse {
    private String accessToken;
    private String refreshToken;
    private Long expiresIn;
    private UserSummary user;
    
    @Getter
    @Setter
    @Builder
    public static class UserSummary {
        private String username;
        private String email;
        private String role;
    }
}
