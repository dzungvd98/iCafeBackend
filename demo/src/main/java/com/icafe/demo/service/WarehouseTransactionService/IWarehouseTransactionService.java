package com.icafe.demo.service.WarehouseTransactionService;

import com.icafe.demo.dto.WarehouseTransactionRequestDTO;
import com.icafe.demo.models.WarehouseTransaction;

public interface IWarehouseTransactionService {
    WarehouseTransaction createNewTransaction(WarehouseTransactionRequestDTO transactionRequest);
    WarehouseTransaction updateTransaction(int transactionId, WarehouseTransactionRequestDTO transactionRequest);
    void softDeleteTransaction(int transactionId);
    void recoverTransaction(int transactionId);
}
