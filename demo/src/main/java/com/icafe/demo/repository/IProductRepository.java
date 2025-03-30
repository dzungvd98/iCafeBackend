package com.icafe.demo.repository;

import java.util.List;
import java.util.Optional;

import org.springframework.data.jpa.repository.JpaRepository;
import org.springframework.stereotype.Repository;

import com.icafe.demo.enums.Status;
import com.icafe.demo.models.Product;

@Repository
public interface IProductRepository extends JpaRepository<Product, Integer>{
    List<Product> findByCategoryIdAndStatusAndDeleted(int categoryId, Status status, Boolean deleted);
    Optional<Product> findByProductCode(String productCode);

}
