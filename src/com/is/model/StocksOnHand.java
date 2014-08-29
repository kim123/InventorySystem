package com.is.model;

import java.math.BigDecimal;
import java.sql.Timestamp;
import java.util.List;

public class StocksOnHand {
	
	private int stocksOnHandId;
	private int inventoryId;
	private int availableQuantity; // based on the quantity of the inventory id
	private int productId;
	private String productName;
	private String category;
	private int quantity;
	private int unitSold;
	private BigDecimal unitPrice;
	private int totalQuantity;
	private int endingQuantity;
	private Timestamp createdDate;
	private String createdBy;
	private List<StocksOnHand> dailyPreviousStocksOnHand; // same date previous stocks on hand
	
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
	public int getAvailableQuantity() {
		return availableQuantity;
	}
	public void setAvailableQuantity(int availableQuantity) {
		this.availableQuantity = availableQuantity;
	}
	public String getCategory() {
		return category;
	}
	public void setCategory(String category) {
		this.category = category;
	}
	public String getProductName() {
		return productName;
	}
	public void setProductName(String productName) {
		this.productName = productName;
	}
	public int getStocksOnHandId() {
		return stocksOnHandId;
	}
	public void setStocksOnHandId(int stocksOnHandId) {
		this.stocksOnHandId = stocksOnHandId;
	}
	public int getInventoryId() {
		return inventoryId;
	}
	public void setInventoryId(int inventoryId) {
		this.inventoryId = inventoryId;
	}
	public int getProductId() {
		return productId;
	}
	public void setProductId(int productId) {
		this.productId = productId;
	}
	public int getQuantity() {
		return quantity;
	}
	public void setQuantity(int quantity) {
		this.quantity = quantity;
	}
	public int getTotalQuantity() {
		return totalQuantity;
	}
	public void setTotalQuantity(int totalQuantity) {
		this.totalQuantity = totalQuantity;
	}
	public int getEndingQuantity() {
		return endingQuantity;
	}
	public void setEndingQuantity(int endingQuantity) {
		this.endingQuantity = endingQuantity;
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
	public List<StocksOnHand> getDailyPreviousStocksOnHand() {
		return dailyPreviousStocksOnHand;
	}
	public void setDailyPreviousStocksOnHand(
			List<StocksOnHand> dailyPreviousStocksOnHand) {
		this.dailyPreviousStocksOnHand = dailyPreviousStocksOnHand;
	}
	
	

}
