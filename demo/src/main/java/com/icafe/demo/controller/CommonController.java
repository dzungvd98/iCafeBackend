package com.icafe.demo.controller;

import org.springframework.http.HttpStatus;
import org.springframework.http.ResponseEntity;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.RestController;
import org.springframework.web.multipart.MultipartFile;

import com.icafe.demo.service.MailService.MailService;

import lombok.RequiredArgsConstructor;
import lombok.extern.slf4j.Slf4j;


@RestController
@RequestMapping("/common")
@Slf4j
@RequiredArgsConstructor
public class CommonController {
    
    private final MailService mailService;

    @PostMapping("/send-email")
    public ResponseEntity<?> sendEmail(@RequestParam String recipents, 
                                @RequestParam String subject, 
                                @RequestParam String content, 
                                @RequestParam(required = false) MultipartFile[] files) {
        try {
            return ResponseEntity.ok(mailService.sendEmail(recipents, subject, content, files));
        } catch (Exception e) {
            log.error("Sending email was failure, errorMessage={}", e.getMessage());
            return new ResponseEntity<>(HttpStatus.BAD_REQUEST);
        }                   
    }

}
