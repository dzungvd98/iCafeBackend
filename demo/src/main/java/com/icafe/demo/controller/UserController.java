package com.icafe.demo.controller;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.http.HttpStatus;
import org.springframework.http.ResponseEntity;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RestController;

import com.icafe.demo.service.UserService.IUserService;

import jakarta.validation.constraints.Max;
import jakarta.validation.constraints.Min;

import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.RequestParam;


@RestController
@RequestMapping("/users/")
public class UserController {
    @Autowired
    private IUserService userService;

    @GetMapping
    public ResponseEntity<?> getUsers(@RequestParam(defaultValue = "") String keyword,
                                        @RequestParam(defaultValue = "1") @Min(1) int page, 
                                        @RequestParam(defaultValue = "10") @Min(1) @Max(20) int size) {
        try {
            return ResponseEntity.ok(userService.getListUsers(keyword, page, size));
        } catch (Exception e) {
            System.out.println(e);
            return ResponseEntity.status(HttpStatus.INTERNAL_SERVER_ERROR).body(e.getMessage());
        }
    }
    
}
