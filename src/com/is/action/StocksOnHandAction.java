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
import com.is.model.StocksOnHand;
import com.is.service.impl.CategoryServiceImpl;
import com.is.service.impl.ProductPriceServiceImpl;
import com.is.service.impl.StocksOnHandServiceImpl;
import com.is.service.interfaze.CategoryService;
import com.is.service.interfaze.InventoryService;
import com.is.service.interfaze.ProductPriceService;
import com.is.service.interfaze.StocksOnHandService;
import com.is.utilities.Constants;
import com.is.utilities.SessionUtility;

@SuppressWarnings("serial")
public class StocksOnHandAction extends BaseAction{
	
	private static StocksOnHandService stocksOnHandService;
	private static CategoryService categoryService;
	private static ProductPriceService productService;
	
	static {
		if (stocksOnHandService==null) {
			stocksOnHandService = new StocksOnHandServiceImpl();
		}
		if (categoryService==null) {
			categoryService = new CategoryServiceImpl();
		}
		if (productService==null) {
			productService = new ProductPriceServiceImpl();
		}
	}
	
	private StocksOnHand stocksOnHand;
	private int productId;
	private String quantity;
	private int categoryId;
	private String operatorTotal;
	
	public String getQuantity() {
		return quantity;
	}

	public void setQuantity(String quantity) {
		this.quantity = quantity;
	}

	public String getOperatorTotal() {
		return operatorTotal;
	}

	public void setOperatorTotal(String operatorTotal) {
		this.operatorTotal = operatorTotal;
	}

	public StocksOnHand getStocksOnHand() {
		return stocksOnHand;
	}

	public void setStocksOnHand(StocksOnHand stocksOnHand) {
		this.stocksOnHand = stocksOnHand;
	}

	public int getCategoryId() {
		return categoryId;
	}

	public void setCategoryId(int categoryId) {
		this.categoryId = categoryId;
	}

	public int getProductId() {
		return productId;
	}

	public void setProductId(int productId) {
		this.productId = productId;
	}

	@SuppressWarnings("unchecked")
	public List<Category> categories = (List<Category>) categoryService.getCategoryList();
	public List<Operators> operatorsTotal = Operators.getOperators();
	//public List<ProductPriceList> products = productService.productPriceList(categoryId);
	
	/*public String getProductPriceList(){
		PrintWriter out = getPrintWriter();
		JSONObject json = new JSONObject();
		products = productService.productPriceList(categoryId);
		try {
			StringBuilder selectOptions = new StringBuilder(" ");
			if (products.size()==0) {
				json.put(Constants.SUCCESS, false);
				selectOptions.append(";");
			} else {
				json.put(Constants.SUCCESS, true);
				for (ProductPriceList ppl : products) {
					selectOptions.append(";").append(ppl.getProductId()).append("/").append(ppl.getProductName());
				}
			}			
			json.put("options", selectOptions.toString());
		} catch (JSONException e) {
			e.printStackTrace();
		}
		printJsonAndCloseWriter(out, json);
		
		return null;
	}*/
	
	public String execute(){
		setMenuActive("7");
		
		Map<String, Object> constraints = new HashMap<String, Object>();
		constraints.put(ProductPriceService.PAGE_SIZE, getPageSize());
		
		if (page!=null) {
			int pageResult = page.getPageResult();
			int ctrTotal = 0;
			if (StringUtils.isNotEmpty(pageType)) {
				if (pageType.equals(Constants.PAGE_TYPE_PREVIOUS)) {
					ctrTotal = pageResult-getPageSize();
				} else if (pageType.equals(Constants.PAGE_TYPE_NEXT)) {
					ctrTotal = pageResult+getPageSize();
				}
			}
			constraints.put(ProductPriceService.PAGE_NUM, ctrTotal);
			if (StringUtils.isNotEmpty(stocksOnHand.getProductName())) {
				constraints.put(StocksOnHandService.PRODUCT_NAME, stocksOnHand.getProductName());
			}
			if (StringUtils.isNotEmpty(stocksOnHand.getCategory())) {
				constraints.put(StocksOnHandService.CATEGORY, stocksOnHand.getCategory());
			}
			if (StringUtils.isNotEmpty(operatorTotal) && StringUtils.isNotEmpty(quantity)) {
				constraints.put(StocksOnHandService.OPERATOR_QUANTITY, operatorTotal);
				constraints.put(StocksOnHandService.QUANTITY, Integer.parseInt(quantity));
			}
			
		} else {
			constraints.put(InventoryService.PAGE_NUM, 0);
		}
		
		page = stocksOnHandService.viewStocksOnHand(constraints);
		setOperatorTotal("");
		
		return SUCCESS;
	}
	
	public String addStocksOnHand(){
		PrintWriter out = getPrintWriter();
		JSONObject json = new JSONObject();
		
		stocksOnHand.setCreatedBy(SessionUtility.getUser().getUserName());
		String result = stocksOnHandService.addStocksOnHand(stocksOnHand);
		try {
			if (result==null) {
				json.put(Constants.SUCCESS, true);
				json.put("message", getText(Constants.SUCCESS));
			} else if (result.equals(Constants.SUCCESS)) {
				json.put(Constants.SUCCESS, true);
				json.put("message", getText(result));
			} else {
				json.put(Constants.SUCCESS, false);
				json.put("message", result);
			}
		} catch (JSONException e) {
			e.printStackTrace();
		}
		
		printJsonAndCloseWriter(out, json);
		
		return null;
	}


}
