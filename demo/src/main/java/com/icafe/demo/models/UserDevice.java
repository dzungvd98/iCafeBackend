package com.icafe.demo.models;

import java.time.LocalDateTime;

import jakarta.persistence.Column;
import jakarta.persistence.Entity;
import jakarta.persistence.GeneratedValue;
import jakarta.persistence.GenerationType;
import jakarta.persistence.Id;
import jakarta.persistence.JoinColumn;
import jakarta.persistence.ManyToOne;
import jakarta.persistence.Table;
import jakarta.validation.constraints.NotBlank;
import lombok.Getter;
import lombok.RequiredArgsConstructor;
import lombok.Setter;

@Entity
@Table(name = "user_device")
@Getter @Setter
@RequiredArgsConstructor
public class UserDevice {
    @Id
    @GeneratedValue(strategy = GenerationType.IDENTITY)
    private Integer id;

    @NotBlank(message = "device code is need value")
    @Column(name = "device_code")
    private String deviceCode;

    @Column(name = "device_type")
    private String deviceType;

    @Column(name = "ip_address")
    private String ipAddress;

    @ManyToOne
    @JoinColumn(name = "user_id", nullable = false)
    private User user;

    @Column(name = "last_login_at")
    private LocalDateTime lastLoginAt;

    @Column(name = "is_active")
    private boolean isActive;

    @Column(name = "user_agent", length = 1000)
    private String userAgent;
}
