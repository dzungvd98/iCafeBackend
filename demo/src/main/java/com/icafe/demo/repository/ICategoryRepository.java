package com.icafe.demo.repository;



import org.springframework.data.jpa.repository.JpaRepository;
import org.springframework.stereotype.Repository;

import com.icafe.demo.models.Category;


@Repository
public interface ICategoryRepository extends JpaRepository<Category, Integer> {
}

