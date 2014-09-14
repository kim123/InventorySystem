package com.is.action;

import java.io.PrintWriter;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

import org.apache.commons.lang.StringUtils;
import org.json.JSONException;
import org.json.JSONObject;

import com.is.model.Category;
import com.is.model.DailySales;
import com.is.model.Expenses;
import com.is.model.Page;
import com.is.model.ProductPriceList;
import com.is.model.StocksOnHand;
import com.is.service.impl.CategoryServiceImpl;
import com.is.service.impl.DailySalesExpensesServiceImpl;
import com.is.service.impl.ProductPriceServiceImpl;
import com.is.service.impl.StocksOnHandServiceImpl;
import com.is.service.interfaze.CategoryService;
import com.is.service.interfaze.DailySalesExpensesService;
import com.is.service.interfaze.InventoryService;
import com.is.service.interfaze.ProductPriceService;
import com.is.service.interfaze.StocksOnHandService;
import com.is.utilities.Constants;
import com.is.utilities.DateUtility;
import com.is.utilities.SessionUtility;

@SuppressWarnings("serial")
public class DailySalesExpensesAction extends BaseAction{
	
	private static DailySalesExpensesService dailySalesExpenseService;
	private static CategoryService categoryService;
	private static ProductPriceService productService;
	private static StocksOnHandService stocksOnHandService;
	
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
		if (stocksOnHandService==null) {
			stocksOnHandService = new StocksOnHandServiceImpl();
		}
	}
	
	private String searchDate;
	private int categoryId;
	private Page pageExpense;
	//private String tabType; // 1=Daily Sales, 2=Expenses
	private DailySales sales;
	private Expenses expense;
	private int productId;
	
	public int getProductId() {
		return productId;
	}

	public void setProductId(int productId) {
		this.productId = productId;
	}

	public DailySales getSales() {
		return sales;
	}

	public void setSales(DailySales sales) {
		this.sales = sales;
	}

	public Expenses getExpense() {
		return expense;
	}

	public void setExpense(Expenses expense) {
		this.expense = expense;
	}

	public String getSearchDate() {
		return searchDate;
	}

	public Page getPageExpense() {
		return pageExpense;
	}

	public void setPageExpense(Page pageExpense) {
		this.pageExpense = pageExpense;
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
					selectOptions.append(";").append(ppl.getProductId()).append("/").append(ppl.getProductName()).append("/")
												.append(ppl.getMaxSellingPrice()).append("/").append(ppl.getMinSellingPrice());
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
			setSearchDate(DateUtility.getSimpleCurrentDateStr()); 
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
			constraints.put(DailySalesExpensesService.SEARCH_DATE, searchDate);
		}
		
		page = dailySalesExpenseService.viewDailySales(constraints);
		pageExpense = dailySalesExpenseService.viewExpenses(constraints);

		return SUCCESS;
	}
	
	public String getPricesBasedOnProductName(){
		PrintWriter out = getPrintWriter();
		JSONObject json = new JSONObject();
		ProductPriceList productPrice = productService.getProductPrice(productId);
		try {
			StringBuilder selectOptions = new StringBuilder(" ");
			json.put(Constants.SUCCESS, true);
			selectOptions.append(productPrice.getMaxSellingPrice()).append("/").append(productPrice.getMinSellingPrice());			
			json.put("options", selectOptions.toString());			
		} catch (JSONException e) {
			e.printStackTrace();
		}
		printJsonAndCloseWriter(out, json);
		return null;
	}
	
	public String getAvailableStocksBasedOnProductId(){
		PrintWriter out = getPrintWriter();
		JSONObject json = new JSONObject();
		StocksOnHand stocks = stocksOnHandService.getAvailableStocksBasedOnProdId(productId);
		try {
			StringBuilder selectOptions = new StringBuilder(" ");
			json.put(Constants.SUCCESS, true);
			selectOptions.append(stocks.getStocksOnHandId()).append("/").append(stocks.getQuantity());			
			json.put("stocks", selectOptions.toString());			
		} catch (JSONException e) {
			e.printStackTrace();
		}
		printJsonAndCloseWriter(out, json);		
		return null;
	}
	
	public String addDailySales(){
		PrintWriter out = getPrintWriter();
		JSONObject json = new JSONObject();
		
		sales.setCreatedBy(SessionUtility.getUser().getUserName());
		String result = dailySalesExpenseService.addSales(sales);
		try {
			if (result==null) {
				json.put(Constants.SUCCESS, true);
			} else if (result.equals(Constants.SUCCESS)) {
				json.put(Constants.SUCCESS, true);
			} else {
				json.put(Constants.SUCCESS, false);
			}
			json.put("message", result);
		} catch (JSONException e) {
			e.printStackTrace();
		}
		printJsonAndCloseWriter(out, json);
		
		return null;
	}
	
	public String addExpense(){
		PrintWriter out = getPrintWriter();
		JSONObject json = new JSONObject();
		
		expense.setCreatedBy(SessionUtility.getUser().getUserName());
		String result = dailySalesExpenseService.addExpense(expense);
		try {
			if (result==null) {
				json.put(Constants.SUCCESS, true);
			} else if (result.equals(Constants.SUCCESS)) {
				json.put(Constants.SUCCESS, true);
			} else {
				json.put(Constants.SUCCESS, false);
			}
			json.put("message", result);
		} catch (JSONException e) {
			e.printStackTrace();
		}
		printJsonAndCloseWriter(out, json);
		
		return null;
	}


	/*public String getTabType() {
		return tabType;
	}

	public void setTabType(String tabType) {
		this.tabType = tabType;
	}*/

}
