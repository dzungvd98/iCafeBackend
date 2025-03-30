package com.icafe.demo.mapper;

import org.modelmapper.ModelMapper;
import org.springframework.stereotype.Service;

import com.icafe.demo.dto.WarehouseRequestDTO;
import com.icafe.demo.models.Warehouse;

@Service
public class WarehouseMapper {
    private final ModelMapper modelMapper;

    public WarehouseMapper(ModelMapper modelMapper) {
        this.modelMapper = modelMapper;
    }

    public Warehouse toEntity(WarehouseRequestDTO warehouseRequestDTO) {
        return modelMapper.map(warehouseRequestDTO, Warehouse.class);
    }

    public WarehouseRequestDTO toDTO(Warehouse warehouse) {
        return modelMapper.map(warehouse, WarehouseRequestDTO.class);
    }

}
