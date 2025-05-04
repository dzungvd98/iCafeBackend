package com.icafe.demo.controller;

import java.math.BigDecimal;

import org.springframework.http.ResponseEntity;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.RestController;

import com.icafe.demo.enums.PaymentMethod;
import com.icafe.demo.models.Payment;
import com.icafe.demo.service.PaymentService.IPaymentService;

import lombok.RequiredArgsConstructor;

@RestController
@RequestMapping("/payments")
@RequiredArgsConstructor
public class PaymentController {
    
    private final IPaymentService paymentService;

    @PostMapping
    public ResponseEntity<Payment> createPayment(
            @RequestParam Integer orderId,
            @RequestParam PaymentMethod method,
            @RequestParam BigDecimal amount,
            @RequestParam String transactionId) {
        
        Payment payment = paymentService.createPayment(orderId, method, amount, transactionId);
        return ResponseEntity.ok(payment);
    }

    @PostMapping("/confirm")
    public ResponseEntity<String> confirmPayment(@RequestParam String transactionId) {
        paymentService.confirmPaymentSuccess(transactionId);
        return ResponseEntity.ok("Payment confirmed successfully");
    }
}
