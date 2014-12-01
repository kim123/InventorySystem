package com.is.action;

import java.io.PrintWriter;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

import org.apache.commons.lang.StringUtils;
import org.json.JSONException;
import org.json.JSONObject;

import com.is.model.Category;
import com.is.model.Inventory;
import com.is.model.Operators;
import com.is.model.ProductPriceList;
import com.is.service.impl.CategoryServiceImpl;
import com.is.service.impl.InventoryServiceImpl;
import com.is.service.impl.ProductPriceServiceImpl;
import com.is.service.interfaze.CategoryService;
import com.is.service.interfaze.InventoryService;
import com.is.service.interfaze.ProductPriceService;
import com.is.utilities.Constants;
import com.is.utilities.SessionUtility;

@SuppressWarnings("serial")
public class InventoryAction extends BaseAction{
	
	private static InventoryService inventoryService;
	private static CategoryService categoryService;
	private static ProductPriceService productService;
	
	static {
		if (inventoryService==null) {
			inventoryService = new InventoryServiceImpl();
		}
		if (categoryService==null) {
			categoryService = new CategoryServiceImpl();
		}
		if (productService==null) {
			productService = new ProductPriceServiceImpl();
		}
	}
	
	private String operatorTotal;
	private Inventory inventory;
	private String category;
	private String total;
	private int categoryId;
	private int quantityAdd;

	public int getQuantityAdd() {
		return quantityAdd;
	}

	public void setQuantityAdd(int quantityAdd) {
		this.quantityAdd = quantityAdd;
	}

	public int getCategoryId() {
		return categoryId;
	}

	public void setCategoryId(int categoryId) {
		this.categoryId = categoryId;
	}

	public String getTotal() {
		return total;
	}

	public void setTotal(String total) {
		this.total = total;
	}

	public String getCategory() {
		return category;
	}

	public void setCategory(String category) {
		this.category = category;
	}

	public Inventory getInventory() {
		return inventory;
	}

	public void setInventory(Inventory inventory) {
		this.inventory = inventory;
	}

	public String getOperatorTotal() {
		return operatorTotal;
	}

	public void setOperatorTotal(String operatorTotal) {
		this.operatorTotal = operatorTotal;
	}

	@SuppressWarnings("unchecked")
	public List<Category> categories = (List<Category>) categoryService.getCategoryList();
	public List<Operators> operatorsTotal = Operators.getOperators();
	public List<ProductPriceList> productPriceList = productService.productPriceList(categoryId);
	
	public String getProductPriceList(){
		PrintWriter out = getPrintWriter();
		JSONObject json = new JSONObject();
		productPriceList = productService.productPriceList(categoryId);
		try {
			StringBuilder selectOptions = new StringBuilder(" ");
			if (productPriceList.size()==0) {
				json.put(Constants.SUCCESS, false);
				selectOptions.append(";");
			} else {
				json.put(Constants.SUCCESS, true);
				for (ProductPriceList ppl : productPriceList) {
					selectOptions.append(";").append(ppl.getProductId()).append("/").append(ppl.getProductName());
				}
			}			
			json.put("options", selectOptions.toString());
		} catch (JSONException e) {
			e.printStackTrace();
		}
		printJsonAndCloseWriter(out, json);
		
		return null;
	}

	public String execute() throws Exception {
		setMenuActive("5");
		
		Map<String, Object> constraints = new HashMap<String, Object>();
		constraints.put(ProductPriceService.PAGE_SIZE, getPageSize());
		if (inventory!=null) {
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
				if (StringUtils.isNotEmpty(inventory.getProductName())) {
					constraints.put(InventoryService.PRODUCT_NAME, inventory.getProductName());
				}
				if (StringUtils.isNotEmpty(category)) {
					constraints.put(InventoryService.CATEGORY, category);
				}
				if (StringUtils.isNotEmpty(operatorTotal) && StringUtils.isNotEmpty(total)) {
					constraints.put(InventoryService.OPERATOR_TOTAL, operatorTotal);
					constraints.put(InventoryService.TOTAL_QUANTITY, Integer.parseInt(total));
				}
			} else {
				constraints.put(InventoryService.PAGE_NUM, 0);
			}
		} else {
			constraints.put(InventoryService.PAGE_NUM, 0);
		}
		
		page = inventoryService.viewInventoryLogs(constraints);
		setOperatorTotal("");
		
		return SUCCESS;
	}
	
	public String addStocks(){
		PrintWriter out = getPrintWriter();
		JSONObject json = new JSONObject();
		// add validation same as inventory.jsp
		inventory.setCreatedBy(SessionUtility.getUser().getUserName());
		String result = inventoryService.addStocks(inventory);
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
