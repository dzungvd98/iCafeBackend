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
public interface IOrderRepository extends JpaRepository<Order, Integer>, JpaSpecificationExecutor<Order> {
    Optional<Order> findByOrderCode(String orderCode);

    long countByCreatedAtBetween(LocalDateTime startDate, LocalDateTime endDate);

    long countByCreatedAtBetweenAndStatus(LocalDateTime startDate, LocalDateTime endDate, OrderStatus status);

    @Query("SELECT AVG(o.totalPrice) FROM Order o WHERE o.createdAt BETWEEN :startDate AND :endDate AND o.status = :status")
    Double getAverageOrderValue(@Param("startDate") LocalDateTime startDate, @Param("endDate") LocalDateTime endDate,
            @Param("status") OrderStatus status);

    @Query("SELECT SUM(o.totalPrice) FROM Order o WHERE o.createdAt BETWEEN :startDate AND :endDate AND o.status = :status")
    Double getRevenueAtBetweenAndStatus(@Param("startDate") LocalDateTime startDate,
            @Param("endDate") LocalDateTime endDate, @Param("status") OrderStatus status);

    @Query(value = "SELECT SUM(p.base_price * op.quantity) AS capital_price " +
            "FROM orders o " +
            "LEFT JOIN order_products op ON o.order_code = op.order_code " +
            "LEFT JOIN products p ON op.product_id = p.product_id " +
            "WHERE o.created_at BETWEEN :startDate AND :endDate " +
            "AND o.status = :status", nativeQuery = true)
    Double getCapitalPriceAtBetweenAndStatus(@Param("startDate") LocalDateTime startDate,
            @Param("endDate") LocalDateTime endDate, @Param("status") String status);

    @Query(value = "SELECT d.date AS period, " +
            "COALESCE(SUM(op.quantity * op.price_each), 0) AS revenue, " +
            "COALESCE(SUM(op.quantity * op.price_each), 0) - COALESCE(SUM(op.quantity * p.base_price), 0) AS profit " +
            "FROM ( " +
            "    SELECT DATE(:dateView - INTERVAL n DAY) AS date " +
            "    FROM (SELECT 0 AS n UNION SELECT 1 UNION SELECT 2 UNION SELECT 3 UNION SELECT 4 UNION SELECT 5 UNION SELECT 6) numbers "
            +
            ") d " +
            "LEFT JOIN orders o ON DATE(o.created_at) = d.date " +
            "LEFT JOIN order_products op ON o.order_code = op.order_code AND o.status = :status " +
            "LEFT JOIN products p ON op.product_id = p.product_id " +
            "GROUP BY d.date " +
            "ORDER BY d.date", nativeQuery = true)
    List<Object[]> findDailyReport(
            @Param("dateView") LocalDate dateView,
            @Param("status") String status);

        @Query(value = "SELECT CONCAT(DATE_FORMAT(d.week_start, '%d/%m'), '-', DATE_FORMAT(d.week_end, '%d/%m')) AS period, " +
            "COALESCE(SUM(op.quantity * op.price_each), 0) AS revenue, " +
            "COALESCE(SUM(op.quantity * op.price_each), 0) - COALESCE(SUM(op.quantity * p.base_price), 0) AS profit " +
            "FROM ( " +
            "    SELECT " +
            "        DATE(:dateView - INTERVAL n WEEK - INTERVAL WEEKDAY(:dateView - INTERVAL n WEEK) DAY) AS week_start, " +
            "        DATE(:dateView - INTERVAL n WEEK - INTERVAL WEEKDAY(:dateView - INTERVAL n WEEK) DAY + INTERVAL 6 DAY) AS week_end " +
            "    FROM (SELECT 0 AS n UNION SELECT 1 UNION SELECT 2 UNION SELECT 3 UNION SELECT 4 UNION SELECT 5 UNION SELECT 6) numbers " +
            ") d " +
            "LEFT JOIN orders o ON o.created_at >= d.week_start AND o.created_at <= d.week_end AND o.status = :status " +
            "LEFT JOIN order_products op ON o.order_code = op.order_code " +
            "LEFT JOIN products p ON op.product_id = p.product_id " +
            "GROUP BY d.week_start, d.week_end " +
            "ORDER BY d.week_start", nativeQuery = true)
    List<Object[]> findWeeklyReport(
            @Param("dateView") LocalDate dateView,
            @Param("status") String status);

    @Query(value = "SELECT CONCAT(d.year, '-', LPAD(d.month, 2, '0')) AS period, " +
            "COALESCE(SUM(op.quantity * op.price_each), 0) AS revenue, " +
            "COALESCE(SUM(op.quantity * op.price_each), 0) - COALESCE(SUM(op.quantity * p.base_price), 0) AS profit " +
            "FROM ( " +
            "    SELECT YEAR(:dateView - INTERVAL n MONTH) AS year, MONTH(:dateView - INTERVAL n MONTH) AS month " +
            "    FROM (SELECT 0 AS n UNION SELECT 1 UNION SELECT 2 UNION SELECT 3 UNION SELECT 4 UNION SELECT 5 UNION SELECT 6) numbers "
            +
            ") d " +
            "LEFT JOIN orders o ON YEAR(o.created_at) = d.year AND MONTH(o.created_at) = d.month AND o.status = :status "
            +
            "LEFT JOIN order_products op ON o.order_code = op.order_code " +
            "LEFT JOIN products p ON op.product_id = p.product_id " +
            "GROUP BY d.year, d.month " +
            "ORDER BY d.year, d.month", nativeQuery = true)
    List<Object[]> findMonthlyReport(
            @Param("dateView") LocalDate dateView,
            @Param("status") String status);

    @Query(value = "SELECT d.year AS period, " +
            "COALESCE(SUM(op.quantity * op.price_each), 0) AS revenue, " +
            "COALESCE(SUM(op.quantity * op.price_each), 0) - COALESCE(SUM(op.quantity * p.base_price), 0) AS profit " +
            "FROM ( " +
            "    SELECT YEAR(:dateView - INTERVAL n YEAR) AS year " +
            "    FROM (SELECT 0 AS n UNION SELECT 1 UNION SELECT 2 UNION SELECT 3 UNION SELECT 4 UNION SELECT 5 UNION SELECT 6) numbers "
            +
            ") d " +
            "LEFT JOIN orders o ON YEAR(o.created_at) = d.year AND o.status = :status " +
            "LEFT JOIN order_products op ON o.order_code = op.order_code " +
            "LEFT JOIN products p ON op.product_id = p.product_id " +
            "GROUP BY d.year " +
            "ORDER BY d.year", nativeQuery = true)
    List<Object[]> findYearlyReport(
            @Param("dateView") LocalDate dateView,
            @Param("status") String status);
}
