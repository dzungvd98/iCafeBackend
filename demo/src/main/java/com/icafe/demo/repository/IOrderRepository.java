package com.icafe.demo.repository;

import java.time.LocalDate;
import java.time.LocalDateTime;
import java.util.List;
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

    @Query("SELECT AVG(o.totalPrice) FROM Order o WHERE o.createdAt BETWEEN :startDate AND :endDate AND o.status = :status")
    Double getAverageOrderValue(@Param("startDate") LocalDateTime startDate, @Param("endDate") LocalDateTime endDate, @Param("status") OrderStatus status);

    @Query("SELECT SUM(o.totalPrice) FROM Order o WHERE o.createdAt BETWEEN :startDate AND :endDate AND o.status = :status")
    Double getRevenueAtBetweenAndStatus(@Param("startDate") LocalDateTime startDate, @Param("endDate") LocalDateTime endDate, @Param("status") OrderStatus status);

    @Query(value = "SELECT SUM(op.quantity * p.base_price) AS total_amount " +
        "FROM orders o " +
        "JOIN order_products op ON o.order_code = op.order_code " +
        "JOIN products p ON op.product_id = p.product_id " +
        "WHERE o.created_at BETWEEN :startDate AND :endDate " +
        "AND o.status = :status", nativeQuery = true)
    Double getCapitalPriceAtBetweenAndStatus(@Param("startDate") LocalDateTime startDate, @Param("endDate") LocalDateTime endDate, @Param("status") String status);

    @Query(value = "SELECT d.date AS period, COALESCE(SUM(op.quantity * op.price_each), 0) AS revenue " +
                   "FROM ( " +
                   "    SELECT DATE(:dateView - INTERVAL n DAY) AS date " +
                   "    FROM (SELECT 0 AS n UNION SELECT 1 UNION SELECT 2 UNION SELECT 3 UNION SELECT 4 UNION SELECT 5 UNION SELECT 6) numbers " +
                   ") d " +
                   "LEFT JOIN orders o ON DATE(o.created_at) = d.date AND o.status = :status " +
                   "LEFT JOIN order_products op ON o.order_code = op.order_code " +
                   "GROUP BY d.date " +
                   "ORDER BY d.date", nativeQuery = true)
    List<Object[]> findDailyRevenue(
            @Param("dateView") LocalDate dateView,
            @Param("status") String status);
}
