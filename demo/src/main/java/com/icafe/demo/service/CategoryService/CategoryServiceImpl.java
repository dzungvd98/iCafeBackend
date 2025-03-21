package com.icafe.demo.service.CategoryService;

import java.util.List;

import org.springframework.stereotype.Service;

import com.icafe.demo.models.Category;
import com.icafe.demo.repository.ICategoryRepository;

import jakarta.persistence.EntityNotFoundException;

@Service
public class CategoryServiceImpl implements ICategoryService{
    private ICategoryRepository categoryRepository;

    public CategoryServiceImpl(ICategoryRepository categoryRepository) {
        this.categoryRepository = categoryRepository;
    }

    @Override
    public List<Category> getAllCategory() {
        return categoryRepository.findAll();
    }

    @Override
    public Category createNewCategory(String categoryName) {
        Category newCate = new Category();
        newCate.setCategoryName(categoryName);
        return categoryRepository.save(newCate);
    }

    @Override
    public Category updateCategory(int categoryId, String newCategoryName) {
        Category categoryFound = categoryRepository.findById(categoryId)
            .orElseThrow(() -> new EntityNotFoundException("Category not found with id: " + categoryId));
        categoryFound.setCategoryName(newCategoryName);
        return categoryRepository.save(categoryFound);
        
    }

    @Override
    public void deleteCategory(int categoryId) {
        categoryRepository.deleteById(categoryId);
    }
    
}
