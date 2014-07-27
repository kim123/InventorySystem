package com.is.service.interfaze;

import java.util.Map;

import com.is.model.DailySales;
import com.is.model.Expenses;
import com.is.model.Page;

public interface DailySalesExpensesService {
	
	
	
	Page viewExpenses(Map<String, Object> constraints);
	String addExpense(Expenses expenses);
	Page viewDailySales(Map<String, Object> constraints);
	String addSales(DailySales sales);
	
}
