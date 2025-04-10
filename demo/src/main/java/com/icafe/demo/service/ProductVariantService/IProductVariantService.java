package com.icafe.demo.service.ProductVariantService;

import com.icafe.demo.dto.ProductDetailResponseDTO;

public interface IProductVariantService {
    ProductDetailResponseDTO findProductByVariant(int variantId);
}
