package com.is.model;

import java.math.BigDecimal;
import java.sql.Timestamp;

public class DailySales {
	
	private int dailySalesId;
	private int dailyOnHandId;
	private int productId;
	private String productName;
	private String category;
	private int beforeQuantity;
	private int afterQuantity;
	private int unitSold;
	private BigDecimal unitPrice;
	private BigDecimal totalAmount;
	private Timestamp createdDate;
	private String createdBy;
	
	public int getProductId() {
		return productId;
	}
	public void setProductId(int productId) {
		this.productId = productId;
	}
	public int getDailyOnHandId() {
		return dailyOnHandId;
	}
	public void setDailyOnHandId(int dailyOnHandId) {
		this.dailyOnHandId = dailyOnHandId;
	}
	public int getBeforeQuantity() {
		return beforeQuantity;
	}
	public void setBeforeQuantity(int beforeQuantity) {
		this.beforeQuantity = beforeQuantity;
	}
	public int getAfterQuantity() {
		return afterQuantity;
	}
	public void setAfterQuantity(int afterQuantity) {
		this.afterQuantity = afterQuantity;
	}
	public int getDailySalesId() {
		return dailySalesId;
	}
	public void setDailySalesId(int dailySalesId) {
		this.dailySalesId = dailySalesId;
	}
	public String getProductName() {
		return productName;
	}
	public void setProductName(String productName) {
		this.productName = productName;
	}
	public String getCategory() {
		return category;
	}
	public void setCategory(String category) {
		this.category = category;
	}
	public int getUnitSold() {
		return unitSold;
	}
	public void setUnitSold(int unitSold) {
		this.unitSold = unitSold;
	}
	public BigDecimal getUnitPrice() {
		return unitPrice;
	}
	public void setUnitPrice(BigDecimal unitPrice) {
		this.unitPrice = unitPrice;
	}
	public BigDecimal getTotalAmount() {
		return totalAmount;
	}
	public void setTotalAmount(BigDecimal totalAmount) {
		this.totalAmount = totalAmount;
	}
	public Timestamp getCreatedDate() {
		return createdDate;
	}
	public void setCreatedDate(Timestamp createdDate) {
		this.createdDate = createdDate;
	}
	public String getCreatedBy() {
		return createdBy;
	}
	public void setCreatedBy(String createdBy) {
		this.createdBy = createdBy;
	}
	
	

}
