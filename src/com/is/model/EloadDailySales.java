package com.is.model;

import java.sql.Timestamp;
import java.math.BigDecimal;

public class EloadDailySales{

    private Integer eloadDailySalesId;
    private Integer productId;
    private Integer quantity;
    private BigDecimal total;
    private Timestamp updatedDate;
    private String updatedBy;
    private BigDecimal price;
    private Integer priceId;
    
	public Integer getEloadDailySalesId() {
		return eloadDailySalesId;
	}
	public void setEloadDailySalesId(Integer eloadDailySalesId) {
		this.eloadDailySalesId = eloadDailySalesId;
	}
	public Integer getProductId() {
		return productId;
	}
	public void setProductId(Integer productId) {
		this.productId = productId;
	}
	public Integer getQuantity() {
		return quantity;
	}
	public void setQuantity(Integer quantity) {
		this.quantity = quantity;
	}
	public BigDecimal getTotal() {
		return total;
	}
	public void setTotal(BigDecimal total) {
		this.total = total;
	}
	public Timestamp getUpdatedDate() {
		return updatedDate;
	}
	public void setUpdatedDate(Timestamp updatedDate) {
		this.updatedDate = updatedDate;
	}
	public String getUpdatedBy() {
		return updatedBy;
	}
	public void setUpdatedBy(String updatedBy) {
		this.updatedBy = updatedBy;
	}
	public BigDecimal getPrice() {
		return price;
	}
	public void setPrice(BigDecimal price) {
		this.price = price;
	}
	public Integer getPriceId() {
		return priceId;
	}
	public void setPriceId(Integer priceId) {
		this.priceId = priceId;
	}
    
    

}
