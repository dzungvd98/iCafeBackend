package com.icafe.demo.service.SatisticsService;

import java.math.BigDecimal;
import java.time.LocalDateTime;
import java.util.List;
import java.util.stream.Collectors;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.data.domain.Page;
import org.springframework.data.domain.PageRequest;
import org.springframework.data.domain.Pageable;
import org.springframework.data.jpa.domain.Specification;
import org.springframework.stereotype.Service;

import com.icafe.demo.dto.OrderStatisticsResponseDTO;
import com.icafe.demo.dto.TopSellingProductResponseDTO;
import com.icafe.demo.enums.OrderStatus;
import com.icafe.demo.enums.ProductSaleSortType;
import com.icafe.demo.models.OrderProduct;
import com.icafe.demo.repository.IOrderProductRepository;
import com.icafe.demo.repository.IOrderRepository;
import com.icafe.demo.specification.OrderProductSpecification;

@Service
public class SatisticsService implements ISatisticsService{
    @Autowired
    private IOrderProductRepository orderProductRepository;

    @Autowired
    private IOrderRepository orderRepository;

    @Override
    public List<TopSellingProductResponseDTO> getTopSellingProduct(LocalDateTime startDate, LocalDateTime endDate, int topN, ProductSaleSortType sortType) {
    Specification<OrderProduct> spec = OrderProductSpecification.getTopSellingProductSpec(startDate, endDate, sortType);
    Pageable pageable = PageRequest.of(0, topN);
    
    Page<OrderProduct> results = orderProductRepository.findAll(spec, pageable);
    
    return results.getContent().stream()
        .map(orderProduct -> {
            String productCode = orderProduct.getProduct().getProductCode();
            String productName = orderProduct.getProduct().getProductName();
            Integer quantitySold = orderProduct.getQuantity(); 
            BigDecimal totalRevenue = orderProduct.getPriceEach().multiply(new BigDecimal(orderProduct.getQuantity()));
            
            return new TopSellingProductResponseDTO(productCode, productName, quantitySold, totalRevenue);
        })
        .collect(Collectors.toList());
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
        Double averageOrderValue = orderRepository.getAverageOrderValue(startDate, endDate);

        statistics.setAverageOrderValue(averageOrderValue);
        statistics.setCancelledOrder(cancelledOrder);
        statistics.setTotalOrder(totalOrder);
        statistics.setSuccessfullOrder(successfullOrder);

        return statistics;
    }
}
    
