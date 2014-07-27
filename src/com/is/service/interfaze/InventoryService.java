package com.is.service.interfaze;

import java.util.List;
import java.util.Map;

import com.is.model.Inventory;
import com.is.model.Page;

public interface InventoryService{
	
	final String PAGE_NUM = "pageNum";
	final String PAGE_SIZE = "pageSize";
	final String PRODUCT_NAME = "productName";
	final String CATEGORY = "category";
	final String TOTAL_QUANTITY = "totalQuantity";
	final String OPERATOR_TOTAL = "operatorTotal";
	
	Page viewInventoryLogs(Map<String, Object> constraints);
	List<Inventory> getInventoryStockList(Map<String, Object> constraints);
	String addStocks(Inventory inventory);
  
}
