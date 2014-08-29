package com.is.service.interfaze;

import java.util.Map;

import com.is.model.Page;
import com.is.model.StocksOnHand;

public interface StocksOnHandService {
	
	final String PAGE_NUM = "pageNum";
	final String PAGE_SIZE = "pageSize";
	final String PRODUCT_NAME = "productName";
	final String CATEGORY = "category";
	final String OPERATOR_QUANTITY = "operatorQuantity";
	final String QUANTITY = "quantity";

	Page viewStocksOnHand(Map<String, Object> constraints);
	String addStocksOnHand(StocksOnHand stocksOnHand);
	
	StocksOnHand getAvailableStocksBasedOnProdId(int productId);
	
}
