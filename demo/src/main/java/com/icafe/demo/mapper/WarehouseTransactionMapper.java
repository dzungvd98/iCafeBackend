package com.icafe.demo.mapper;

import org.modelmapper.ModelMapper;
import org.springframework.stereotype.Service;

import com.icafe.demo.dto.WarehouseTransactionRequestDTO;
import com.icafe.demo.models.Warehouse;
import com.icafe.demo.models.WarehouseTransaction;

@Service
public class WarehouseTransactionMapper {
    private final ModelMapper modelMapper;

    public WarehouseTransactionMapper(ModelMapper modelMapper) {
        this.modelMapper = modelMapper;
    }

    public WarehouseTransaction toEntity(WarehouseTransactionRequestDTO transactionDTO, Warehouse warehouse) {
        WarehouseTransaction warehouseTransaction = modelMapper.map(transactionDTO, WarehouseTransaction.class);
        warehouseTransaction.setId(null);
        warehouseTransaction.setWarehouse(warehouse);
        return warehouseTransaction;
    }

}
