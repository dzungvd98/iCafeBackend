package com.icafe.demo.service.AuthenticationService;

import org.springframework.security.authentication.AuthenticationManager;
import org.springframework.security.authentication.UsernamePasswordAuthenticationToken;
import org.springframework.stereotype.Service;

import com.icafe.demo.dto.ResetPasswordDTO;
import com.icafe.demo.dto.SignInRequest;
import com.icafe.demo.dto.TokenResponse;
import com.icafe.demo.entity.RedisToken;
import com.icafe.demo.models.User;
import com.icafe.demo.repository.IUserRepository;
import com.icafe.demo.security.UserPrincipal;
import com.icafe.demo.service.JwtService.JwtService;
import com.icafe.demo.service.RedisTokenService.RedisTokenService;
import com.icafe.demo.service.UserService.IUserService;

import io.micrometer.common.util.StringUtils;
import jakarta.servlet.http.HttpServletRequest;
import lombok.RequiredArgsConstructor;
import lombok.extern.slf4j.Slf4j;

import static org.springframework.http.HttpHeaders.REFERER;
import static com.icafe.demo.util.TokenType.REFRESH_TOKEN;

@Slf4j
@Service
@RequiredArgsConstructor
public class AuthenticationServiceImpl implements IAuthenticationService{

    private final AuthenticationManager authenticationManager;
    private final RedisTokenService redisTokenService;
    private final IUserService userService;
    private final JwtService jwtService;
    private final IUserRepository userRepository;

    @Override
    public TokenResponse accessToken(SignInRequest signInRequest) {
        log.info("---------- accessToken ----------");

        UserPrincipal user = userService.findByUsername(signInRequest.getUsername());
    
        if(!user.isEnabled()) {
            throw new RuntimeException("User not active");
        }

        authenticationManager.authenticate(new UsernamePasswordAuthenticationToken(signInRequest.getUsername(), signInRequest.getPassword(), user.getAuthorities()));

        // Create new access token
        String accessToken = jwtService.generateToken(user);

        // Create new refresh token
        String refreshToken = jwtService.generateRefreshToken(user);

        redisTokenService.save(RedisToken.builder().id(user.getUsername()).accessToken(accessToken).refreshToken(refreshToken).build());

        return TokenResponse.builder()
            .accessToken(accessToken)
            .refreshToken(refreshToken)
            .userId(user.getUserId())
            .build();
        
    }

    @Override
    public TokenResponse refreshToken(HttpServletRequest request) {
        log.info("---------- refreshToken ----------");

        final String refreshToken = request.getHeader(REFERER);
        if(StringUtils.isBlank(refreshToken)) {
            throw new RuntimeException("Token must be not blank");
        }
        
        final String username = jwtService.extractUsername(refreshToken, REFRESH_TOKEN);
        var user = userService.findByUsername(username);
        if(jwtService.isValid(refreshToken, REFRESH_TOKEN, user)) {
            throw new RuntimeException("Token must be not blank");
        }

        String accessToken = jwtService.generateToken(user);

        redisTokenService.save(RedisToken.builder().id(user.getUsername()).accessToken(accessToken).refreshToken(refreshToken).build());

        return TokenResponse.builder()
                .accessToken(accessToken)
                .refreshToken(refreshToken)
                .userId(user.getUserId())
                .build();
    }

    @Override
    public String removeToken(HttpServletRequest request) {
        log.info("---------- removeToken ----------");

        final String token = request.getHeader(REFERER);
        if(StringUtils.isBlank(token)) {
            throw new RuntimeException("Token must be not blank");
        }

        final String username = jwtService.extractUsername(token, REFRESH_TOKEN);

        redisTokenService.remove(username);

        return "Removed!";
    }

    @Override
    public String forgotPassword(String email) {
        log.info("---------- forgotPassword ----------");

        var user = userService.getUserByEmail(email);

        String resetToken = jwtService.generateResetToken(user);

        redisTokenService.save(RedisToken.builder().id(user.getUsername()).resetToken(resetToken).build());

        String confirmLink = String.format("curl --location 'http://localhost:8080/api/v1/users/reset-password' \\\n" +
        "--header 'accept: */*' \\\n" +
        "--header 'Content-Type: application/json' \\\n" +
        "--data '%s'", resetToken);

        log.info("--> confirmLink: {}", confirmLink);

        return resetToken;
    }

    
    @Override
    public String resetPassword(String secretKey) {
        log.info("---------- resetPassword ----------");

        var user = validateToken(secretKey);

        redisTokenService.getById(user.getUsername());

        return "Reset";
    }


    @Override
    public String changePassword(ResetPasswordDTO request) {
        // TODO Auto-generated method stub
        throw new UnsupportedOperationException("Unimplemented method 'changePassword'");
    }

    private UserPrincipal validateToken(String token) {
        var userName = jwtService.extractUsername(token, REFRESH_TOKEN);

        redisTokenService.isExists(userName);

        UserPrincipal user = userService.findByUsername(userName);
        if(!user.isEnabled()) {
            throw new RuntimeException("User not active");
        }

        return user;
    }

    @Override
    public String confirmAccount(String username, String secretCode) {
        log.info("---------- Activated ----------");
        User user = userService.getByUserName(username);
        if(secretCode.equals(user.getSecretCode())) {
            user.setActived(true);
            user.setSecretCode("");
        } else {
            throw new RuntimeException("Secret code not match!");
        }
        userRepository.save(user);
        return "Actived";
    }

    
}
