package com.icafe.demo.controller;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.http.HttpStatus;
import org.springframework.http.ResponseEntity;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.RestController;

import com.icafe.demo.dto.OrderRequestDTO;
import com.icafe.demo.enums.OrderStatus;
import com.icafe.demo.service.OrderProductService.IOrderProductService;
import com.icafe.demo.service.OrderService.IOrderService;

import org.springframework.web.bind.annotation.DeleteMapping;
import org.springframework.web.bind.annotation.PatchMapping;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.PutMapping;
import org.springframework.web.bind.annotation.RequestBody;



@RestController
@RequestMapping("/orders/")
public class OrderController {
    @Autowired
    private IOrderService orderService;

    @Autowired
    private IOrderProductService orderProductService;

    @PostMapping
    public ResponseEntity<?> createNewOrder(@RequestBody OrderRequestDTO orderRequest) {
        try {
            return ResponseEntity.ok(orderService.createNewOrder(orderRequest)) ;
        } catch (Exception e) {
            System.out.println(e);
            return ResponseEntity.status(HttpStatus.INTERNAL_SERVER_ERROR).body(e.getMessage());
        }
    }
    
    @PutMapping("/{orderCode}/")
    public ResponseEntity<?> updateOrder(@PathVariable String orderCode, @RequestBody OrderRequestDTO orderRequest) {
        try {
            return ResponseEntity.ok(orderService.updateOrder(orderCode, orderRequest)) ;
        } catch (Exception e) {
            System.out.println(e);
            return ResponseEntity.status(HttpStatus.INTERNAL_SERVER_ERROR).body(e.getMessage());
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

    @PatchMapping("/{orderCode}/")
    public ResponseEntity<?> changeOrderStatus(@PathVariable String orderCode, @RequestParam OrderStatus status) {
        try {
            orderService.changeOrderStatus(orderCode, status);
            return ResponseEntity.ok("Status of order with code " + orderCode + " have been changed!");
        } catch (Exception e) {
            System.out.println(e);
            return ResponseEntity.status(HttpStatus.INTERNAL_SERVER_ERROR).body(e.getMessage());
        }
    }

    @PatchMapping("/cancel-order-product/{orderProductId}")
    public ResponseEntity<?> changeOrderStatus(@PathVariable int orderProductId) {
        try {
            orderProductService.cancelOrderProduct(orderProductId);
            return ResponseEntity.ok("Product have been cancel!");
        } catch (Exception e) {
            System.out.println(e);
            return ResponseEntity.status(HttpStatus.INTERNAL_SERVER_ERROR).body(e.getMessage());
        }
    }
    
}
