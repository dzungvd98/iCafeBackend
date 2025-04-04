package com.icafe.demo.dto;

import java.util.List;

import org.apache.poi.ss.formula.functions.T;

import lombok.Data;

@Data
public class PagingDataDTO<T> {
    List<T> contents;
    int pageNumber;
    int pageSize;
    int totalPages;
    int totalElements;
    int numberOfElements;
    
}
