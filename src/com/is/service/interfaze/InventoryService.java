package com.is.service.interfaze;

public interface InventoryService{
  
  Page viewCurrentInventory(Map<String, Object> constraints);
  String addStocks(Inventory inventory);
  
}
