package com.icafe.demo.dto;

import java.util.List;

import lombok.Builder;
import lombok.Data;

@Data
@Builder
public class OrderRequestDTO {
    List<OrderProductRequestDTO> orderProducts;
}
