package com.is.model;

import java.math.BigDecimal;
import java.sql.Timestamp;

public class EloadPrices {
	
	private int priceId;
	private int eloadProductId;
	private BigDecimal price;
	private BigDecimal retailPrice;
	private BigDecimal markupPrice;
	private int enableStatus;
	private String updatedBy;
	private Timestamp updatedDate;
	private String eloadName;
	
	public String getEloadName() {
		return eloadName;
	}
	public void setEloadName(String eloadName) {
		this.eloadName = eloadName;
	}
	public int getPriceId() {
		return priceId;
	}
	public void setPriceId(int priceId) {
		this.priceId = priceId;
	}
	public int getEloadProductId() {
		return eloadProductId;
	}
	public void setEloadProductId(int eloadProductId) {
		this.eloadProductId = eloadProductId;
	}
	public BigDecimal getPrice() {
		return price;
	}
	public void setPrice(BigDecimal price) {
		this.price = price;
	}
	public BigDecimal getRetailPrice() {
		return retailPrice;
	}
	public void setRetailPrice(BigDecimal retailPrice) {
		this.retailPrice = retailPrice;
	}
	public BigDecimal getMarkupPrice() {
		return markupPrice;
	}
	public void setMarkupPrice(BigDecimal markupPrice) {
		this.markupPrice = markupPrice;
	}
	public int getEnableStatus() {
		return enableStatus;
	}
	public void setEnableStatus(int enableStatus) {
		this.enableStatus = enableStatus;
	}
	public String getUpdatedBy() {
		return updatedBy;
	}
	public void setUpdatedBy(String updatedBy) {
		this.updatedBy = updatedBy;
	}
	public Timestamp getUpdatedDate() {
		return updatedDate;
	}
	public void setUpdatedDate(Timestamp updatedDate) {
		this.updatedDate = updatedDate;
	}
	
	

}
