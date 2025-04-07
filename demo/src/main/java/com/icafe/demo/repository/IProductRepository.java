package com.icafe.demo.repository;


import org.springframework.data.domain.Page;
import org.springframework.data.domain.Pageable;
import org.springframework.data.jpa.repository.JpaRepository;
import org.springframework.data.jpa.repository.JpaSpecificationExecutor;
import org.springframework.stereotype.Repository;

import com.icafe.demo.enums.Status;
import com.icafe.demo.models.Product;

@Repository
public interface IProductRepository extends JpaRepository<Product, Integer>, JpaSpecificationExecutor<Product>{
    Page<Product> findByCategoryIdAndStatusAndDeleted(int categoryId, Status status, Boolean deleted, Pageable pageable);
    Page<Product> findByDeleted(Boolean deleted, Pageable pageable);

}
