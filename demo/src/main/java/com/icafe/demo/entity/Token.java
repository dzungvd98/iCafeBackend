package com.icafe.demo.entity;


import java.util.Date;

import jakarta.persistence.Column;
import jakarta.persistence.Entity;
import jakarta.persistence.Table;
import lombok.Getter;
import lombok.Setter;

@Entity
@Table(name = "c_token")
@Getter
@Setter
public class Token extends BaseEntity {

	@Column(length = 1000)
	private String token;

	private Date tokenExpDate;

}
