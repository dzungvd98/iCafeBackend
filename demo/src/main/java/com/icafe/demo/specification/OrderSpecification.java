package com.icafe.demo.specification;

import java.time.LocalDate;
import java.time.LocalDateTime;

import org.springframework.data.jpa.domain.Specification;

import com.icafe.demo.models.Order;

import jakarta.persistence.EntityManager;
import jakarta.persistence.TypedQuery;
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

    public static Double getAverageOrderValueByOrderDateBetween(EntityManager entityManager, 
                                                              LocalDateTime startDate, 
                                                              LocalDateTime endDate) {
        CriteriaBuilder cb = entityManager.getCriteriaBuilder();
        CriteriaQuery<Double> cq = cb.createQuery(Double.class);
        Root<Order> root = cq.from(Order.class);

        cq.select(cb.avg(root.get("totalPrice")));
        
        cq.where(cb.between(root.get("createdAt"), startDate, endDate));

        TypedQuery<Double> query = entityManager.createQuery(cq);
        Double result = query.getSingleResult();

        return result != null ? result : 0.0;
    }
    

}
