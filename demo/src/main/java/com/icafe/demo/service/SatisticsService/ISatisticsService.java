package com.icafe.demo.service.SatisticsService;

import java.time.LocalDate;
import java.time.LocalDateTime;
import java.util.List;

import com.icafe.demo.dto.OrderReportResponseDTO;
import com.icafe.demo.dto.OrderStatisticsResponseDTO;
import com.icafe.demo.dto.RevenueResponseDTO;
import com.icafe.demo.dto.TopSellingProductResponseDTO;
import com.icafe.demo.enums.ProductSaleSortType;

public interface ISatisticsService {
    OrderStatisticsResponseDTO getOrderSatistics(LocalDateTime startDate, LocalDateTime endDate);
    List<TopSellingProductResponseDTO> getTopSellingProduct(LocalDateTime startDate, LocalDateTime endDate, int topN, ProductSaleSortType sortType);
    OrderReportResponseDTO getOverviewReport(LocalDate dateView, String type);
    List<RevenueResponseDTO> getRevenuePeriod(LocalDate dateView, String type);
} 
