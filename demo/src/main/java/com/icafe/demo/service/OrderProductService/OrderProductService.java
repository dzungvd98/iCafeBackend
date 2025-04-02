package com.icafe.demo.service.OrderProductService;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import com.icafe.demo.enums.OrderStatus;
import com.icafe.demo.models.Order;
import com.icafe.demo.models.OrderProduct;
import com.icafe.demo.repository.IOrderProductRepository;

import jakarta.persistence.EntityNotFoundException;

@Service
public class OrderProductService implements IOrderProductService{
    @Autowired
    private IOrderProductRepository orderProductRepository;

    @Transactional
    public void cancelOrderProduct(int orderProductId) {
        OrderProduct orderProduct = orderProductRepository.findById(orderProductId)
            .orElseThrow(() -> new EntityNotFoundException("Order product not found!"));
        orderProduct.setIsCancel(true);
        Order order = orderProduct.getOrder();
        boolean allCancelled = order.getOrderProducts().stream().allMatch(OrderProduct::getIsCancel);
        if (allCancelled) {
        order.setStatus(OrderStatus.CANCELLED);
        }
    }
    
}
