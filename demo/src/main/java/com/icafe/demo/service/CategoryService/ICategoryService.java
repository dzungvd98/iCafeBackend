package com.icafe.demo.service.CategoryService;

import java.util.List;

import com.icafe.demo.dto.CategoryResponseDTO;
import com.icafe.demo.dto.PagingDataDTO;
import com.icafe.demo.models.Category;

public interface ICategoryService {
    public List<Category> getAllCategory();
    public PagingDataDTO<CategoryResponseDTO> getPageCategory(String keyword, int page, int size);
    public Category createNewCategory(String categoryName);
    public Category updateCategory(int categoryId, String newCategoryName);
    public void deleteCategory(int categoryId);
}
