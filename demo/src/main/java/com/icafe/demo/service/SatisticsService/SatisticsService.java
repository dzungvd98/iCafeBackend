package com.icafe.demo.service.SatisticsService;
import java.time.LocalDateTime;
import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.data.domain.PageRequest;
import org.springframework.data.domain.Pageable;
import org.springframework.stereotype.Service;

import com.icafe.demo.dto.OrderReportResponseDTO;
import com.icafe.demo.dto.OrderStatisticsResponseDTO;
import com.icafe.demo.dto.TopSellingProductResponseDTO;
import com.icafe.demo.enums.OrderStatus;
import com.icafe.demo.enums.ProductSaleSortType;
import com.icafe.demo.repository.IOrderProductRepository;
import com.icafe.demo.repository.IOrderRepository;

import jakarta.transaction.Transactional;



@Service
public class SatisticsService implements ISatisticsService{
    @Autowired
    private IOrderProductRepository orderProductRepository;

    @Autowired
    private IOrderRepository orderRepository;


    @Override
    public List<TopSellingProductResponseDTO> getTopSellingProduct(LocalDateTime startDate, LocalDateTime endDate, int topN, ProductSaleSortType sortBy) {
        Pageable pageable = PageRequest.of(0, topN);
        return orderProductRepository.getTopSellingProductS(startDate, endDate, sortBy.toString(), pageable);   
    }   
    
    @Override
    public OrderStatisticsResponseDTO getOrderSatistics(LocalDateTime startDate, LocalDateTime endDate) {
        if(startDate.isAfter(endDate)) {
            throw new IllegalArgumentException("Start date can't bigger than end date!");
        }
        OrderStatisticsResponseDTO statistics = new OrderStatisticsResponseDTO();
        long totalOrder = orderRepository.countByCreatedAtBetween(startDate, endDate);
        long successfullOrder = orderRepository.countByCreatedAtBetweenAndStatus(startDate, endDate, OrderStatus.COMPLETED);
        long cancelledOrder = orderRepository.countByCreatedAtBetweenAndStatus(startDate, endDate, OrderStatus.CANCELLED);
        Double averageOrderValue = orderRepository.getAverageOrderValue(startDate, endDate, OrderStatus.COMPLETED);

        statistics.setAverageOrderValue(averageOrderValue);
        statistics.setCancelledOrder(cancelledOrder);
        statistics.setTotalOrder(totalOrder);
        statistics.setSuccessfullOrder(successfullOrder);

        return statistics;
    }

    @Transactional
    public OrderReportResponseDTO getReportAtBetween(LocalDateTime startDate, LocalDateTime endDate) {
        OrderReportResponseDTO report = new OrderReportResponseDTO();
        report.setAvgOrderValue(orderRepository.getAverageOrderValue(startDate, endDate, OrderStatus.PENDING));
        report.setProfit(orderRepository.getProfitAtBetweenAndStatus(startDate, endDate, OrderStatus.PENDING));
        report.setRevenue(orderRepository.getRevenueAtBetweenAndStatus(startDate, endDate, OrderStatus.PENDING));
        report.setTotalOrderQuantity(orderRepository.countByCreatedAtBetweenAndStatus(startDate, endDate, OrderStatus.PENDING));
        return report;
    }
}
    
