package com.icafe.demo.repository;

import java.util.Optional;

import org.springframework.data.jpa.repository.JpaRepository;
import org.springframework.stereotype.Repository;

import com.icafe.demo.models.Payment;

@Repository
public interface IPaymentRepository extends JpaRepository<Payment, Integer>{
    Optional<Payment> findByTransactionId(String transactionId);
}
