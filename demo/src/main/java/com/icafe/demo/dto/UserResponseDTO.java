package com.icafe.demo.dto;

import lombok.Builder;
import lombok.Data;

@Data
@Builder
public class UserResponseDTO {
    private String username;
    private String role;
    private String timeCreated;
    private String updatedAt;
    private String createdBy;
    private String updatedBy;
}
