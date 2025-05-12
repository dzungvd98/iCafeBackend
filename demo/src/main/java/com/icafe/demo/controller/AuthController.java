package com.icafe.demo.controller;

import org.springframework.http.HttpHeaders;
import org.springframework.http.HttpStatus;
import org.springframework.http.ResponseEntity;
import org.springframework.security.crypto.bcrypt.BCryptPasswordEncoder;
import org.springframework.web.bind.annotation.CrossOrigin;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.PutMapping;
import org.springframework.web.bind.annotation.RequestBody;
import org.springframework.web.bind.annotation.RequestHeader;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.RestController;

import com.icafe.demo.dto.UserChangePasswordDTO;
import com.icafe.demo.dto.UserDTO;
import com.icafe.demo.dto.UserNewPasswordDTO;
import com.icafe.demo.entity.Token;
import com.icafe.demo.models.User;
import com.icafe.demo.repository.IUserRepository;
import com.icafe.demo.security.JwtUtil;
import com.icafe.demo.security.UserPrincipal;
import com.icafe.demo.service.TokenService.ITokenService;
import com.icafe.demo.service.UserService.IUserService;

import io.swagger.v3.oas.annotations.tags.Tag;
import jakarta.validation.constraints.Min;
import lombok.RequiredArgsConstructor;
import lombok.extern.slf4j.Slf4j;


@RestController
@RequestMapping("api/v1/users")
@CrossOrigin
@Slf4j
@Tag(name = "Authentication Controller")
@RequiredArgsConstructor
public class AuthController {
    private final IUserRepository userRepository;
    private final IUserService userService;
    private final ITokenService tokenService;
    private final JwtUtil jwtUtil;

    @PostMapping("/register")
    public ResponseEntity<Object> registerApi(@RequestBody UserDTO user) {
        try {
            return ResponseEntity.ok(userService.createUser(user));
        } catch (Exception e) {
            System.out.println(e);
            return ResponseEntity.status(HttpStatus.INTERNAL_SERVER_ERROR).body(e.getMessage());
        }
    }

    @GetMapping("/{userId}/confirm")
    public ResponseEntity<?> confirmUser(@Min(1) @PathVariable int userId, @RequestParam String secretCode) {
        log.info("Confirm user with id = {}, secretCode = {}", userId, secretCode);
        try {
            userService.confirmUser(userId, secretCode);
            return ResponseEntity
                .status(HttpStatus.FOUND) // 302 Redirect
                .header(HttpHeaders.LOCATION, "/login")
                .build();
        } catch (Exception e) {
            log.error("errorMessage={}", e.getMessage(), e.getCause());
            return ResponseEntity.status(HttpStatus.INTERNAL_SERVER_ERROR).body(e.getMessage());
        } 
    }

    // API login
    @PostMapping("/login")
    public ResponseEntity<?> login(@RequestBody UserDTO user) {
        try {
            UserPrincipal userPrincipal = userService.findByUsername(user.getUsername());

            if(userPrincipal == null || !new BCryptPasswordEncoder().matches(user.getPassword(), userPrincipal.getPassword())) {
                return ResponseEntity.status(HttpStatus.UNAUTHORIZED).body("Username or password is incorrect!");
            }
            if(userPrincipal.isDeleted()) {
                return ResponseEntity.status(HttpStatus.BAD_REQUEST).body("Account has been disabled!");
            }
            tokenService.deleteUserToken(userPrincipal.getUserId());

            Token token = new Token();
            token.setToken(jwtUtil.generateToken(userPrincipal));
            token.setTokenExpDate(jwtUtil.generateExpirationDate());
            token.setCreatedBy(userPrincipal.getUserId());
            token.setUpdatedBy(userPrincipal.getUserId());
            tokenService.createToken(token);
            return ResponseEntity.ok(token.getToken());  
        } catch (Exception e) {
            System.out.println(e);
            return ResponseEntity.status(HttpStatus.INTERNAL_SERVER_ERROR).body(e.getMessage());
        }
    }

    @PutMapping("/change-password")
    public ResponseEntity<?> changePassword(@RequestBody UserChangePasswordDTO userChangePassword) {
        try {
            User user = userRepository.findByUsername(userChangePassword.getUsername());
            if(user == null || !new BCryptPasswordEncoder().matches(userChangePassword.getOldPassword(), user.getPassword())) {
                return ResponseEntity.status(HttpStatus.BAD_REQUEST).body("Invalid username or password!");
            }

            // String passwordRegex = "^(?=.*[a-zA-Z])(?=.*\\d).{6,}$";
            // Pattern pattern = Pattern.compile(passwordRegex);
            // Matcher matcher = pattern.matcher(userChangePassword.getNewPassword());
            // if(!matcher.matches()) {
            //     return ResponseEntity.status(HttpStatus.BAD_REQUEST).body("Mật khẩu phải có ít nhất 6 ký tự bao gồm cả chữ lẫn số!");
            // }

            user.setPassword(new BCryptPasswordEncoder().encode(userChangePassword.getNewPassword()));
            userRepository.save(user);
            return ResponseEntity.ok("The password has been changed!");

        } catch (Exception e) {
            System.out.println(e);
            return ResponseEntity.status(HttpStatus.INTERNAL_SERVER_ERROR).body(e.getMessage());
        }
    }

    @PutMapping("/reset-password")
    public ResponseEntity<?> resetPassword(@RequestBody UserNewPasswordDTO userNewPassword) {
        try {
            User user = userRepository.findByUsername(userNewPassword.getUsername());
            if(user == null) {
                return ResponseEntity.status(HttpStatus.BAD_REQUEST).body("Invalid username!");
            }
            user.setPassword(new BCryptPasswordEncoder().encode(userNewPassword.getPassword()));
            userRepository.save(user);
            return ResponseEntity.ok("The password has been reseted!");
        } catch (Exception e) {
            System.out.println(e);
            return ResponseEntity.status(HttpStatus.INTERNAL_SERVER_ERROR).body(e.getMessage());
        }
    }

    @PostMapping("/logout")
    public ResponseEntity<?> logout(@RequestHeader("Authorization") String authHeader) {
        String tokenStr = authHeader.substring(7).trim();
        tokenService.deleteToken(tokenStr);
        return ResponseEntity.ok("Logged out successfully");
    }
    
    
}
