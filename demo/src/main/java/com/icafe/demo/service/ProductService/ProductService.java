package com.icafe.demo.service.ProductService;

import java.io.IOException;
import java.nio.file.Files;
import java.nio.file.Path;
import java.nio.file.Paths;
import java.nio.file.StandardCopyOption;
import java.util.ArrayList;
import java.util.List;
import java.util.UUID;
import java.util.stream.Collectors;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.data.domain.Page;
import org.springframework.data.domain.PageRequest;
import org.springframework.data.domain.Pageable;
import org.springframework.data.jpa.domain.Specification;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;
import org.springframework.web.multipart.MultipartFile;

import com.icafe.demo.dto.PagingDataDTO;
import com.icafe.demo.dto.ProductDetailResponseDTO;
import com.icafe.demo.dto.ProductRequestDTO;
import com.icafe.demo.dto.ProductResponseDTO;
import com.icafe.demo.dto.ProductVariantRequestDTO;
import com.icafe.demo.dto.ProductVariantResponseDTO;
import com.icafe.demo.enums.Status;
import com.icafe.demo.mapper.PagingMapper;
import com.icafe.demo.mapper.ProductMapper;
import com.icafe.demo.mapper.ProductVariantMapper;
import com.icafe.demo.models.Category;
import com.icafe.demo.models.Product;
import com.icafe.demo.models.ProductVariant;
import com.icafe.demo.models.Size;
import com.icafe.demo.models.Warehouse;
import com.icafe.demo.repository.ICategoryRepository;
import com.icafe.demo.repository.IProductRepository;
import com.icafe.demo.repository.ISizeRepository;
import com.icafe.demo.repository.IWarehouseRepository;
import com.icafe.demo.specification.ProductSpecification;

import jakarta.persistence.EntityExistsException;
import jakarta.persistence.EntityNotFoundException;

@Service
public class ProductService implements IProductService {
    private static final String UPLOAD_DIR = "upload/images/";

    @Autowired
    private IProductRepository productRepository;

    @Autowired
    private ICategoryRepository categoryRepository;


    @Autowired
    private ISizeRepository sizeRepository;

    @Autowired
    private IWarehouseRepository warehouseRepository;

    @Autowired
    private ProductMapper productMapper;

    @Autowired
    private ProductVariantMapper productVariantMapper;

    @Override
    public PagingDataDTO<ProductResponseDTO> getProducts(String keyword, int categoryId, int page, int size) {
        if(categoryId != 0) {
                categoryRepository.findById(categoryId)
                        .orElseThrow(() -> new EntityNotFoundException("Category not found!"));
        } 
        Pageable pageable = PageRequest.of(page - 1, size);
        Specification<Product> spec = Specification.where(ProductSpecification.hasSearchKeyword(keyword, categoryId));
        Page<Product> productPage = productRepository.findAll(spec, pageable);
        return PagingMapper.map(productPage, product -> {
            String sizes = product.getProductVariants().stream()
                    .map(variant -> variant.getSize().getSizeName())
                    .collect(Collectors.joining(", "));

            String priceStr = product.getProductVariants().stream()
                    .map(variant -> String.valueOf(variant.getPrice().intValue()))
                    .collect(Collectors.joining(", "));

            return new ProductResponseDTO(
                    product.getId(),
                    product.getProductName(),
                    product.getCategory().getCategoryName(),
                    product.getBasePrice(),
                    priceStr,
                    product.getStatus().equals(Status.AVAILABLE),
                    product.getImageUrl(),
                    sizes);
        });

    }

    public PagingDataDTO<ProductResponseDTO> getListProductByCategory(String keyword, int categoryId, int page, int size) {
        categoryRepository.findById(categoryId)
                        .orElseThrow(() -> new EntityNotFoundException("Category not found!"));
        Pageable pageable = PageRequest.of(page - 1, size);
        Specification<Product> spec = Specification.where(ProductSpecification.hasSearchKeywordAndCategory(keyword, categoryId));
        Page<Product> productPage = productRepository.findAll(spec, pageable);
        return PagingMapper.map(productPage, product -> {
            String sizes = product.getProductVariants().stream()
                    .map(variant -> variant.getSize().getSizeName())
                    .collect(Collectors.joining(", "));

            String priceStr = product.getProductVariants().stream()
                    .map(variant -> String.valueOf(variant.getPrice().intValue()))
                    .collect(Collectors.joining(", "));

            return new ProductResponseDTO(
                    product.getId(),
                    product.getProductName(),
                    product.getCategory().getCategoryName(),
                    product.getBasePrice(),
                    priceStr,
                    product.getStatus().equals(Status.AVAILABLE),
                    product.getImageUrl(),
                    sizes);
        });
    }

    @Transactional
    public Product createNewProduct(ProductRequestDTO request, MultipartFile image) throws IOException{
        Category category = categoryRepository.findById(request.getCategoryId())
                .orElseThrow(() -> new EntityNotFoundException("Category not found!"));
        productRepository.findByProductName(request.getProductName())
                .ifPresent(p -> {throw new EntityExistsException("Product name existed!");});
        Product product = productMapper.toEntity(request, category);
        
        List<ProductVariant> variants = new ArrayList<>();
        for (ProductVariantRequestDTO variantRequest : request.getProductVariants()) {
            ProductVariant variant = productVariantMapper.toEntity(variantRequest, product);
            Size size = sizeRepository.findBySizeName(variantRequest.getSize())
                    .orElseGet(() -> sizeRepository.save(new Size(variantRequest.getSize())));
            variant.setSize(size);
            variant.setPrice(variantRequest.getPrice());
            variants.add(variant);
        }

        if (request.isDirectSale()) {
            Warehouse warehouse = new Warehouse();
            warehouse.setName(product.getProductName());
            warehouse.setIsDirectSale(true);
            warehouse.setMinQuantity(0);
            warehouse.setQuantity(0);
            warehouse.setUnit("");

            warehouse = warehouseRepository.save(warehouse);
            product.setWarehouse(warehouse);
            product.setIsDirectSale(true);
        }

        if (image != null && !image.isEmpty()) {
            String fileName = UUID.randomUUID() + "_" + image.getOriginalFilename();
    
            // Đảm bảo thư mục tồn tại
            Path uploadPath = Paths.get(UPLOAD_DIR);
            if (!Files.exists(uploadPath)) {
                Files.createDirectories(uploadPath);
            }
    
            // Copy file an toàn
            Path filePath = uploadPath.resolve(fileName);
            Files.copy(image.getInputStream(), filePath, StandardCopyOption.REPLACE_EXISTING);
    
            // Set URL
            product.setImageUrl("/images/" + fileName);
        }

        product.setProductVariants(variants);
        return productRepository.save(product);
    }

    @Transactional
    public Product updateProduct(int productId, ProductRequestDTO request, MultipartFile image) throws IOException {
        Product product = productRepository.findById(productId)
                .orElseThrow(() -> new EntityNotFoundException("Product not found!"));

        Category category = categoryRepository.findById(request.getCategoryId())
                .orElseThrow(() -> new EntityNotFoundException("Category not found"));

        product.setCategory(category);
        product.setBasePrice(request.getBasePrice());
        product.setHaveType(request.getHaveType());
        product.setProductName(request.getProductName());
        product.setStatus(request.isAvailable() == true ? Status.AVAILABLE : Status.OUT_OF_STOCK);
        product.setIsDirectSale(request.isDirectSale());

        product.getProductVariants().clear();
        for (ProductVariantRequestDTO variantRequest : request.getProductVariants()) {
            ProductVariant variant = productVariantMapper.toEntity(variantRequest, product);
            Size size = sizeRepository.findBySizeName(variantRequest.getSize())
                    .orElseGet(() -> sizeRepository.save(new Size(variantRequest.getSize())));
            variant.setSize(size);
            variant.setPrice(variantRequest.getPrice());
            variant.setProduct(product);
            product.getProductVariants().add(variant);
        }
        // Xử lý cập nhật ảnh nếu có
        if (image != null && !image.isEmpty()) {
            String fileName = UUID.randomUUID() + "_" + image.getOriginalFilename();

            // Đảm bảo thư mục tồn tại
            Path uploadPath = Paths.get(UPLOAD_DIR);
            if (!Files.exists(uploadPath)) {
                Files.createDirectories(uploadPath);
            }

            // Copy file an toàn
            Path filePath = uploadPath.resolve(fileName);
            Files.copy(image.getInputStream(), filePath, StandardCopyOption.REPLACE_EXISTING);

            // Set URL mới cho ảnh
            product.setImageUrl("/images/" + fileName);
        }
        return productRepository.save(product);
    }

    @Override
    public void deleteProductById(int productId) {
        Product product = productRepository.findById(productId)
                .orElseThrow(() -> new EntityNotFoundException("Product not found!"));

        product.setDeleted(true);
        productRepository.save(product);
    }

    @Override
    public void recoverDeletedProduct(int productId) {
        Product product = productRepository.findById(productId)
                .orElseThrow(() -> new EntityNotFoundException("Product not found!"));

        product.setDeleted(false);
        productRepository.save(product);
    }

    @Override
    public void changeProductStatus(int productId, Status status) {
        Product product = productRepository.findById(productId)
                .orElseThrow(() -> new EntityNotFoundException("Product not found!"));
        product.setStatus(status);
        productRepository.save(product);
    }

    @Override
    public ProductDetailResponseDTO getProductDetail(int productId) {
        Product product = productRepository.findById(productId)
                .orElseThrow(() -> new EntityNotFoundException("Not found product with id " + productId));
        if (product.isDeleted()) {
            throw new IllegalArgumentException("Can't get detail of deleted product!");
        }
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
