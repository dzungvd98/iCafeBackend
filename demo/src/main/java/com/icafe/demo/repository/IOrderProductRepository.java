package com.icafe.demo.repository;

import java.time.LocalDateTime;
import java.util.List;

import org.springframework.data.domain.Pageable;
import org.springframework.data.jpa.repository.JpaRepository;
import org.springframework.data.jpa.repository.Query;
import org.springframework.data.repository.query.Param;
import org.springframework.stereotype.Repository;

import com.icafe.demo.dto.TopSellingProductResponseDTO;
import com.icafe.demo.models.OrderProduct;

@Repository
public interface IOrderProductRepository extends JpaRepository<OrderProduct, Integer>{
    
    @Query("SELECT new com.icafe.demo.dto.TopSellingProductResponseDTO(op.product.id, op.product.productName, SUM(op.quantity), SUM(op.quantity * op.priceEach)) " +
    "FROM OrderProduct op " +
    "WHERE op.order.createdAt BETWEEN :startDate AND :endDate " +
    "AND op.isCancel = false " +
    "GROUP BY op.product.id, op.product.productName " +
    "ORDER BY " + 
    "CASE WHEN :sortBy = 'REVENUE' THEN SUM(op.quantity * op.priceEach) " +
    "WHEN :sortBy = 'QUANTITY' THEN SUM(op.quantity) END DESC")
    List<TopSellingProductResponseDTO> getTopSellingProductS(
        @Param("startDate") LocalDateTime startDate,
        @Param("endDate") LocalDateTime endDate,
        String sortBy,
        Pageable pageable
    );
}
