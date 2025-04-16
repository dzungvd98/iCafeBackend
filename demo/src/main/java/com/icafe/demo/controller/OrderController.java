package com.icafe.demo.controller;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.http.HttpStatus;
import org.springframework.http.ResponseEntity;
import org.springframework.security.access.prepost.PreAuthorize;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.RestController;

import com.icafe.demo.dto.OrderRequestDTO;
import com.icafe.demo.enums.OrderStatus;
import com.icafe.demo.service.OrderProductService.IOrderProductService;
import com.icafe.demo.service.OrderService.IOrderService;

import jakarta.validation.constraints.Max;
import jakarta.validation.constraints.Min;

import org.springframework.web.bind.annotation.CrossOrigin;
import org.springframework.web.bind.annotation.DeleteMapping;
import org.springframework.web.bind.annotation.PatchMapping;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.PutMapping;
import org.springframework.web.bind.annotation.RequestBody;
import org.springframework.web.bind.annotation.GetMapping;




@RestController
@RequestMapping("/orders/")
@CrossOrigin
public class OrderController {
    @Autowired
    private IOrderService orderService;

    @Autowired
    private IOrderProductService orderProductService;

    @GetMapping
    @PreAuthorize("hasAnyRole('ADMIN', 'MANAGER', 'STAFF')")
    public ResponseEntity<?> getOrders(@RequestParam(defaultValue = "") String keyword,
                                    @RequestParam(defaultValue = "1") @Min(1) int page, 
                                    @RequestParam(defaultValue = "10") @Min(1) @Max(20) int size) {
        try {
            return ResponseEntity.ok(orderService.getOrders(keyword, page, size)) ;
        } catch (Exception e) {
            System.out.println(e);
            return ResponseEntity.status(HttpStatus.INTERNAL_SERVER_ERROR).body(e.getMessage());
        }
    }
    
    @GetMapping("/{orderCode}/")
    @PreAuthorize("hasAnyRole('ADMIN', 'MANAGER', 'STAFF')")
    public ResponseEntity<?>  getDetailOrderByCode(@PathVariable String orderCode) {
        try {
            return ResponseEntity.ok(orderService.getOrderByOrderCode(orderCode)) ;
        } catch (Exception e) {
            System.out.println(e);
            return ResponseEntity.status(HttpStatus.INTERNAL_SERVER_ERROR).body(e.getMessage());
        }
    }
    

    @PostMapping
    @PreAuthorize("hasAnyRole('ADMIN', 'MANAGER', 'STAFF')")
    public ResponseEntity<?> createNewOrder(@RequestBody OrderRequestDTO orderRequest) {
        try {
            return ResponseEntity.ok(orderService.createNewOrder(orderRequest)) ;
        } catch (Exception e) {
            System.out.println(e);
            return ResponseEntity.status(HttpStatus.INTERNAL_SERVER_ERROR).body(e.getMessage());
        }
    }
    
    @PutMapping("/{orderCode}/")
    @PreAuthorize("hasAnyRole('ADMIN', 'MANAGER', 'STAFF')")
    public ResponseEntity<?> updateOrder(@PathVariable String orderCode, @RequestBody OrderRequestDTO orderRequest) {
        try {
            return ResponseEntity.ok(orderService.updateOrder(orderCode, orderRequest)) ;
        } catch (Exception e) {
            System.out.println(e);
            return ResponseEntity.status(HttpStatus.INTERNAL_SERVER_ERROR).body(e.getMessage());
        }
    }

    @DeleteMapping("/{orderCode}/")
    @PreAuthorize("hasAnyRole('ADMIN', 'MANAGER', 'STAFF')")
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
    @PreAuthorize("hasAnyRole('ADMIN', 'MANAGER', 'STAFF')")
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
    @PreAuthorize("hasAnyRole('ADMIN', 'MANAGER', 'STAFF')")
    public ResponseEntity<?> changeOrderStatus(@PathVariable int orderProductId) {
        try {
            orderProductService.cancelOrderProduct(orderProductId);
            return ResponseEntity.ok("Product have been cancel!");
        } catch (Exception e) {
            System.out.println(e);
            return ResponseEntity.status(HttpStatus.INTERNAL_SERVER_ERROR).body(e.getMessage());
        }
    }


    @GetMapping("/next-order-code")
    public String getNextOrderCode() {
        return orderService.getNextOrderCode();
    }
    
    
}
