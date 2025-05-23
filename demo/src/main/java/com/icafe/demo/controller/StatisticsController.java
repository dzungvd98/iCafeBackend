package com.icafe.demo.controller;

import java.time.LocalDate;
import java.time.LocalDateTime;
import java.time.LocalTime;
import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.format.annotation.DateTimeFormat;
import org.springframework.http.HttpStatus;
import org.springframework.http.ResponseEntity;
import org.springframework.security.access.prepost.PreAuthorize;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RestController;

import com.icafe.demo.dto.OrderStatisticsResponseDTO;
import com.icafe.demo.dto.TopSellingProductResponseDTO;
import com.icafe.demo.enums.ProductSaleSortType;
import com.icafe.demo.service.SatisticsService.ISatisticsService;

import jakarta.validation.constraints.Max;
import jakarta.validation.constraints.Min;

import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.RequestParam;


@RestController
@RequestMapping("/statistics/")
public class StatisticsController {
    @Autowired
    private ISatisticsService satisticsService;

    @GetMapping("/top-selling-products")
    public ResponseEntity<?> getTopSellingProduct(@RequestParam @DateTimeFormat(pattern = "dd/MM/yyyy") LocalDate startDate,
            @RequestParam @DateTimeFormat(pattern = "dd/MM/yyyy") LocalDate endDate,
            @RequestParam(defaultValue = "5") @Min(1) @Max(10) int topN,
            @RequestParam(required = false, defaultValue = "QUANTITY") ProductSaleSortType sortType) {
        try {
            LocalDateTime startDateTime = startDate.atStartOfDay();
            LocalDateTime endDateTime = endDate.atTime(LocalTime.MAX); 
            List<TopSellingProductResponseDTO> topProducts =  satisticsService.getTopSellingProduct(startDateTime, endDateTime, topN, sortType);
            return ResponseEntity.ok(topProducts);
        } catch (Exception e) {
            System.out.println(e);
            return ResponseEntity.status(HttpStatus.INTERNAL_SERVER_ERROR).body(e.getMessage());
        }
    }

    @GetMapping("/orders")
    public ResponseEntity<?> getStatisticOfOrder(@RequestParam @DateTimeFormat(pattern = "dd/MM/yyyy") LocalDate startDate,
                                                @RequestParam @DateTimeFormat(pattern = "dd/MM/yyyy") LocalDate endDate) {
        try {
            LocalDateTime startDateTime = startDate.atStartOfDay();
            LocalDateTime endDateTime = endDate.atTime(LocalTime.MAX); 
            OrderStatisticsResponseDTO statistics = satisticsService.getOrderSatistics(startDateTime, endDateTime);
            return ResponseEntity.ok(statistics);
        } catch (Exception e) {
            System.out.println(e);
            return ResponseEntity.status(HttpStatus.INTERNAL_SERVER_ERROR).body(e.getMessage());
        }
    }

    @GetMapping("/report/overview")
    @PreAuthorize("hasAnyRole('ADMIN', 'MANAGER')")
    public ResponseEntity<?> getReportOrderAtBetween(
                                    @RequestParam @DateTimeFormat(pattern = "dd/MM/yyyy") LocalDate dateview,
                                    @RequestParam(defaultValue = "daily") String type) {
        try {
            return ResponseEntity.ok(satisticsService.getOverviewReport(dateview, type));
        } catch (Exception e) {
            System.out.println(e);
            return ResponseEntity.status(HttpStatus.INTERNAL_SERVER_ERROR).body(e.getMessage());
        }
    }

    @GetMapping("/report/chart")
    @PreAuthorize("hasAnyRole('ADMIN', 'MANAGER')")
    public ResponseEntity<?> getDailyRevenue(@RequestParam @DateTimeFormat(pattern = "dd/MM/yyyy") LocalDate dateview,
                                            @RequestParam(defaultValue = "daily") String type) {
        try {
            return ResponseEntity.ok(satisticsService.getRevenuePeriod(dateview, type));
        } catch (Exception e) {
            System.out.println(e);
            return ResponseEntity.status(HttpStatus.INTERNAL_SERVER_ERROR).body(e.getMessage());
        }
    }
}
