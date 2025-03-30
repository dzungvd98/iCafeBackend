package com.icafe.demo.service.WarehouseSerivce;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.icafe.demo.dto.WarehouseRequestDTO;
import com.icafe.demo.mapper.WarehouseMapper;
import com.icafe.demo.models.Warehouse;
import com.icafe.demo.repository.IWarehouseRepository;

@Service
public class WarehouseService implements IWarehouseService{
    @Autowired
    private IWarehouseRepository warehouseRepository;

    @Autowired
    private WarehouseMapper warehouseMapper;

    @Override
    public Warehouse createNewItemInWarehouse(WarehouseRequestDTO warehouseRequestDTO) {
        
        warehouseRepository.findByName(warehouseRequestDTO.getName())
            .ifPresent(w -> {throw new RuntimeException("Item's name already exist!");});
        Warehouse warehouse = warehouseMapper.toEntity(warehouseRequestDTO);
        warehouse.setQuantity(0);
        return warehouseRepository.save(warehouse);
    }

    @Override
    public Warehouse updateItemInWarehouse(int warehouseId, WarehouseRequestDTO warehouseRequestDTO) {
        warehouseRepository.findByName(warehouseRequestDTO.getName())
            .ifPresent(w -> {throw new RuntimeException("Item's name already exist!");}); 

        Warehouse warehouse = warehouseRepository.findById(warehouseId) 
            .orElseThrow(() -> new RuntimeException("Item need update doesn't exist!"));
        
        warehouse.setName(warehouseRequestDTO.getName());
        warehouse.setUnit(warehouseRequestDTO.getUnit());
        warehouse.setMinQuantity(warehouseRequestDTO.getMinQuantity());
        return warehouseRepository.save(warehouse);
    }

    @Override
    public void deleteItemInWarehouse(int warehouseId) {
        Warehouse warehouse = warehouseRepository.findById(warehouseId) 
        .orElseThrow(() -> new RuntimeException("Item need update doesn't exist!"));
        warehouse.setDeleted(true);
        warehouseRepository.save(warehouse);
    }

    @Override
    public void recoverDeletedItemInWarehouse(int warehouseId) {
        Warehouse warehouse = warehouseRepository.findById(warehouseId) 
        .orElseThrow(() -> new RuntimeException("Item need update doesn't exist!"));
        warehouse.setDeleted(false);
        warehouseRepository.save(warehouse);
    }

    @Override
    public List<Warehouse> getAllItemInWarehouse() {
        return warehouseRepository.findAll();
    }
    
    
}
