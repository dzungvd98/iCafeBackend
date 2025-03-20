package com.icafe.demo.config;

import java.util.Optional;

import org.springframework.data.domain.AuditorAware;
import org.springframework.security.core.Authentication;
import org.springframework.security.core.context.SecurityContextHolder;
import org.springframework.stereotype.Component;

import com.icafe.demo.security.UserPrincipal;

@Component
public class AuditorAwareImpl implements AuditorAware<Integer>{
    @SuppressWarnings("null")
    @Override
    public Optional<Integer> getCurrentAuditor() {
        Authentication authentication = SecurityContextHolder.getContext().getAuthentication();

        if (authentication == null || !authentication.isAuthenticated() || authentication.getPrincipal() == "anonymousUser") {
            return Optional.empty();
        }

        if (authentication.getPrincipal() instanceof UserPrincipal userPrincipal) {
            return Optional.of(userPrincipal.getUserId()); // Đảm bảo UserPrincipal có phương thức getId()
        }

        return Optional.empty();
    }
}
