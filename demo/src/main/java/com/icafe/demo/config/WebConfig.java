package com.icafe.demo.config;

import org.springframework.context.annotation.Bean;
import org.springframework.context.annotation.Configuration;
import org.springframework.security.authentication.AuthenticationManager;
import org.springframework.security.config.annotation.authentication.configuration.AuthenticationConfiguration;
import org.springframework.web.servlet.config.annotation.CorsRegistry;
import org.springframework.web.servlet.config.annotation.WebMvcConfigurer;

@Configuration
public class WebConfig implements WebMvcConfigurer {
    @Override
    public void addCorsMappings(CorsRegistry registry) {
        registry.addMapping("/**") // Cho phép tất cả endpoint
                .allowedOrigins("*") // Cho phép tất cả origin (có thể thay bằng "http://localhost:3000" nếu cần cụ thể)
                .allowedMethods("GET", "POST", "PUT", "DELETE", "OPTIONS") // Các method được phép
                .allowedHeaders("*") // Cho phép tất cả header
                .allowCredentials(false); // Không cần credentials cho trường hợp này
    }
}
