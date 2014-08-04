package com.is.action;

import java.io.PrintWriter;
import java.text.SimpleDateFormat;
import java.util.Calendar;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

import org.apache.commons.lang.StringUtils;
import org.json.JSONException;
import org.json.JSONObject;

import com.is.model.Category;
import com.is.model.ProductPriceList;
import com.is.service.impl.CategoryServiceImpl;
import com.is.service.impl.DailySalesExpensesServiceImpl;
import com.is.service.impl.ProductPriceServiceImpl;
import com.is.service.interfaze.CategoryService;
import com.is.service.interfaze.DailySalesExpensesService;
import com.is.service.interfaze.InventoryService;
import com.is.service.interfaze.ProductPriceService;
import com.is.utilities.Constants;

@SuppressWarnings("serial")
public class DailySalesExpensesAction extends BaseAction{
	
	private static DailySalesExpensesService dailySalesExpenseService;
	private static CategoryService categoryService;
	private static ProductPriceService productService;
	
	static {
		if (dailySalesExpenseService==null) {
			dailySalesExpenseService = new DailySalesExpensesServiceImpl();
		}
		if (categoryService==null) {
			categoryService = new CategoryServiceImpl();
		}
		if (productService==null) {
			productService = new ProductPriceServiceImpl();
		}
	}
	
	private String searchDate;
	private int categoryId;
	private String tabType; // 1=Daily Sales, 2=Expenses
	
	public String getSearchDate() {
		return searchDate;
	}

	public void setSearchDate(String searchDate) {
		this.searchDate = searchDate;
	}

	public int getCategoryId() {
		return categoryId;
	}

	public void setCategoryId(int categoryId) {
		this.categoryId = categoryId;
	}

	@SuppressWarnings("unchecked")
	public List<Category> categories = (List<Category>) categoryService.getCategoryList();
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
	
	public String execute(){
		setMenuActive("8");
		if (StringUtils.isEmpty(searchDate)) {
			setSearchDate(getDefaultDate());
		}
		if (StringUtils.isEmpty(tabType)) {
			setTabType("1");
		}
		
		Map<String, Object> constraints = new HashMap<String, Object>();
		constraints.put(DailySalesExpensesService.PAGE_SIZE, getPageSize());
		
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
			constraints.put(DailySalesExpensesService.PAGE_NUM, ctrTotal);
			constraints.put(DailySalesExpensesService.SEARCH_DATE, searchDate);
			
		} else {
			constraints.put(InventoryService.PAGE_NUM, 0);
		}
		
		if (tabType.equals("1")) {
			page = dailySalesExpenseService.viewDailySales(constraints);
		} else {
			page = dailySalesExpenseService.viewExpenses(constraints);
		}
		
		
		return SUCCESS;
	}
	
	private String getDefaultDate(){
		Calendar calendar = Calendar.getInstance();
		SimpleDateFormat sdf = new SimpleDateFormat("yyyy-MM-dd");
		
		return sdf.format(calendar.getTime());
	}

	public String getTabType() {
		return tabType;
	}

	public void setTabType(String tabType) {
		this.tabType = tabType;
	}

}
