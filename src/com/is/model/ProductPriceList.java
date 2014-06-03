package com.is.model;

import java.math.BigDecimal;
import java.sql.Timestamp;

public class ProductPriceList {

	private int productId;
	private String productName;
	private String category;
	private Timestamp productCreatedDate;
	private String productCreatedBy;
	private int isHistory;
	private BigDecimal retailPrice;
	private BigDecimal maxSellingPrice;
	private BigDecimal minSellingPrice;
	private Timestamp priceCreatedDate;
	private String priceCreatedBy;
	
	public int getProductId() {
		return productId;
	}
	public void setProductId(int productId) {
		this.productId = productId;
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
	public Timestamp getProductCreatedDate() {
		return productCreatedDate;
	}
	public void setProductCreatedDate(Timestamp productCreatedDate) {
		this.productCreatedDate = productCreatedDate;
	}
	public String getProductCreatedBy() {
		return productCreatedBy;
	}
	public void setProductCreatedBy(String productCreatedBy) {
		this.productCreatedBy = productCreatedBy;
	}
	public int getIsHistory() {
		return isHistory;
	}
	public void setIsHistory(int isHistory) {
		this.isHistory = isHistory;
	}
	public BigDecimal getRetailPrice() {
		return retailPrice;
	}
	public void setRetailPrice(BigDecimal retailPrice) {
		this.retailPrice = retailPrice;
	}
	public BigDecimal getMaxSellingPrice() {
		return maxSellingPrice;
	}
	public void setMaxSellingPrice(BigDecimal maxSellingPrice) {
		this.maxSellingPrice = maxSellingPrice;
	}
	public BigDecimal getMinSellingPrice() {
		return minSellingPrice;
	}
	public void setMinSellingPrice(BigDecimal minSellingPrice) {
		this.minSellingPrice = minSellingPrice;
	}
	public Timestamp getPriceCreatedDate() {
		return priceCreatedDate;
	}
	public void setPriceCreatedDate(Timestamp priceCreatedDate) {
		this.priceCreatedDate = priceCreatedDate;
	}
	public String getPriceCreatedBy() {
		return priceCreatedBy;
	}
	public void setPriceCreatedBy(String priceCreatedBy) {
		this.priceCreatedBy = priceCreatedBy;
	}
		
}
