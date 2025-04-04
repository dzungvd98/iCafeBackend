package com.icafe.demo.controller;

import org.springframework.web.bind.annotation.RestController;

import com.icafe.demo.dto.ProductIngredientRequestDTO;
import com.icafe.demo.dto.ProductRequestDTO;
import com.icafe.demo.enums.Status;
import com.icafe.demo.service.ProductIngredientService.IProductIngredientService;
import com.icafe.demo.service.ProductService.IProductService;

import jakarta.validation.constraints.Max;
import jakarta.validation.constraints.Min;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.http.HttpStatus;
import org.springframework.http.ResponseEntity;
import org.springframework.web.bind.annotation.DeleteMapping;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.RequestBody;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.PutMapping;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PatchMapping;






@RestController
@RequestMapping("/products/")
public class ProductController {
    @Autowired
    private IProductService productService;

    @Autowired
    private IProductIngredientService productIngredientService;

    @GetMapping
    public ResponseEntity<?> getProducts(@RequestParam(defaultValue = "") String keyword,
                                        @RequestParam(defaultValue = "0") @Min(0) int page, 
                                        @RequestParam(defaultValue = "10") @Min(1) @Max(20) int size) {
        try {
            return ResponseEntity.ok(productService.getProducts(keyword, page, size));
        } catch (Exception e) {
            System.out.println(e);
            return ResponseEntity.status(HttpStatus.INTERNAL_SERVER_ERROR).body("An error occurred, please try again!");
        }
    }
    

    @PostMapping
    public ResponseEntity<?> createNewProduct(@RequestBody ProductRequestDTO request) {
        try {
            
            return ResponseEntity.ok(productService.createNewProduct(request));
        } catch (Exception e) {
            System.out.println(e);
            return ResponseEntity.status(HttpStatus.INTERNAL_SERVER_ERROR).body("An error occurred, please try again!");
        }
    }

    @PutMapping("{productId}/")
    public ResponseEntity<?> updateProduct(@PathVariable int productId, @RequestBody ProductRequestDTO request) {
        try {
            return ResponseEntity.ok(productService.updateProduct(productId, request));
        } catch (Exception e) {
            System.out.println(e);
            return ResponseEntity.status(HttpStatus.INTERNAL_SERVER_ERROR).body("An error occurred, please try again!");
        }
    }
    
    @DeleteMapping("/{productId}")
    public ResponseEntity<?> deleteProduct(@PathVariable int productId) {
        try {
            productService.deleteProductById(productId);
            return ResponseEntity.ok("Product have been deleted!");
        } catch (Exception e) {
            System.out.println(e);
            return ResponseEntity.status(HttpStatus.INTERNAL_SERVER_ERROR).body("An error occurred, please try again!");
        }
    }

    @PatchMapping("/{productId}/recover")
    public ResponseEntity<?> recoverDeletedProduct(@PathVariable int productId) {
        try {
            productService.recoverDeletedProduct(productId);
            return ResponseEntity.ok("Product have been recovered!");
        } catch (Exception e) {
            System.out.println(e);
            return ResponseEntity.status(HttpStatus.INTERNAL_SERVER_ERROR).body("An error occurred, please try again!");
        }
    }

    @PatchMapping("/{productId}/")
    public ResponseEntity<?> changeProductStatus(@PathVariable int productId, @RequestParam Status status) {
        try {
            productService.changeProductStatus(productId, status);
            return ResponseEntity.ok("Product status have been changed!");
        } catch (Exception e) {
            System.out.println(e);
            return ResponseEntity.status(HttpStatus.INTERNAL_SERVER_ERROR).body("An error occurred, please try again!");
        }
    }

    @GetMapping("/{productId}/ingredients")
    public ResponseEntity<?> getIngrediensOfProduct(int productId) {
        try {
            return ResponseEntity.ok(productIngredientService.getAllIngredientsOfProduct(productId));
        } catch (Exception e) {
            System.out.println(e);
            return ResponseEntity.status(HttpStatus.INTERNAL_SERVER_ERROR).body(e);
        }
    }
    
    @PostMapping("/{productId}/ingredients")
    public ResponseEntity<?> createProductIngredients(int productId,@RequestBody List<ProductIngredientRequestDTO> ingredients) {
        try {
            return ResponseEntity.ok(productIngredientService.createNewProductIngredients(productId, ingredients));
        } catch (Exception e) {
            System.out.println(e);
            return ResponseEntity.status(HttpStatus.INTERNAL_SERVER_ERROR).body(e);
        }
    }
    
    @PutMapping("/{productId}/ingredients")
    public ResponseEntity<?> updateProductIngredients(int productId,@RequestBody List<ProductIngredientRequestDTO> ingredients) {
        try {
            return ResponseEntity.ok(productIngredientService.updateProductIngredients(productId, ingredients));
        } catch (Exception e) {
            System.out.println(e);
            return ResponseEntity.status(HttpStatus.INTERNAL_SERVER_ERROR).body(e);
        }
    }

    @DeleteMapping("/{productId}/ingredients")
    public ResponseEntity<?> updateProductIngredients(int productId) {
        try {
            productIngredientService.deleteProductIngredientsOfProductId(productId);
            return ResponseEntity.ok("Recipe is deleted!");
        } catch (Exception e) {
            System.out.println(e);
            return ResponseEntity.status(HttpStatus.INTERNAL_SERVER_ERROR).body(e);
        }
    }

    @GetMapping("/{productId}/detail")
    public ResponseEntity<?> getProductDetail(int productId) {
        try {
            return ResponseEntity.ok(productService.getProductDetail(productId));
        } catch (Exception e) {
            System.out.println(e);
            return ResponseEntity.status(HttpStatus.INTERNAL_SERVER_ERROR).body(e.getMessage());
        }
    }
    
}
