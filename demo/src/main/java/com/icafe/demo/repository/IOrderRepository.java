package com.icafe.demo.repository;

import java.time.LocalDateTime;
import java.util.Optional;

import org.springframework.data.jpa.repository.JpaRepository;
import org.springframework.data.jpa.repository.JpaSpecificationExecutor;
import org.springframework.data.jpa.repository.Query;
import org.springframework.data.repository.query.Param;
import org.springframework.stereotype.Repository;

import com.icafe.demo.enums.OrderStatus;
import com.icafe.demo.models.Order;

@Repository
public interface IOrderRepository extends JpaRepository<Order, Integer>, JpaSpecificationExecutor<Order>{
    Optional<Order> findByOrderCode(String orderCode);
    
    long countByCreatedAtBetween(LocalDateTime startDate, LocalDateTime endDate);

    long countByCreatedAtBetweenAndStatus(LocalDateTime startDate, LocalDateTime endDate, OrderStatus status);

    @Query("SELECT AVG(o.totalPrice) FROM Order o WHERE o.createdAt BETWEEN :startDate AND :endDate")
    Double getAverageOrderValue(@Param("startDate") LocalDateTime startDate, @Param("endDate") LocalDateTime endDate);

}
