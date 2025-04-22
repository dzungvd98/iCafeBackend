package com.icafe.demo.specification;

import org.springframework.data.jpa.domain.Specification;

import com.icafe.demo.models.Category;

import jakarta.persistence.criteria.Predicate;

public class CategorySpecification {
    @SuppressWarnings("null")
    public static Specification<Category> hasSearchKeyword(String keyword) {
        return (root, query, cb) -> {
            Predicate deletePredicate = cb.isFalse(root.get("deleted"));
            query.orderBy(cb.asc(root.get("categoryName")));
            
            if (keyword == null || keyword.trim().isEmpty()) {
                return deletePredicate;
            }
            String likeSearch = "%" + keyword + "%";
            Predicate searchPredicate = cb.or(
                cb.like(root.get("categoryName"), likeSearch)
            );

            return cb.and(deletePredicate, searchPredicate);
        };
    }
}
