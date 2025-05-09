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

import io.swagger.v3.oas.annotations.Operation;
import io.swagger.v3.oas.annotations.tags.Tag;
import lombok.RequiredArgsConstructor;
import lombok.extern.slf4j.Slf4j;

@RestController
@RequestMapping("/payments")
@RequiredArgsConstructor
@Tag(name = "Payment Controller")
@Slf4j
public class PaymentController {
    
    private final IPaymentService paymentService;

    @Operation(summary = "Create a new payment", description = "Creates a new payment for an order.")
    @PostMapping
    public ResponseEntity<Payment> createPayment(
            @RequestParam Integer orderId,
            @RequestParam PaymentMethod method,
            @RequestParam BigDecimal amount,
            @RequestParam String transactionId) {
        try {
            log.info("Creating payment for orderId: {}, method: {}, amount: {}, transactionId: {}", orderId, method, amount, transactionId);
            Payment payment = paymentService.createPayment(orderId, method, amount, transactionId);
            return ResponseEntity.ok(payment);
        } catch (Exception e) {
            log.error("Error creating payment: {}", e.getMessage());
            return ResponseEntity.badRequest().body(null);
        }
    }

    @Operation(summary = "Confirm payment success", description = "Confirms the success of a payment.") 
    @PostMapping("/confirm")
    public ResponseEntity<String> confirmPayment(@RequestParam String transactionId) {
        try {
            log.info("Confirming payment success for transactionId: {}", transactionId);
            paymentService.confirmPaymentSuccess(transactionId);
            return ResponseEntity.ok("Payment confirmed successfully");
        } catch (Exception e) {
            log.error("Error confirming payment: {}", e.getMessage());
            return ResponseEntity.badRequest().body("Error confirming payment: " + e.getMessage());
        }
    }
}
