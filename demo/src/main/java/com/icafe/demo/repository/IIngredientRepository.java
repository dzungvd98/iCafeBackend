package com.icafe.demo.repository;

import org.springframework.data.jpa.repository.JpaRepository;

import com.icafe.demo.models.Ingredient;

public interface IIngredientRepository extends JpaRepository<Ingredient, Integer>{

} 