package com.is.service.interfaze;

import java.util.List;
import java.util.Map;

import com.is.model.DailySales;
import com.is.model.Expenses;
import com.is.model.Page;

public interface DailySalesExpensesService {
	
	final String SEARCH_DATE = "searchStartDate";
	final String PAGE_NUM = "pageNum";
	final String PAGE_SIZE = "pageSize";
	
	Page viewExpenses(Map<String, Object> constraints);
	List<Expenses> getExpenseList(Map<String, Object> constraints);
	String addExpense(Expenses expenses);
	
	Page viewDailySales(Map<String, Object> constraints);
	List<DailySales> getDailySalesList(Map<String, Object> constraints);
	String addSales(DailySales sales);
	
}
