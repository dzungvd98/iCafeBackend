package com.icafe.demo.service.WarehouseSerivce;

import java.util.List;

import com.icafe.demo.dto.WarehouseRequestDTO;
import com.icafe.demo.models.Warehouse;

public interface IWarehouseService {
    List<Warehouse> getAllItemInWarehouse();
    Warehouse createNewItemInWarehouse(WarehouseRequestDTO warehouseRequestDTO);
    Warehouse updateItemInWarehouse(int warehouseId, WarehouseRequestDTO warehouseRequestDTO);
    void deleteItemInWarehouse(int warehouseId);
    void recoverDeletedItemInWarehouse(int warehouseId);
}
