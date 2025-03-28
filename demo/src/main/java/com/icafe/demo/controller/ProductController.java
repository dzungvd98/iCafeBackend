package com.icafe.demo.controller;

import org.springframework.web.bind.annotation.RestController;

import com.icafe.demo.dto.ProductRequestDTO;
import com.icafe.demo.service.ProductCategory.IProductService;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.http.HttpStatus;
import org.springframework.http.ResponseEntity;
import org.springframework.web.bind.annotation.DeleteMapping;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.RequestBody;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.PutMapping;





@RestController
@RequestMapping("/products/")
public class ProductController {
    @Autowired
    private IProductService productService;

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
    
}
