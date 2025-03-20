package com.icafe.demo.repository;

import org.springframework.data.jpa.repository.JpaRepository;
import org.springframework.stereotype.Repository;

import com.icafe.demo.models.Ingredient;

@Repository
public interface IIngredientRepository extends JpaRepository<Ingredient, Integer>{

} 