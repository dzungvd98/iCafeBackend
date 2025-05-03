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

        // Thanh toán tiền mặt thì cập nhật luôn thành công
        if (method == PaymentMethod.CASH) {
            payment.setStatus(PaymentStatus.SUCCESS);
            order.setStatus(OrderStatus.PENDING); // bạn cần định nghĩa enum này
        } else {
            payment.setStatus(PaymentStatus.PENDING); // ví điện tử cần xác nhận sau
        }

        order.setPayment(payment); // set 2 chiều

        orderRepository.save(order); // cascade sẽ tự lưu payment

        return payment;
    }

    public void confirmPaymentSuccess(String transactionId) {
        Payment payment = paymentRepository.findByTransactionId(transactionId)
        .orElseThrow(() -> new RuntimeException("Payment not found"));

        payment.setStatus(PaymentStatus.SUCCESS);
        payment.setPaidTime(LocalDateTime.now());

        // Cập nhật đơn hàng
        Order order = payment.getOrder();
        order.setStatus(OrderStatus.PENDING);

        paymentRepository.save(payment); // cascade cũng cập nhật order nếu cần
    }


}
