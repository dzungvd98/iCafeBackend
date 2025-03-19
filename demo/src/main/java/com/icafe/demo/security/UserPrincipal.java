package com.icafe.demo.security;

import org.springframework.security.core.userdetails.UserDetails;

import lombok.Getter;
import lombok.NoArgsConstructor;
import lombok.Setter;

import java.util.Collection;

@Getter
@Setter
@NoArgsConstructor
public class UserPrincipal implements UserDetails {
    private Integer userId;
    private String username;
    private String password;
    private Collection authorities;
	private String secretQuestion;
}
