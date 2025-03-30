package com.icafe.demo.controller;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.http.HttpStatus;
import org.springframework.http.ResponseEntity;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RestController;

import com.icafe.demo.dto.WarehouseRequestDTO;
import com.icafe.demo.service.WarehouseSerivce.IWarehouseService;

import org.springframework.web.bind.annotation.DeleteMapping;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PatchMapping;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestBody;
import org.springframework.web.bind.annotation.PutMapping;
import org.springframework.web.bind.annotation.PathVariable;


@RestController
@RequestMapping("/warehouses/")
public class WarehouseController {
    @Autowired
    private IWarehouseService  warehouseService;

    @GetMapping("items")
    public ResponseEntity<?> getAllItemInWarehouse() {
        try {
            return ResponseEntity.ok(warehouseService.getAllItemInWarehouse());
        } catch (Exception e) {
            System.out.println(e);
            return ResponseEntity.status(HttpStatus.INTERNAL_SERVER_ERROR).body("An error occurred, please try again!");
        }
    }

    @PostMapping
    public ResponseEntity<?> createItemInWarehouse(@RequestBody WarehouseRequestDTO warehouseRequestDTO) {
        try {
            return ResponseEntity.ok(warehouseService.createNewItemInWarehouse(warehouseRequestDTO));
        } catch (Exception e) {
            System.out.println(e);
            return ResponseEntity.status(HttpStatus.INTERNAL_SERVER_ERROR).body("An error occurred, please try again!");
        }
    }


    @PutMapping("/{itemId}")
    public ResponseEntity<?> updateItemInWarehouse(@PathVariable int itemId, @RequestBody WarehouseRequestDTO warehouseRequestDTO) {
        try {
            return ResponseEntity.ok(warehouseService.updateItemInWarehouse(itemId, warehouseRequestDTO));
        } catch (Exception e) {
            System.out.println(e);
            return ResponseEntity.status(HttpStatus.INTERNAL_SERVER_ERROR).body("An error occurred, please try again!");
        }
    }

    @DeleteMapping("/{itemId}")
    public ResponseEntity<?> deleteItemInWarehouse(@PathVariable int itemId) {
        try {
            warehouseService.deleteItemInWarehouse(itemId);
            return ResponseEntity.ok("Item is deleted!");
        } catch (Exception e) {
            System.out.println(e);
            return ResponseEntity.status(HttpStatus.INTERNAL_SERVER_ERROR).body("An error occurred, please try again!");
        }
    }

    @PatchMapping("/{itemId}/recover")
    public ResponseEntity<?> recoverDeletedItemInWarehouse(@PathVariable int itemId) {
        try {
            warehouseService.recoverDeletedItemInWarehouse(itemId);
            return ResponseEntity.ok("Item is recovered!");
        } catch (Exception e) {
            System.out.println(e);
            return ResponseEntity.status(HttpStatus.INTERNAL_SERVER_ERROR).body("An error occurred, please try again!");
        }
    }

}
