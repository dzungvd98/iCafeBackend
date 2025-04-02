package com.icafe.demo.service.SatisticsService;

import java.time.LocalDateTime;
import java.util.List;

import com.icafe.demo.dto.OrderStatisticsResponseDTO;
import com.icafe.demo.dto.TopSellingProductResponseDTO;
import com.icafe.demo.enums.ProductSaleSortType;

public interface ISatisticsService {
    OrderStatisticsResponseDTO getOrderSatistics(LocalDateTime startDate, LocalDateTime endDate);
    List<TopSellingProductResponseDTO> getTopSellingProduct(LocalDateTime startDate, LocalDateTime endDate, int topN, ProductSaleSortType sortType);
    
} 
