package com.icafe.demo.dto;

import java.io.Serializable;

import com.icafe.demo.util.Platform;

import jakarta.validation.constraints.NotBlank;
import jakarta.validation.constraints.NotNull;
import lombok.Getter;

@Getter
public class SignInRequest implements Serializable{
    @NotBlank(message = "username must be not null")
    private String username;

    @NotBlank(message = "username must be not blank")
    private String password;

    @NotNull(message = "platform must be not null")
    private Platform platform;

    private String deviceToken;

    private String version;
}
