package com.icafe.demo.models;

import java.math.BigDecimal;

import com.fasterxml.jackson.annotation.JsonBackReference;
import com.icafe.demo.enums.ProductType;

import jakarta.persistence.Column;
import jakarta.persistence.Entity;
import jakarta.persistence.EnumType;
import jakarta.persistence.Enumerated;
import jakarta.persistence.GeneratedValue;
import jakarta.persistence.GenerationType;
import jakarta.persistence.Id;
import jakarta.persistence.JoinColumn;
import jakarta.persistence.ManyToOne;
import jakarta.persistence.Table;
import lombok.Getter;
import lombok.Setter;

@Entity
@Table(name = "order_products")
@Getter
@Setter
public class OrderProduct {
    @Id
    @GeneratedValue(strategy = GenerationType.IDENTITY)
    @Column(name = "order_product_id")
    private Integer id;

    @ManyToOne
    @JoinColumn(name = "order_code", referencedColumnName = "order_code", nullable = false)
    @JsonBackReference
    private Order order;

    @ManyToOne
    @JoinColumn(name = "product_id", nullable = false)
    private Product product;

    @Enumerated(EnumType.STRING)
    private ProductType type;

    private String size;

    @Column(name = "percent_ice")
    private String percentIce;

    @Column(name = "percent_sugar")
    private String percentSugar;

    @Column(nullable = false)
    private Integer quantity;

    @Column(name = "price_each", nullable = false)
    private BigDecimal priceEach;

    @Column(name = "is_cancel", nullable = false)
    private Boolean isCancel;

}
