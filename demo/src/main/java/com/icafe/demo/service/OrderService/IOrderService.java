package com.icafe.demo.service.OrderService;

import com.icafe.demo.dto.OrderRequestDTO;
import com.icafe.demo.models.Order;

public interface IOrderService {
    Order createNewOrder(OrderRequestDTO orderRequest);
    Order updateOrder(String orderCode, OrderRequestDTO orderRequestDTO);
    void deleteOrder(String orderCode);
}
