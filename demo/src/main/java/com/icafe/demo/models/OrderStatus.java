package com.icafe.demo.models;

import com.icafe.demo.enums.StatusEnum;

import jakarta.persistence.Column;
import jakarta.persistence.Entity;
import jakarta.persistence.EnumType;
import jakarta.persistence.Enumerated;
import jakarta.persistence.GeneratedValue;
import jakarta.persistence.GenerationType;
import jakarta.persistence.Id;
import jakarta.persistence.Table;
import lombok.AllArgsConstructor;
import lombok.Getter;
import lombok.NoArgsConstructor;
import lombok.Setter;
import lombok.ToString;

@Entity
@Table(name = "order_status")
@Getter
@Setter
@NoArgsConstructor
@AllArgsConstructor
@ToString
public class OrderStatus {
    @Id
    @GeneratedValue(strategy = GenerationType.IDENTITY)
    @Column(name = "order_status_id")
    private Integer id;

    @Enumerated(EnumType.STRING)
    @Column(name = "status_name", nullable = false)
    private StatusEnum statusName;
}
