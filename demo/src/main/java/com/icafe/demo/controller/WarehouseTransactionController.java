package com.icafe.demo.controller;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.http.HttpStatus;
import org.springframework.http.ResponseEntity;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RestController;

import com.icafe.demo.dto.WarehouseTransactionRequestDTO;
import com.icafe.demo.service.WarehouseTransactionService.IWarehouseTransactionService;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestBody;
import org.springframework.web.bind.annotation.PutMapping;
import org.springframework.web.bind.annotation.DeleteMapping;
import org.springframework.web.bind.annotation.PatchMapping;
import org.springframework.web.bind.annotation.PathVariable;



@RestController
@RequestMapping("/warehouse-transactions")
public class WarehouseTransactionController {
    @Autowired
    private IWarehouseTransactionService warehouseTransactionService;

    @PostMapping
    public ResponseEntity<?> createNewTransaction(@RequestBody WarehouseTransactionRequestDTO transactionRequest) {
        try {
            return ResponseEntity.ok(warehouseTransactionService.createNewTransaction(transactionRequest));
        } catch (Exception e) {
            System.out.println(e);
            return ResponseEntity.status(HttpStatus.INTERNAL_SERVER_ERROR).body("An error occurred, please try again!");
        }
    }

    @PutMapping("/{transactionId}/")
    public ResponseEntity<?> updateTransaction(@PathVariable int transactionId, @RequestBody WarehouseTransactionRequestDTO transactionRequest) {
        try {
            return ResponseEntity.ok(warehouseTransactionService.updateTransaction(transactionId, transactionRequest));
        } catch (Exception e) {
            System.out.println(e);
            return ResponseEntity.status(HttpStatus.INTERNAL_SERVER_ERROR).body(e);
        }
    }

    @DeleteMapping("/{transactionId}/")
    public ResponseEntity<?> deleteTransaction(@PathVariable int transactionId) {
        try {
            warehouseTransactionService.softDeleteTransaction(transactionId);
            return ResponseEntity.ok("Transaction is deleted!");
        } catch (Exception e) {
            System.out.println(e);
            return ResponseEntity.status(HttpStatus.INTERNAL_SERVER_ERROR).body(e);
        }
    }

    @PatchMapping("/{transactionId}/")
    public ResponseEntity<?> recoverDeletedTransaction(@PathVariable int transactionId) {
        try {
            warehouseTransactionService.recoverTransaction(transactionId);
            return ResponseEntity.ok("Transaction is recovered!");
        } catch (Exception e) {
            System.out.println(e);
            return ResponseEntity.status(HttpStatus.INTERNAL_SERVER_ERROR).body(e);
        }
    }
    
}
