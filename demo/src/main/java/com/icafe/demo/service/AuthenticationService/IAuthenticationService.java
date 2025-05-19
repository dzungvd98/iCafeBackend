package com.icafe.demo.service.AuthenticationService;

import com.icafe.demo.dto.ResetPasswordDTO;
import com.icafe.demo.dto.SignInRequest;
import com.icafe.demo.dto.TokenResponse;

import jakarta.servlet.http.HttpServletRequest;

public interface IAuthenticationService {
    TokenResponse accessToken(SignInRequest signInRequest);
    TokenResponse refreshToken(HttpServletRequest request);
    String removeToken(HttpServletRequest request);
    String forgotPassword(String email);
    String resetPassword(String secretKey);
    String changePassword(ResetPasswordDTO request);
    String confirmAccount(String username, String secretCode);
}
