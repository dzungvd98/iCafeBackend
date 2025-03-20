package com.icafe.demo.controller;

import java.time.LocalDateTime;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.http.HttpStatus;
import org.springframework.http.ResponseEntity;
import org.springframework.security.crypto.bcrypt.BCryptPasswordEncoder;
import org.springframework.web.bind.annotation.CrossOrigin;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestBody;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RestController;

import com.icafe.demo.dto.UserDto;
import com.icafe.demo.entity.Token;
import com.icafe.demo.enums.RoleEnum;
import com.icafe.demo.models.Role;
import com.icafe.demo.models.User;
import com.icafe.demo.repository.IRoleRepository;
import com.icafe.demo.repository.IUserRepository;
import com.icafe.demo.security.JwtUtil;
import com.icafe.demo.security.UserPrincipal;
import com.icafe.demo.service.TokenService.ITokenService;
import com.icafe.demo.service.UserService.IUserService;


@RestController
@RequestMapping("api/v1/users")
public class AuthController {
    @Autowired
    private IUserRepository userRepository;

    @Autowired
    private IUserService userService;

    @Autowired
    private ITokenService tokenService;

    @Autowired
    private JwtUtil jwtUtil;

    @Autowired
    private IRoleRepository iRole;

    @CrossOrigin
    @PostMapping("/register")
    public ResponseEntity<Object> registerApi(@RequestBody UserDto user) {
        try {
            User newUser = new User();
            newUser.setPassword(new BCryptPasswordEncoder().encode(user.getPassword()));
            newUser.setUsername(user.getUsername());
            Role staffRole = iRole.findByRoleName(RoleEnum.STAFF).get();
            newUser.setRole(staffRole);
            newUser.setCreatedAt(LocalDateTime.now());
            newUser.setUpdatedAt(LocalDateTime.now());
            newUser = userService.createUser(newUser);
            newUser.setCreatedBy(newUser.getId());
            newUser.setUpdatedBy(newUser.getId());
            userRepository.save(newUser);
            return ResponseEntity.ok("Tạo tài khoản thành công!");
        } catch (Exception e) {
            System.out.println(e);
            return ResponseEntity.status(HttpStatus.INTERNAL_SERVER_ERROR).body("Có lỗi xảy ra, vui lòng thử lại!");
        }
    }

    // API login
    @CrossOrigin
    @PostMapping("/login")
    public ResponseEntity<?> login(@RequestBody UserDto user) {
        try {
            UserPrincipal userPrincipal = userService.findByUsername(user.getUsername());
            User pUser = userRepository.findByUsername(user.getUsername());

            if(userPrincipal == null || !new BCryptPasswordEncoder().matches(user.getPassword(), userPrincipal.getPassword())) {
                return ResponseEntity.status(HttpStatus.BAD_REQUEST).body("Tên đăng nhập hoặc mật khẩu không đúng!");
            }
            if(pUser.isDeleted()) {
                return ResponseEntity.status(HttpStatus.BAD_REQUEST).body("Tài khoản hiện không hoạt động!");
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
            return ResponseEntity.status(HttpStatus.INTERNAL_SERVER_ERROR).body("Có lỗi xảy ra, vui lòng thử lại!");
        }
    }
    
}
