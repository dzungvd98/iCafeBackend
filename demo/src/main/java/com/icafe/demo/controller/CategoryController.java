package com.icafe.demo.controller;


import java.util.Map;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.http.HttpStatus;
import org.springframework.http.ResponseEntity;
import org.springframework.security.access.prepost.PreAuthorize;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.RestController;

import com.icafe.demo.service.CategoryService.ICategoryService;
import com.icafe.demo.service.ProductService.IProductService;

import org.springframework.web.bind.annotation.DeleteMapping;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestBody;
import org.springframework.web.bind.annotation.PutMapping;
import org.springframework.web.bind.annotation.PathVariable;





@RestController
@RequestMapping("/categories/")
public class CategoryController {
    @Autowired
    private ICategoryService categoryService;

    @Autowired
    private IProductService productService;
    

    @GetMapping("/")
    @PreAuthorize("hasAnyRole('ADMIN', 'MANAGER', 'STAFF')")
    public ResponseEntity<?> getAllCategory() {
        try {
            return ResponseEntity.ok(Map.of("data", categoryService.getAllCategory()));
        } catch (Exception e) {
            System.out.println(e);
            return ResponseEntity.status(HttpStatus.INTERNAL_SERVER_ERROR).body("An error occurred, please try again!");
        }
    }

    @PostMapping("/")
    public ResponseEntity<?> createNewCategory(String newCategoryName) {
        try {
            categoryService.createNewCategory(newCategoryName);
            return ResponseEntity.ok("Category has been created successfully!");
        } catch (Exception e) {
            System.out.println(e);
            return ResponseEntity.status(HttpStatus.INTERNAL_SERVER_ERROR).body("An error occurred, please try again!");
        }
    }

    @PutMapping("/{categoryId}")
    public ResponseEntity<?> updateCategoryById(@PathVariable int categoryId, @RequestBody String newCategoryName) {
        try {
            categoryService.updateCategory(categoryId, newCategoryName);
            return ResponseEntity.ok("Category has been updated successfully!");
        } catch (Exception e) {
            System.out.println(e);
            return ResponseEntity.status(HttpStatus.INTERNAL_SERVER_ERROR).body("An error occurred, please try again!");
        }
    }

    @DeleteMapping("/{categoryId}")
    public ResponseEntity<?> deleteCategory(@PathVariable int categoryId) {
        try {
            categoryService.deleteCategory(categoryId);
            return ResponseEntity.ok("Category has been deleted successfully!");
        } catch (Exception e) {
            System.out.println(e);
            return ResponseEntity.status(HttpStatus.INTERNAL_SERVER_ERROR).body("An error occurred, please try again!");
        }
    }

    @GetMapping("/{categoryId}/products")
    public ResponseEntity<?> getListProductByCategory(
                                        @PathVariable int categoryId,
                                        @RequestParam(defaultValue = "1") int page,
                                        @RequestParam(defaultValue = "10") int size,
                                        @RequestParam(defaultValue = "") String keyword) {
        try {
            return ResponseEntity.ok(productService.getListProductByCategory(keyword, categoryId, page, size));
        } catch (Exception e) {
            System.out.println(e);
            return ResponseEntity.status(HttpStatus.INTERNAL_SERVER_ERROR).body("An error occurred, please try again!");
        }
    }
    
}
