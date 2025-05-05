package com.icafe.demo.service.PaymentService;

import java.math.BigDecimal;

import com.icafe.demo.enums.PaymentMethod;
import com.icafe.demo.models.Payment;

public interface IPaymentService {
    Payment createPayment(Integer orderId, PaymentMethod method, BigDecimal amount, String transactionId);
    void confirmPaymentSuccess(String transactionId);
    
} 