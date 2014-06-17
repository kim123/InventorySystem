package com.is.model;

import java.util.ArrayList;
import java.util.List;

public class ProductStatus {
	
	private String description;
	private int code;
	private static List<ProductStatus> products;
	
	public ProductStatus(String description, int code){
		this.description = description;
		this.code = code;
	}
	
	public String getDescription() {
		return description;
	}
	public void setDescription(String description) {
		this.description = description;
	}
	public int getCode() {
		return code;
	}
	public void setCode(int code) {
		this.code = code;
	}
	
	public static List<ProductStatus> getProductStatuses(){
		products = new ArrayList<ProductStatus>();
		products.add(new ProductStatus("Not Archived", 0));
		products.add(new ProductStatus("Archived", 1));
		
		return products;
	}

}
