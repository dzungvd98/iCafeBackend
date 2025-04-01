package com.icafe.demo.specification;

import java.time.LocalDate;
import java.time.LocalDateTime;

import org.springframework.data.jpa.domain.Specification;

import com.icafe.demo.enums.OrderStatus;
import com.icafe.demo.models.Order;

import jakarta.persistence.criteria.CriteriaBuilder;
import jakarta.persistence.criteria.CriteriaQuery;
import jakarta.persistence.criteria.Root;

public class OrderSpecification {
    
    public static Specification<Order> hasOrderDateOn(LocalDateTime date) {
        return (Root<Order> root, CriteriaQuery<?> query, CriteriaBuilder cb) -> {
            LocalDate targetDate = date.toLocalDate();
            return cb.equal(cb.function("DATE", LocalDate.class, root.get("createdAt")), targetDate);
        };
    }

    public static Specification<Order> betweenDates(LocalDateTime startDate, LocalDateTime endDate) {
        return (root, query, criteriaBuilder) -> {
            return criteriaBuilder.between(root.get("createdAt"), startDate, endDate);
        };
    }

    public static Specification<Order> hasStatus(OrderStatus status) {
        return (root, query, criteriaBuilder) -> {
            return criteriaBuilder.equal(root.get("status"), status);
        };
    }
    

}
