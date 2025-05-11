package com.icafe.demo.service.OrderService;

import java.math.BigDecimal;
import java.time.LocalDateTime;
import java.time.format.DateTimeFormatter;
import java.util.ArrayList;
import java.util.HashSet;
import java.util.List;
import java.util.Map;
import java.util.Optional;
import java.util.Set;
import java.util.stream.Collectors;

import org.springframework.data.domain.Page;
import org.springframework.data.domain.PageRequest;
import org.springframework.data.domain.Pageable;
import org.springframework.data.jpa.domain.Specification;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import com.icafe.demo.dto.OrderProductRequestDTO;
import com.icafe.demo.dto.OrderProductResponseDTO;
import com.icafe.demo.dto.OrderRequestDTO;
import com.icafe.demo.dto.OrderResponseDTO;
import com.icafe.demo.dto.PagingDataDTO;
import com.icafe.demo.enums.OrderStatus;
import com.icafe.demo.mapper.PagingMapper;
import com.icafe.demo.models.Order;
import com.icafe.demo.models.OrderProduct;
import com.icafe.demo.models.Product;
import com.icafe.demo.models.ProductVariant;
import com.icafe.demo.models.User;
import com.icafe.demo.repository.IOrderRepository;
import com.icafe.demo.repository.IProductVariantRepository;
import com.icafe.demo.repository.IUserRepository;
import com.icafe.demo.specification.OrderSpecification;

import jakarta.persistence.EntityNotFoundException;
import lombok.RequiredArgsConstructor;

@Service
@RequiredArgsConstructor
public class OrderService implements IOrderService {
    
    private final IOrderRepository orderRepository;
    private final IProductVariantRepository productVariantRepository;
    private final IUserRepository userRepository;

    @Override
    public PagingDataDTO<OrderResponseDTO> getOrders(String keyword, int page, int size) {
        Pageable pageable = PageRequest.of(page - 1, size);
        Specification<Order> spec = OrderSpecification.hasSearchKeyword(keyword);
        Page<Order> orders = orderRepository.findAll(spec, pageable);
        DateTimeFormatter formatter = DateTimeFormatter.ofPattern("HH:mm:ss dd/MM/yyyy");
        return PagingMapper.<Order, OrderResponseDTO>map(orders, (Order order) -> {
            List<OrderProductResponseDTO> orderProductDtos = getOrderByOrderCode(order.getOrderCode());
            String username = Optional.ofNullable(order.getCreatedBy())
                    .flatMap(userRepository::findById)
                    .map(User::getUsername)
                    .orElse(null);

            return new OrderResponseDTO(
                    order.getOrderCode(),
                    orderProductDtos,
                    order.getCreatedAt().format(formatter),
                    order.getTotalPrice(),
                    order.getStatus().toString().toLowerCase(),
                    username);
        });
    }

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

        for (OrderProductRequestDTO orderProductRequestDTO : orderRequest.getOrderProducts()) {
            OrderProduct orderProduct = new OrderProduct();
            ProductVariant variant = productVariantRepository.findById(orderProductRequestDTO.getProductVariantId())
                    .orElseThrow(() -> new EntityNotFoundException("Not found product variant!"));

            Product product = variant.getProduct();
            BigDecimal price = variant.getPrice();

            orderProduct.setPriceEach(price);
            orderProduct.setIsCancel(false);
            orderProduct.setQuantity(orderProductRequestDTO.getQuantity());
            orderProduct.setType(orderProductRequestDTO.getType());
            orderProduct.setSize(variant.getSize().getSizeName());
            orderProduct.setProduct(product);
            orderProduct.setOrder(order);
            orderProduct.setPercentIce(orderProductRequestDTO.getPercentIce());
            orderProduct.setPercentSugar(orderProductRequestDTO.getPercentSugar());

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

        for (OrderProductRequestDTO orderProductRequest : orderRequestDTO.getOrderProducts()) {
            OrderProduct orderProduct = oldProductsMap.getOrDefault(orderProductRequest.getId(), new OrderProduct());

            ProductVariant variant = productVariantRepository.findById(orderProductRequest.getProductVariantId())
                    .orElseThrow(() -> new EntityNotFoundException(
                            "Product variant id " + orderProductRequest.getProductVariantId() + " not found!"));

            Product product = variant.getProduct();
            BigDecimal price = product.getBasePrice().add(variant.getPrice());

            orderProduct.setIsCancel(orderProduct.getIsCancel() != null ? orderProduct.getIsCancel() : false);
            orderProduct.setPriceEach(price);
            orderProduct.setQuantity(orderProductRequest.getQuantity());
            orderProduct.setType(orderProductRequest.getType());
            orderProduct.setSize(variant.getSize().getSizeName());
            orderProduct.setProduct(product);
            orderProduct.setOrder(order);
            orderProduct.setPercentIce(orderProductRequest.getPercentIce());
            orderProduct.setPercentSugar(orderProductRequest.getPercentSugar());

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

        if (!order.getStatus().equals(OrderStatus.CANCELLED)) {
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

    @Transactional
    public void changeOrderStatus(String orderCode, OrderStatus status) {
        Order order = orderRepository.findByOrderCode(orderCode)
                .orElseThrow(() -> new EntityNotFoundException("Not found order with code " + orderCode));

        if (order.getStatus().equals(OrderStatus.PROCESSING) && status.equals(OrderStatus.CANCELLED)) {
            throw new IllegalArgumentException("Can not cancel order in progress!");
        }

        if (order.getStatus().equals(OrderStatus.COMPLETED) || order.getStatus().equals(OrderStatus.CANCELLED)) {
            throw new IllegalArgumentException("Can not change order with status completed or cancelled!");
        }

        if (status.equals(OrderStatus.CANCELLED)) {
            order.getOrderProducts().forEach(op -> op.setIsCancel(true));
        }

        order.setStatus(status);
        orderRepository.save(order);
    }

    public List<OrderProductResponseDTO> getOrderByOrderCode(String orderCode) {
        Order order = orderRepository.findByOrderCode(orderCode)
                .orElseThrow(() -> new EntityNotFoundException("Order with code " + orderCode + " not found!"));

        List<OrderProductResponseDTO> responseList = new ArrayList<>();

        for (OrderProduct od : order.getOrderProducts()) {
            ProductVariant variant = productVariantRepository.findByProductIdAndSizeSizeName(od.getProduct().getId(),
                    od.getSize());

            OrderProductResponseDTO dto = OrderProductResponseDTO.builder()
                    .productVariantId(variant != null ? variant.getId() : null)
                    .productName(variant != null && variant.getProduct() != null ? variant.getProduct().getProductName()
                            : null)
                    .size(od.getSize())
                    .percentIce(od.getPercentIce())
                    .percentSugar(od.getPercentSugar())
                    .productImgUrl(
                            variant != null && variant.getProduct() != null ? variant.getProduct().getImageUrl() : null)
                    .quantity(od.getQuantity())
                    .priceEach(variant != null ? variant.getPrice() : BigDecimal.ZERO)
                    .build();

            responseList.add(dto);

        }

        return responseList;
    }

    public String getNextOrderCode() {
        return generateOrderCode();
    }

}
