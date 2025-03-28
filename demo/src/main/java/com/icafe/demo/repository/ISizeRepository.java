package com.icafe.demo.repository;

import org.springframework.data.jpa.repository.JpaRepository;
import org.springframework.stereotype.Repository;

import com.icafe.demo.models.Size;
import java.util.Optional;


@Repository
public interface ISizeRepository extends JpaRepository<Size, Integer>{

    Optional<Size> findBySizeName(String sizeName);
    
}
