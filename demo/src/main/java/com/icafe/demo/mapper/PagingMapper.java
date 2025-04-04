package com.icafe.demo.mapper;

import java.util.function.Function;

import org.springframework.data.domain.Page;

import com.icafe.demo.dto.PagingDataDTO;

public class PagingMapper {
     public static <T, D> PagingDataDTO<D> map(Page<T> page, Function<T, D> converter) {
        PagingDataDTO<D> dto = new PagingDataDTO<>();
        dto.setContents(page.getContent().stream().map(converter).toList());
        dto.setPageNumber(page.getNumber());
        dto.setPageSize(page.getSize());
        dto.setTotalPages(page.getTotalPages());
        dto.setTotalElements((int) page.getTotalElements());
        dto.setNumberOfElements(page.getNumberOfElements());
        return dto;
    }
}
