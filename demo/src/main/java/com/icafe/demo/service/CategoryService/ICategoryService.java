package com.icafe.demo.service.CategoryService;

import java.util.List;

import com.icafe.demo.models.Category;

public interface ICategoryService {
    public List<Category> getAllCategory();
    public Category createNewCategory(String categoryName);
    public Category updateCategory(int categoryId, String newCategoryName);
    public void deleteCategory(int categoryId);
}
