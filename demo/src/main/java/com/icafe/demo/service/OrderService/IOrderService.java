package com.icafe.demo.service.OrderService;


import java.util.List;

import com.icafe.demo.dto.OrderProductResponseDTO;
import com.icafe.demo.dto.OrderRequestDTO;
import com.icafe.demo.dto.OrderResponseDTO;
import com.icafe.demo.dto.PagingDataDTO;
import com.icafe.demo.enums.OrderStatus;
import com.icafe.demo.models.Order;

public interface IOrderService {

    PagingDataDTO<OrderResponseDTO> getOrders();
    List<OrderProductResponseDTO> getOrderByOrderCode(String orderCode);
    Order createNewOrder(OrderRequestDTO orderRequest);
    Order updateOrder(String orderCode, OrderRequestDTO orderRequestDTO);
    void deleteOrder(String orderCode);
    void changeOrderStatus(String orderCode, OrderStatus status);
}
