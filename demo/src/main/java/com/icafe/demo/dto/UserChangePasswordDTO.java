package com.icafe.demo.dto;


import lombok.Getter;
import lombok.Setter;

@Getter
@Setter
public class UserChangePasswordDTO {
    private String username;
    private String oldPassword;
    private String newPassword;
}
