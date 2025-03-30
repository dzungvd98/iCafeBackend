package com.icafe.demo.service.WarehouseTransactionService;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import com.icafe.demo.dto.WarehouseTransactionRequestDTO;
import com.icafe.demo.enums.TransactionType;
import com.icafe.demo.mapper.WarehouseTransactionMapper;
import com.icafe.demo.models.Warehouse;
import com.icafe.demo.models.WarehouseTransaction;
import com.icafe.demo.repository.IWarehouseRepository;
import com.icafe.demo.repository.IWarehouseTransactionRepository;

import jakarta.persistence.EntityNotFoundException;

@Service
public class WarehouseTransactionService implements IWarehouseTransactionService{
    @Autowired
    private IWarehouseTransactionRepository warehouseTransactionRepository;

    @Autowired
    private WarehouseTransactionMapper transactionMapper;

    @Autowired
    private IWarehouseRepository warehouseRepository;

    @Transactional
    public WarehouseTransaction createNewTransaction(WarehouseTransactionRequestDTO transactionRequest) {
        Warehouse warehouse = warehouseRepository.findById(transactionRequest.getWareHouseId())
            .orElseThrow(() -> new EntityNotFoundException("Warehouse item not found!"));
        
        WarehouseTransaction transaction = transactionMapper.toEntity(transactionRequest, warehouse);
        int transactionQuantity = transaction.getQuantity();
        
        transaction = warehouseTransactionRepository.save(transaction);

        int updatedQuantity = adjustWarehouseQuantity(warehouse, 0, transactionQuantity, transactionRequest.getType());
        warehouse.setQuantity(updatedQuantity);
        return transaction;
    }

    @Transactional
    public WarehouseTransaction updateTransaction(int transactionId, WarehouseTransactionRequestDTO transactionRequest) {
        Warehouse warehouse = warehouseRepository.findById(transactionRequest.getWareHouseId())
            .orElseThrow(() -> new EntityNotFoundException("Warehouse item not found!"));
        WarehouseTransaction transaction = warehouseTransactionRepository.findById(transactionId)
            .orElseThrow(() -> new EntityNotFoundException("Transaction not found"));
        
        int beforeTransactionQuantity = transaction.getQuantity();
        int newTransactionQuantity = transactionRequest.getQuantity();

        int updatedQuantity = adjustWarehouseQuantity(warehouse, beforeTransactionQuantity, newTransactionQuantity, transactionRequest.getType());

        warehouse.setQuantity(updatedQuantity); 
        
        transaction.setQuantity(transactionRequest.getQuantity());
        transaction.setTimeUse(transactionRequest.getTimeUse());
        transaction.setTotalPrice(transactionRequest.getTotalPrice());
        transaction.setWarehouse(warehouse);
        
        return transaction;
    }

    @Transactional
    public void softDeleteTransaction(int transactionId) {
        WarehouseTransaction transaction = warehouseTransactionRepository.findById(transactionId)
            .orElseThrow(() -> new EntityNotFoundException("Transaction not found with id: " + transactionId));
        
        if (transaction.isDeleted()) {
            return; 
        }

        transaction.setDeleted(true);
        Warehouse warehouse = transaction.getWarehouse();
        int transactionQuantity = transaction.getQuantity();
        int updatedQuantity = adjustWarehouseQuantity(warehouse, transactionQuantity, 0, transaction.getType());
        warehouse.setQuantity(updatedQuantity);
    }

    @Transactional
    public void recoverTransaction(int transactionId) {
        WarehouseTransaction transaction = warehouseTransactionRepository.findById(transactionId)
            .orElseThrow(() -> new EntityNotFoundException("Transaction not found with id: " + transactionId));
        if (!transaction.isDeleted()) {
            return; 
        }
        transaction.setDeleted(false);
        Warehouse warehouse = transaction.getWarehouse();
        int transactionQuantity = transaction.getQuantity();
        int updatedQuantity = adjustWarehouseQuantity(warehouse, 0, transactionQuantity, transaction.getType());
        warehouse.setQuantity(updatedQuantity);
    }

    private int adjustWarehouseQuantity(Warehouse warehouse, int oldQuantity, int newQuantity, TransactionType type) {
        int currentQuantity = warehouse.getQuantity();
        
        int updatedQuantity = type.equals(TransactionType.IMPORT) 
            ? currentQuantity - oldQuantity + newQuantity 
            : currentQuantity + oldQuantity - newQuantity;

        if(updatedQuantity < 0) {
            throw new IllegalStateException("Insufficient quantity in warehouse");
        }
        
        return updatedQuantity;
    }

}
