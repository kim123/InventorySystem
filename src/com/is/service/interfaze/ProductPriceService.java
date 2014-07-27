package com.is.service.interfaze;

import java.util.List;
import java.util.Map;

import com.is.model.Page;
import com.is.model.ProductPriceList;

public interface ProductPriceService {

	final String PAGE_NUM = "pageNum";
	final String PAGE_SIZE = "pageSize";
	final String PRODUCT_NAME = "productName";
	final String CATEGORY = "category";
	final String HISTORY = "history";
	final String OPERATOR_RETAIL_PRICE = "operatorRetailPrice";
	final String RETAIL_PRICE = "retailPrice";
	final String OPERATOR_SELLING_MAX = "operatorSellingMax";
	final String SELLING_MAX_PRICE = "sellingMaxPrice";
	final String OPERATOR_SELLING_MIN = "operatorSellingMin";
	final String SELLING_MIN_PRICE = "sellingMinPrice";
	
	Page viewProductsAndPrices(Map<String, Object> constraints);
	ProductPriceList getProductPrice(int productId);
	ProductPriceList getProductPrice(String productName);
	String addProductPrice(ProductPriceList productPrice);
	String updatePrices(ProductPriceList productPrice);
	String archiveProduct(ProductPriceList productPrice);
	List<ProductPriceList> productPriceList(int categoryId);
	List<ProductPriceList> productPriceList();

}
