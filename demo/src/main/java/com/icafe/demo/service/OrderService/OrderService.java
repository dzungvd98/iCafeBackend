package com.icafe.demo.service.OrderService;

import java.math.BigDecimal;
import java.time.LocalDateTime;
import java.time.format.DateTimeFormatter;
import java.util.HashSet;
import java.util.Map;
import java.util.Set;
import java.util.stream.Collectors;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import com.icafe.demo.dto.OrderProductRequestDTO;
import com.icafe.demo.dto.OrderRequestDTO;
import com.icafe.demo.dto.OrderStatisticsResponseDTO;
import com.icafe.demo.enums.OrderStatus;
import com.icafe.demo.models.Order;
import com.icafe.demo.models.OrderProduct;
import com.icafe.demo.models.Product;
import com.icafe.demo.models.ProductVariant;
import com.icafe.demo.repository.IOrderRepository;
import com.icafe.demo.repository.IProductVariantRepository;
import com.icafe.demo.specification.OrderSpecification;

import jakarta.persistence.EntityManager;
import jakarta.persistence.EntityNotFoundException;

@Service
public class OrderService implements IOrderService{
    @Autowired
    private IOrderRepository orderRepository;

    @Autowired
    private IProductVariantRepository productVariantRepository;

    @Autowired
    private EntityManager entityManager;

    @Transactional
    public Order createNewOrder(OrderRequestDTO orderRequest) {
        orderRequest.getOrderProducts().stream()
            .findAny()
            .orElseThrow(() -> new IllegalArgumentException("Order need at least one product!"));

        Order order = new Order();
        order.setOrderCode(generateOrderCode());
        order.setStatus(OrderStatus.PENDING);
        
        Set<OrderProduct> orderProducts = new HashSet<>(); 
        BigDecimal totalPrice = new BigDecimal(0);

        for(OrderProductRequestDTO orderProductRequestDTO : orderRequest.getOrderProducts()) {
            OrderProduct orderProduct = new OrderProduct();
            ProductVariant variant = productVariantRepository.findById(orderProductRequestDTO.getProductVariantId())
                .orElseThrow(() -> new EntityNotFoundException("Not found product variant!"));
            
            Product product = variant.getProduct();
            BigDecimal price = product.getBasePrice().add(variant.getAddPrice());
            
            orderProduct.setPriceEach(price);
            orderProduct.setIsCancel(false);
            orderProduct.setQuantity(orderProductRequestDTO.getQuantity());
            orderProduct.setType(orderProductRequestDTO.getType());
            orderProduct.setSize(variant.getSize().getSizeName());
            orderProduct.setProduct(product);
            orderProduct.setOrder(order);

            orderProducts.add(orderProduct);
            totalPrice = totalPrice.add(price.multiply(BigDecimal.valueOf(orderProductRequestDTO.getQuantity())));
            
        }
        order.setOrderProducts(orderProducts);
        order.setTotalPrice(totalPrice);
        return orderRepository.save(order);
    }
    

    


    @Transactional
    public Order updateOrder(String orderCode, OrderRequestDTO orderRequestDTO) {
        orderRequestDTO.getOrderProducts().stream()
            .findAny()
            .orElseThrow(() -> new IllegalArgumentException("Order need at least one product!"));

        Order order = orderRepository.findByOrderCode(orderCode)
            .orElseThrow(() -> new EntityNotFoundException("Order with code " + orderCode + " not found!"));
    
        Set<OrderProduct> oldOrderProducts = order.getOrderProducts();
        Map<Integer, OrderProduct> oldProductsMap = oldOrderProducts.stream()
        .collect(Collectors.toMap(OrderProduct::getId, op -> op));

        BigDecimal totalPrice = BigDecimal.ZERO;

        oldOrderProducts.removeIf(op -> orderRequestDTO.getOrderProducts().stream()
            .noneMatch(req -> req.getId() != null && req.getId().equals(op.getId())));

        for(OrderProductRequestDTO orderProductRequest : orderRequestDTO.getOrderProducts()) {
            OrderProduct orderProduct = oldProductsMap.getOrDefault(orderProductRequest.getId(), new OrderProduct());

            ProductVariant variant = productVariantRepository.findById(orderProductRequest.getProductVariantId())
                .orElseThrow(() -> new EntityNotFoundException("Product variant id " + orderProductRequest.getProductVariantId() + " not found!"));

            Product product = variant.getProduct();
            BigDecimal price = product.getBasePrice().add(variant.getAddPrice());

            orderProduct.setIsCancel(orderProduct.getIsCancel() != null ? orderProduct.getIsCancel() : false);
            orderProduct.setPriceEach(price);
            orderProduct.setQuantity(orderProductRequest.getQuantity());
            orderProduct.setType(orderProductRequest.getType());
            orderProduct.setSize(variant.getSize().getSizeName());
            orderProduct.setProduct(product);
            orderProduct.setOrder(order);

            if (!oldOrderProducts.contains(orderProduct)) {
                oldOrderProducts.add(orderProduct);
            }
            totalPrice = totalPrice.add(price.multiply(BigDecimal.valueOf(orderProductRequest.getQuantity())));
        }

        order.setTotalPrice(totalPrice);

        return orderRepository.save(order);
    }

    public void deleteOrder(String orderCode) {
        Order order = orderRepository.findByOrderCode(orderCode)
            .orElseThrow(() -> new EntityNotFoundException("Order with code " + orderCode + " not found!")); 

        if(!order.getStatus().equals(OrderStatus.CANCELLED))  {
            throw new IllegalArgumentException("Just can delete order cancelled!");
        }

        orderRepository.delete(order);
    }


    private String generateOrderCode() {
        LocalDateTime now = LocalDateTime.now();
        String datePart = now.format(DateTimeFormatter.ofPattern("ddMMyyyy"));
        long orderCount = orderRepository.count(OrderSpecification.hasOrderDateOn(now)) + 1;
        String sequencePart = String.format("%02d", orderCount);
        return "HD" + datePart + "-" + sequencePart;
    }

    public void changeOrderStatus(String orderCode, OrderStatus status) {
        Order order = orderRepository.findByOrderCode(orderCode)
            .orElseThrow(() -> new EntityNotFoundException("Not found order with code " + orderCode));

        if(order.getStatus().equals(OrderStatus.PROCESSING) && status.equals(OrderStatus.CANCELLED)) {
            throw new IllegalArgumentException("Can not cancel order in progress!");
        }
        
        if(order.getStatus().equals(OrderStatus.COMPLETED) || order.getStatus().equals(OrderStatus.CANCELLED)) {
            throw new IllegalArgumentException("Can not change order with status completed or cancelled!");
        }

        order.setStatus(status);
        orderRepository.save(order);
    }





    @Override
    public OrderStatisticsResponseDTO getOrderSatistics(LocalDateTime startDate, LocalDateTime endDate) {
        OrderStatisticsResponseDTO statistics = new OrderStatisticsResponseDTO();
        long totalOrder = orderRepository.countByCreatedAtBetween(startDate, endDate);
        long successfullOrder = orderRepository.countByCreatedAtBetweenAndStatus(startDate, endDate, OrderStatus.COMPLETED);
        long cancelledOrder = orderRepository.countByCreatedAtBetweenAndStatus(startDate, endDate, OrderStatus.CANCELLED);
        Double averageOrderValue = OrderSpecification.getAverageOrderValueByOrderDateBetween(entityManager, startDate, endDate);

        statistics.setAverageOrderValue(averageOrderValue);
        statistics.setCancelledOrder(cancelledOrder);
        statistics.setTotalOrder(totalOrder);
        statistics.setSuccessfullOrder(successfullOrder);

        return statistics;
    }
}
