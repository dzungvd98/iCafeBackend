package com.icafe.demo.specification;

import org.springframework.data.jpa.domain.Specification;

import com.icafe.demo.models.User;

import jakarta.persistence.criteria.Predicate;

public class UserSpecification {
    @SuppressWarnings("null")
    public static Specification<User> hasSearchKeyWord(String keyword) {
        return (root, query, cb) -> {
            Predicate deletedPredicate = cb.isFalse(root.get("deleted"));

            query.orderBy(cb.desc(root.get("updatedAt")));
            if(query == null || keyword.trim().isEmpty()) {
                return deletedPredicate;
            }

            String likeSearch = "%" + keyword + "%";
            Predicate searchPredicate = cb.or(
                cb.like(root.get("username"), likeSearch)
            );

            return cb.and(deletedPredicate, searchPredicate);
        };
    }
}
