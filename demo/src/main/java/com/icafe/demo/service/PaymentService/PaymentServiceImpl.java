package com.icafe.demo.service.PaymentService;

import java.math.BigDecimal;
import java.time.LocalDateTime;

import org.springframework.stereotype.Service;

import com.icafe.demo.enums.OrderStatus;
import com.icafe.demo.enums.PaymentMethod;
import com.icafe.demo.enums.PaymentStatus;
import com.icafe.demo.models.Order;
import com.icafe.demo.models.Payment;
import com.icafe.demo.repository.IOrderRepository;
import com.icafe.demo.repository.IPaymentRepository;

import lombok.RequiredArgsConstructor;

@Service
@RequiredArgsConstructor
public class PaymentServiceImpl implements IPaymentService{
    
    private final IOrderRepository orderRepository;
    private final IPaymentRepository paymentRepository;
    

    public Payment createPayment(Integer orderId, PaymentMethod method, BigDecimal amount, String transactionId) {
        Order order = orderRepository.findById(orderId)
                .orElseThrow(() -> new RuntimeException("Order not found"));

        if (order.getPayment() != null) {
            throw new RuntimeException("Order already has a payment");
        }

        Payment payment = new Payment();
        payment.setOrder(order);
        payment.setMethod(method);
        payment.setAmount(amount);
        payment.setTransactionId(transactionId);
        payment.setPaidTime(LocalDateTime.now());

        if (method == PaymentMethod.CASH) {
            payment.setStatus(PaymentStatus.SUCCESS);
            order.setStatus(OrderStatus.PENDING); 
        } else {
            payment.setStatus(PaymentStatus.PENDING); 
        }

        order.setPayment(payment); 

        orderRepository.save(order); 

        return payment;
    }

    public void confirmPaymentSuccess(String transactionId) {
        Payment payment = paymentRepository.findByTransactionId(transactionId)
        .orElseThrow(() -> new RuntimeException("Payment not found"));

        payment.setStatus(PaymentStatus.SUCCESS);
        payment.setPaidTime(LocalDateTime.now());

        Order order = payment.getOrder();
        order.setStatus(OrderStatus.PENDING);

        paymentRepository.save(payment);
    }

    

}
