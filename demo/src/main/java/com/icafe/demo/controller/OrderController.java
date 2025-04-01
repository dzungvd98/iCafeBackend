package com.icafe.demo.controller;

import java.time.LocalDate;
import java.time.LocalDateTime;
import java.time.LocalTime;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.format.annotation.DateTimeFormat;
import org.springframework.http.HttpStatus;
import org.springframework.http.ResponseEntity;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.RestController;

import com.icafe.demo.dto.OrderRequestDTO;
import com.icafe.demo.dto.OrderStatisticsResponseDTO;
import com.icafe.demo.enums.OrderStatus;
import com.icafe.demo.service.OrderService.IOrderService;

import org.springframework.web.bind.annotation.DeleteMapping;
import org.springframework.web.bind.annotation.PatchMapping;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.PutMapping;
import org.springframework.web.bind.annotation.RequestBody;
import org.springframework.web.bind.annotation.GetMapping;



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

    @GetMapping("/statistics")
    public ResponseEntity<?> getStatisticOfOrder(@RequestParam @DateTimeFormat(pattern = "dd/MM/yyyy") LocalDate startDate,
                                                @RequestParam @DateTimeFormat(pattern = "dd/MM/yyyy") LocalDate endDate) {
        try {
            LocalDateTime startDateTime = startDate.atStartOfDay();
            LocalDateTime endDateTime = endDate.atTime(LocalTime.MAX); 
            OrderStatisticsResponseDTO statistics = orderService.getOrderSatistics(startDateTime, endDateTime);
            return ResponseEntity.ok(statistics);
        } catch (Exception e) {
            System.out.println(e);
            return ResponseEntity.status(HttpStatus.INTERNAL_SERVER_ERROR).body(e.getMessage());
        }
    }
    
    
}
