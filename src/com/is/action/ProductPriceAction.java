package com.is.action;

import java.io.PrintWriter;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

import org.apache.commons.lang.StringUtils;
import org.json.JSONException;
import org.json.JSONObject;

import com.is.model.Category;
import com.is.model.Operators;
import com.is.model.ProductPriceList;
import com.is.model.ProductStatus;
import com.is.service.impl.CategoryServiceImpl;
import com.is.service.impl.ProductPriceServiceImpl;
import com.is.service.interfaze.CategoryService;
import com.is.service.interfaze.ProductPriceService;
import com.is.utilities.Constants;
import com.is.utilities.SessionUtility;

@SuppressWarnings("serial")
public class ProductPriceAction extends BaseAction{
	
	private static ProductPriceService productService;
	private static CategoryService categoryService;
	
	static {
		if (productService==null) {
			productService = new ProductPriceServiceImpl();
		}
		if (categoryService==null) {
			categoryService = new CategoryServiceImpl();
		}
	}
	
	private ProductPriceList productPrice;
	private String retailPriceOperator;
	private String maxSellingPriceOperator;
	private String minSellingPriceOperator;
	private String isHistory;
	
	@SuppressWarnings("unchecked")
	public List<Category> categories = (List<Category>) categoryService.getCategoryList();
	public List<ProductStatus> products = ProductStatus.getProductStatuses();
	public List<Operators> operatorsRetailPrice = Operators.getOperators();
	public List<Operators> operatorsMaxSellingPrice = Operators.getOperators();
	public List<Operators> operatorsMinSellingPrice = Operators.getOperators();

	public String getRetailPriceOperator() {
		return retailPriceOperator;
	}

	public void setRetailPriceOperator(String retailPriceOperator) {
		this.retailPriceOperator = retailPriceOperator;
	}

	public String getIsHistory() {
		return isHistory;
	}

	public void setIsHistory(String isHistory) {
		this.isHistory = isHistory;
	}

	public String getMaxSellingPriceOperator() {
		return maxSellingPriceOperator;
	}

	public void setMaxSellingPriceOperator(String maxSellingPriceOperator) {
		this.maxSellingPriceOperator = maxSellingPriceOperator;
	}

	public String getMinSellingPriceOperator() {
		return minSellingPriceOperator;
	}

	public void setMinSellingPriceOperator(String minSellingPriceOperator) {
		this.minSellingPriceOperator = minSellingPriceOperator;
	}

	public ProductPriceList getProductPrice() {
		return productPrice;
	}

	public void setProductPrice(ProductPriceList productPrice) {
		this.productPrice = productPrice;
	}
	
	public String execute(){
		setMenuActive("4");
		
		Map<String, Object> constraints = new HashMap<String, Object>();
		constraints.put(ProductPriceService.PAGE_NUM, getPageNum());
		constraints.put(ProductPriceService.PAGE_SIZE, getPageSize());
		if (productPrice!=null) {
			if (isHistory.length()!=0) {
				constraints.put(ProductPriceService.HISTORY, isHistory);
			}
			if (StringUtils.isNotEmpty(productPrice.getProductName())) {
				constraints.put(ProductPriceService.PRODUCT_NAME, productPrice.getProductName());
			}
			if (StringUtils.isNotEmpty(productPrice.getCategory())) {
				constraints.put(ProductPriceService.CATEGORY, productPrice.getCategory());
			}
			if (productPrice.getRetailPrice()!=null && StringUtils.isNotEmpty(retailPriceOperator)) {
				constraints.put(ProductPriceService.OPERATOR_RETAIL_PRICE, retailPriceOperator);
				constraints.put(ProductPriceService.RETAIL_PRICE, productPrice.getRetailPrice());
			}
			if (productPrice.getMaxSellingPrice()!=null && StringUtils.isNotEmpty(maxSellingPriceOperator)) {
				constraints.put(ProductPriceService.OPERATOR_SELLING_MAX, maxSellingPriceOperator);
				constraints.put(ProductPriceService.SELLING_MAX_PRICE, productPrice.getMaxSellingPrice());
			}
			if (productPrice.getMinSellingPrice()!=null && StringUtils.isNotEmpty(minSellingPriceOperator)) {
				constraints.put(ProductPriceService.OPERATOR_SELLING_MIN, minSellingPriceOperator);
				constraints.put(ProductPriceService.SELLING_MIN_PRICE, productPrice.getMinSellingPrice());
			}
		} 
		
		page = productService.viewProductsAndPrices(constraints);
		
		return SUCCESS;
	}
	
	public String addProductPrice(){
		PrintWriter out = getPrintWriter();
		JSONObject json = new JSONObject();
		// add validation same as products.jsp
		productPrice.setProductCreatedBy(SessionUtility.getUser().getUserName());
		productPrice.setPriceCreatedBy(SessionUtility.getUser().getUserName());
		String result = productService.addProductPrice(productPrice);
		try {
			if (result.equals(Constants.SUCCESS)) {
				json.put(Constants.SUCCESS, true);
			} else {
				json.put(Constants.SUCCESS, false);
			}
			json.put("message", result);
		} catch (JSONException e) {
			e.printStackTrace();
		}
		printJsonAndCloseWriter(out, json);
		
		return SUCCESS;
	}
	
	public String archiveproduct(){
		PrintWriter out = getPrintWriter();
		JSONObject json = new JSONObject();
		
		productPrice.setProductCreatedBy(SessionUtility.getUser().getUserName());
		String result = productService.archiveProduct(productPrice);
		try {
			if (result.equals(Constants.SUCCESS)) {
				json.put(Constants.SUCCESS, true);
			} else {
				json.put(Constants.SUCCESS, false);
			}
			json.put("message", result);
		} catch (JSONException e) {
			e.printStackTrace();
		}
		printJsonAndCloseWriter(out, json);
		
		return SUCCESS;
	}
	
	public String modifyPrices(){
		PrintWriter out = getPrintWriter();
		JSONObject json = new JSONObject();
		
		productPrice.setPriceCreatedBy(SessionUtility.getUser().getUserName());
		String result = productService.updatePrices(productPrice);
		try {
			if (result.equals(Constants.SUCCESS)) {
				json.put(Constants.SUCCESS, true);
			} else {
				json.put(Constants.SUCCESS, false);
			}
			json.put("message", result);
		} catch (JSONException e) {
			e.printStackTrace();
		}
		printJsonAndCloseWriter(out, json);
		
		return SUCCESS;
	}

}
