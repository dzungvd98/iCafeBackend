package com.icafe.demo.service.ProductVariantService;

import java.util.List;
import java.util.stream.Collectors;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.icafe.demo.dto.ProductDetailResponseDTO;
import com.icafe.demo.dto.ProductVariantResponseDTO;
import com.icafe.demo.enums.Status;
import com.icafe.demo.models.Product;
import com.icafe.demo.models.ProductVariant;
import com.icafe.demo.repository.IProductVariantRepository;

import jakarta.persistence.EntityNotFoundException;

@Service
public class ProductVariantService implements IProductVariantService{

    @Autowired
    private IProductVariantRepository productVariantRepository;

    @Override
    public ProductDetailResponseDTO findProductByVariant(int variantId) {
        ProductVariant productVariant = productVariantRepository.findById(variantId)
            .orElseThrow(() -> new EntityNotFoundException("Variant not found!"));

        Product product = productVariant.getProduct();
        ProductDetailResponseDTO response = ProductDetailResponseDTO.builder()
                .basePrice(product.getBasePrice())
                .categoryId(product.getCategory().getId())
                .categoryName(product.getCategory().getCategoryName())
                .haveType(product.getHaveType())
                .isDirectSale(product.getIsDirectSale())
                .isAvailable(product.getStatus().equals(Status.AVAILABLE) ? true : false)
                .urlImage(product.getImageUrl())
                .productName(product.getProductName())
                .productId(product.getId())
                .build();
        List<ProductVariantResponseDTO> variants = product.getProductVariants().stream()
                .map(vari -> new ProductVariantResponseDTO(
                        vari.getId(),
                        vari.getSize().getSizeName(),
                        vari.getPrice()))
                .collect(Collectors.toList());

        response.setVariants(variants);
        return response;
    }
    
}
