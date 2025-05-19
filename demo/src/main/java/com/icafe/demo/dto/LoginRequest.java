package com.icafe.demo.dto;


import jakarta.validation.constraints.NotBlank;
import lombok.Getter;
import lombok.Setter;

@Getter
@Setter
public class LoginRequest {
    @NotBlank
    private String username;

    @NotBlank
    private String password;

    private boolean rememberMe = false;
    private DeviceInfo deviceInfo;

    @Getter
    @Setter
    public static class DeviceInfo {
        private String deviceCode;
        private String deviceType;
        private String ipAddress;
        private String userAgent;
    }
}
