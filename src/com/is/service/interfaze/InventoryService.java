package com.is.service.interfaze;

import java.util.Map;

import com.is.model.Inventory;
import com.is.model.Page;

public interface InventoryService{
  
	Page viewCurrentInventory(Map<String, Object> constraints);
	String addStocks(Inventory inventory);
  
}
