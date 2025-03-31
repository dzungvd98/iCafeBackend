package com.icafe.demo.controller;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.http.HttpStatus;
import org.springframework.http.ResponseEntity;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RestController;

import com.icafe.demo.dto.OrderRequestDTO;
import com.icafe.demo.service.OrderService.IOrderService;

import org.springframework.web.bind.annotation.DeleteMapping;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.PutMapping;
import org.springframework.web.bind.annotation.RequestBody;


@RestController
@RequestMapping("/orders/")
public class OrderController {
    @Autowired
    private IOrderService orderService;

    @PostMapping
    public ResponseEntity<?> createNewOrder(@RequestBody OrderRequestDTO orderRequest) {
        try {
            return ResponseEntity.ok(orderService.createNewOrder(orderRequest)) ;
        } catch (Exception e) {
            System.out.println(e);
            return ResponseEntity.status(HttpStatus.INTERNAL_SERVER_ERROR).body(e);
        }
    }
    
    @PutMapping("/{orderCode}/")
    public ResponseEntity<?> updateOrder(@PathVariable String orderCode, @RequestBody OrderRequestDTO orderRequest) {
        try {
            return ResponseEntity.ok(orderService.updateOrder(orderCode, orderRequest)) ;
        } catch (Exception e) {
            System.out.println(e);
            return ResponseEntity.status(HttpStatus.INTERNAL_SERVER_ERROR).body(e);
        }
    }

    @DeleteMapping("/{orderCode}/")
    public ResponseEntity<?> deleteOrder(@PathVariable String orderCode) {
        try {
            orderService.deleteOrder(orderCode);
            return ResponseEntity.ok("Order have been deleted!") ;
        } catch (Exception e) {
            System.out.println(e);
            return ResponseEntity.status(HttpStatus.INTERNAL_SERVER_ERROR).body(e.getMessage());
        }
    }
    

}
