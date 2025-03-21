package com.icafe.demo.security;

import org.springframework.security.core.GrantedAuthority;
import org.springframework.security.core.userdetails.UserDetails;

import lombok.Getter;
import lombok.NoArgsConstructor;
import lombok.Setter;

import java.util.Collection;
import java.util.Collections;

@Getter
@Setter
@NoArgsConstructor
public class UserPrincipal implements UserDetails {
    private Integer userId;
    private String username;
    private String password;
    private String role;
    private String email;
    private boolean deleted;

    @Override
    public Collection<? extends GrantedAuthority> getAuthorities() {
        return Collections.singletonList(() -> "ROLE_" + role); // Trả về role duy nhất
    }

}
