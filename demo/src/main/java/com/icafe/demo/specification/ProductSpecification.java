package com.icafe.demo.specification;

import org.springframework.data.jpa.domain.Specification;

import com.icafe.demo.models.Product;

import jakarta.persistence.criteria.Predicate;

public class ProductSpecification {
    @SuppressWarnings("null")
    public static Specification<Product> hasSearchKeyword(String keyword, int categoryId) {
        return (root, query, cb) -> {
            Predicate deletedPredicate = cb.isFalse(root.get("deleted"));
            Predicate categoryPredicate = categoryId != 0 
            ? cb.equal(root.get("category").get("id"), categoryId) 
            : cb.isTrue(cb.literal(true));
            
            if (query.getOrderList().isEmpty()) {
                query.orderBy(cb.desc(root.get("createdAt"))); 
            }

            if (keyword == null || keyword.trim().isEmpty()) {
                return cb.and(deletedPredicate, categoryPredicate);
            }

            String likeSearch = "%" + keyword + "%";
            Predicate searchPredicate = cb.or(
                cb.like(root.get("productName"), likeSearch)
            );

            return cb.and(deletedPredicate, categoryPredicate, searchPredicate);
        };
    }

    @SuppressWarnings("null")
    public static Specification<Product> hasSearchKeywordAndCategory(String keyword, int categoryId) {
        return (root, query, cb) -> {
            Predicate deletedPredicate = cb.isFalse(root.get("deleted"));
            Predicate categoryPredicate = cb.equal(root.get("category").get("id"), categoryId);
            
            // Sắp xếp theo productName theo thứ tự alphabet (tăng dần)
            query.orderBy(cb.asc(root.get("productName")));
    
            if (keyword == null || keyword.trim().isEmpty()) {
                return cb.and(deletedPredicate, categoryPredicate);
            }
    
            String likeSearch = "%" + keyword + "%";
            Predicate searchPredicate = cb.or(
                cb.like(root.get("productName"), likeSearch)
            );
    
            return cb.and(deletedPredicate, categoryPredicate, searchPredicate);
        };
    }
}
