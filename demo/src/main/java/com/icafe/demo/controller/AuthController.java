package com.icafe.demo.controller;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.http.HttpStatus;
import org.springframework.http.ResponseEntity;
import org.springframework.security.crypto.bcrypt.BCryptPasswordEncoder;
import org.springframework.web.bind.annotation.CrossOrigin;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.PutMapping;
import org.springframework.web.bind.annotation.RequestBody;
import org.springframework.web.bind.annotation.RequestHeader;
import org.springframework.web.bind.annotation.RequestMapping;
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


@RestController
@RequestMapping("api/v1/users")
@CrossOrigin
public class AuthController {
    @Autowired
    private IUserRepository userRepository;

    @Autowired
    private IUserService userService;

    @Autowired
    private ITokenService tokenService;

    @Autowired
    private JwtUtil jwtUtil;


    @PostMapping("/register")
    public ResponseEntity<Object> registerApi(@RequestBody UserDTO user) {
        try {
            userService.createUser(user);
            return ResponseEntity.ok("Account created successfull!");
        } catch (Exception e) {
            System.out.println(e);
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
