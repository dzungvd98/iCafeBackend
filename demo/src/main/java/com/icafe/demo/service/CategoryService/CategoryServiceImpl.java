package com.icafe.demo.service.CategoryService;

import java.time.format.DateTimeFormatter;
import java.util.List;
import java.util.Optional;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.data.domain.Page;
import org.springframework.data.domain.PageRequest;
import org.springframework.data.domain.Pageable;
import org.springframework.data.jpa.domain.Specification;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import com.icafe.demo.dto.CategoryResponseDTO;
import com.icafe.demo.dto.PagingDataDTO;
import com.icafe.demo.mapper.PagingMapper;
import com.icafe.demo.models.Category;
import com.icafe.demo.models.Product;
import com.icafe.demo.models.User;
import com.icafe.demo.repository.ICategoryRepository;
import com.icafe.demo.repository.IUserRepository;
import com.icafe.demo.specification.CategorySpecification;

import jakarta.persistence.EntityNotFoundException;

@Service
public class CategoryServiceImpl implements ICategoryService{
    @Autowired
    private ICategoryRepository categoryRepository;

    @Autowired
    private IUserRepository userRepository;

    public CategoryServiceImpl(ICategoryRepository categoryRepository) {
        this.categoryRepository = categoryRepository;
    }

    @Override
    public List<Category> getAllCategory() {
        return categoryRepository.findAll();
    }

    @Override
    public Category createNewCategory(String categoryName) {
        categoryRepository.findByCategoryName(categoryName)
        .ifPresent(c -> {
            throw new IllegalArgumentException("Đã tồn tại danh mục với tên: " + categoryName);
        });

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

    @Transactional
    public void deleteCategory(int categoryId) {
        Category categoryFound = categoryRepository.findById(categoryId)
            .orElseThrow(() -> new EntityNotFoundException("Category not found with id: " + categoryId));
        categoryFound.setDeleted(true);
        for(Product product : categoryFound.getProducts()) {
            product.setDeleted(true);
        }
        categoryRepository.save(categoryFound);
    }

    public PagingDataDTO<CategoryResponseDTO> getPageCategory(String keyword, int page, int size) {
        Pageable pageable = PageRequest.of(page - 1, size);
        Specification<Category> spec = Specification.where(CategorySpecification.hasSearchKeyword(keyword));
        Page<Category> categoryPage = categoryRepository.findAll(spec, pageable);
        DateTimeFormatter formatter = DateTimeFormatter.ofPattern("HH:mm:ss dd/MM/yyyy");
        return PagingMapper.map(categoryPage, category -> {
            String username = Optional.ofNullable(category.getUpdatedBy())
                    .flatMap(userRepository::findById)
                    .map(User::getUsername)
                    .orElse(null);
            return new CategoryResponseDTO(
                category.getId(),
                category.getCategoryName(),
                category.getUpdatedAt().format(formatter),
                username,
                category.getProducts().size()
            );
        });
    }
    
}
