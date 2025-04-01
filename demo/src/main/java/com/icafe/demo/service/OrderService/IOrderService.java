package com.icafe.demo.service.OrderService;

import java.time.LocalDateTime;

import com.icafe.demo.dto.OrderRequestDTO;
import com.icafe.demo.dto.OrderStatisticsResponseDTO;
import com.icafe.demo.enums.OrderStatus;
import com.icafe.demo.models.Order;

public interface IOrderService {
    Order createNewOrder(OrderRequestDTO orderRequest);
    Order updateOrder(String orderCode, OrderRequestDTO orderRequestDTO);
    void deleteOrder(String orderCode);
    void changeOrderStatus(String orderCode, OrderStatus status);
    OrderStatisticsResponseDTO getOrderSatistics(LocalDateTime startDate, LocalDateTime endDate);
}
