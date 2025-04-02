package com.icafe.demo.specification;

import java.math.BigDecimal;
import java.time.LocalDateTime;

import org.springframework.data.jpa.domain.Specification;

import com.icafe.demo.enums.ProductSaleSortType;
import com.icafe.demo.models.Order;
import com.icafe.demo.models.OrderProduct;
import com.icafe.demo.models.Product;

import jakarta.persistence.criteria.Expression;
import jakarta.persistence.criteria.Join;
import jakarta.persistence.criteria.Predicate;


public class OrderProductSpecification {
    public static Specification<OrderProduct> getTopSellingProductSpec(
                                        LocalDateTime startDate, 
                                        LocalDateTime endDate,
                                        ProductSaleSortType sortType) {
        return (root, query, criteriaBuilder) -> {
            Join<OrderProduct, Order> orderJoin = root.join("order");

            Predicate datePredicate = criteriaBuilder.between(
                orderJoin.get("createdAt"),
                startDate,
                endDate
            );

            Predicate notCancelled = criteriaBuilder.isFalse(root.get("isCancel"));
            Predicate combinedPredicate = criteriaBuilder.and(datePredicate, notCancelled);

            Join<OrderProduct, Product> productJoin = root.join("product");

            query.groupBy(
                productJoin.get("productCode"),
                productJoin.get("productName")
            );

            Expression<BigDecimal> revenueExpression = criteriaBuilder.prod(
                criteriaBuilder.toBigDecimal(root.get("quantity")),
                root.get("priceEach")
            );

            query.multiselect(
                productJoin.get("productCode"),
                productJoin.get("productName"),
                criteriaBuilder.sum(root.get("quantity")).alias("quantitySold"),
                criteriaBuilder.sum(revenueExpression).alias("productRevenue")
            );

            if (sortType == ProductSaleSortType.QUANTITY) {
                query.orderBy(criteriaBuilder.desc(criteriaBuilder.sum(root.get("quantity"))));
            } else { // REVENUE
                query.orderBy(criteriaBuilder.desc(criteriaBuilder.sum(revenueExpression)));
            }

            query.distinct(true);
            return combinedPredicate;
        };
    }
}
