package com.icafe.demo.specification;

import org.springframework.data.jpa.domain.Specification;

import com.icafe.demo.models.Product;

import jakarta.persistence.criteria.Predicate;

public class ProductSpecification {
    public static Specification<Product> hasSearchKeyword(String keyword) {
        return (root, query, cb) -> {
            Predicate deletedPredicate = cb.isFalse(root.get("deleted"));
            
            if (keyword == null || keyword.trim().isEmpty()) {
                return deletedPredicate;
            }

            String likeSearch = "%" + keyword + "%";
            Predicate searchPredicate = cb.or(
                cb.like(root.get("productCode"), likeSearch),
                cb.like(root.get("productName"), likeSearch)
            );

            return cb.and(deletedPredicate, searchPredicate);
        };
    }
}
