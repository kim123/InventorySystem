package com.is.service.impl;

import java.math.BigDecimal;
import java.math.BigInteger;
import java.sql.Timestamp;
import java.util.ArrayList;
import java.util.Arrays;
import java.util.Iterator;
import java.util.List;
import java.util.Map;

import org.hibernate.Query;

import com.is.model.DailySales;
import com.is.model.Expenses;
import com.is.model.Page;
import com.is.service.interfaze.DailySalesExpensesService;
import com.is.utilities.LoggingUtility;

public class DailySalesExpensesServiceImpl extends BaseServiceImpl implements DailySalesExpensesService{

	public Page viewExpenses(Map<String, Object> constraints) {
		Page page = new Page();
		page.setPageSize((Integer)constraints.get(PAGE_SIZE));
		page.setContents(getExpenseList(constraints));
		page.setTotalSizeOfContents(page.getContents().size());
		page.setTotalRecords(getTotalExpenseRecords(constraints));
		if (page.getContents().size() < page.getTotalRecords()) {
			page.setPageResult((Integer)constraints.get(PAGE_NUM));
		} else {
			page.setPageResult(0);
		}
		return page;
	}
	
	public List<Expenses> getExpenseList(Map<String, Object> constraints) {
		List<Expenses> expenseList = new ArrayList<Expenses>();
		String sql = getExpensesQuery();
		Query query = getSession().createSQLQuery(sql);
		query.setParameter("searchDate", (String)constraints.get(SEARCH_DATE));
		
		query.setFirstResult((Integer)constraints.get(PAGE_NUM));
		query.setMaxResults((Integer)constraints.get(PAGE_SIZE));
		
		LoggingUtility.log(getClass(), "Get Expense List: Params["+Arrays.asList(constraints.values().toArray())+"]");
		LoggingUtility.log(getClass(), "Get Expense List: Query["+query.getQueryString()+"]");
		
		List<?> tempList = query.list();
		Iterator<?> iter = tempList.iterator();
		while (iter.hasNext()) {
			Object[] object = (Object[]) iter.next();
			Expenses e = new Expenses();
			e.setName((String)object[0]);
			e.setAmount((BigDecimal)object[1]);
			e.setCreatedDate((Timestamp)object[2]);
			e.setCreatedBy((String)object[3]);
			expenseList.add(e);
		}
		
		return expenseList;
	}
	
	private Integer getTotalExpenseRecords(Map<String, Object> constraints){
		String hql = "SELECT count(1) as totalRecord from("+getDailySalesQuery()+") a";
		Query query = getSession().createSQLQuery(hql);
		query.setParameter("searchDate", (String)constraints.get(SEARCH_DATE));
		LoggingUtility.log(getClass(), "Get Expense Total: Query["+query.getQueryString()+"]");
		BigInteger totalRecord = (BigInteger) query.list().get(0);
		LoggingUtility.log(getClass(), "Get Expense List: Total["+totalRecord.intValue()+"]");
		
		return totalRecord.intValue();	
	}
	
	private String getExpensesQuery(){
		String sql = "select name,amount,created_date,created_by from other_expenses where date(created_date)=:searchDate";
		
		return sql;
	}

	public String addExpense(Expenses expenses) {
		String sql = "CALL AddExpenses(:expense, :amount, :createdby)";
		Query query = getSession().createSQLQuery(sql);
		query.setParameter("expense", expenses.getName());
		query.setParameter("amount", expenses.getAmount());
		query.setParameter("createdby", expenses.getCreatedBy());
		
		LoggingUtility.log(getClass(), "ADD Other Expense Attempt: Params["+expenses.getName()+", "+
				expenses.getAmount()+", "+expenses.getCreatedBy()+"]");

		List<?> list = query.list();
		String result = (String) list.get(0);
		LoggingUtility.log(getClass(), "Add Other Expense Attempt Result: "+result);
		
		return result;
	}

	public Page viewDailySales(Map<String, Object> constraints) {
		Page page = new Page();
		page.setPageSize((Integer)constraints.get(PAGE_SIZE));
		page.setContents(getDailySalesList(constraints));
		page.setTotalSizeOfContents(page.getContents().size());
		page.setTotalRecords(getTotalDailySales(constraints));
		if (page.getContents().size() < page.getTotalRecords()) {
			page.setPageResult((Integer)constraints.get(PAGE_NUM));
		} else {
			page.setPageResult(0);
		}
		return page;
	}
	
	public List<DailySales> getDailySalesList(Map<String, Object> constraints) {
		List<DailySales> dailySalesList = new ArrayList<DailySales>();
		String sql = getDailySalesQuery();
		Query query = getSession().createSQLQuery(sql);
		query.setParameter("searchDate", (String)constraints.get(SEARCH_DATE));
		
		query.setFirstResult((Integer)constraints.get(PAGE_NUM));
		query.setMaxResults((Integer)constraints.get(PAGE_SIZE));
		
		LoggingUtility.log(getClass(), "Get DailySales List: Params["+Arrays.asList(constraints.values().toArray())+"]");
		LoggingUtility.log(getClass(), "Get DailySales List: Query["+query.getQueryString()+"]");
		
		List<?> tempList = query.list();
		Iterator<?> iter = tempList.iterator();
		while (iter.hasNext()) {
			Object[] object = (Object[]) iter.next();
			DailySales ds = new DailySales();
			ds.setDailySalesId((Integer)object[0]);
			ds.setProductName((String)object[1]);
			ds.setCategory((String)object[2]);
			ds.setBeforeQuantity(((BigInteger)object[3]).intValue());
			ds.setUnitSold(((BigInteger)object[4]).intValue());
			ds.setUnitPrice((BigDecimal)object[5]);
			ds.setAfterQuantity(((BigDecimal)object[6]).intValue());
			ds.setCreatedDate((Timestamp)object[7]);
			ds.setCreatedBy((String)object[8]);
			dailySalesList.add(ds);
		}
		
		return dailySalesList;
	}
	
	private Integer getTotalDailySales(Map<String, Object> constraints){
		String hql = "SELECT count(1) as totalRecord from("+getDailySalesQuery()+") a";
		Query query = getSession().createSQLQuery(hql);
		query.setParameter("searchDate", (String)constraints.get(SEARCH_DATE));
		LoggingUtility.log(getClass(), "Get Daily Sales Total: Query["+query.getQueryString()+"]");
		BigInteger totalRecord = (BigInteger) query.list().get(0);
		LoggingUtility.log(getClass(), "Get Daily Sales List: Total["+totalRecord.intValue()+"]");
		
		return totalRecord.intValue();		
	}
	
	private String getDailySalesQuery(){
		StringBuilder sql = new StringBuilder();
		sql.append("select d.daily_sales_id,p.product_name,c.name category,d.before_quantity_sold,d.quantity_sold, ");
		sql.append("	d.amount,d.after_quantity_sold,d.created_date,d.created_by ");
		sql.append("from daily_sales d ");
		sql.append("join product p on p.product_id=d.daily_sales_product_id ");
		sql.append("join category c on c.category_id=p.category_id ");
		sql.append("where date(d.created_date)=:searchDate");
		
		return sql.toString();
	}

	public String addSales(DailySales sales) {
		String sql = "CALL AddDailySales(:onhandid, :productid, :quantity, :amount, :createdby)";
		Query query = getSession().createSQLQuery(sql);
		query.setParameter("onhandid", sales.getDailyOnHandId());
		query.setParameter("productid", sales.getProductId());
		query.setParameter("quantity", sales.getUnitSold());
		query.setParameter("amount", sales.getUnitPrice());
		query.setParameter("createdby", sales.getCreatedBy());
		
		LoggingUtility.log(getClass(), "ADD Daily Sales Attempt: Params["+sales.getDailyOnHandId()+", "+
											sales.getProductId()+", "+sales.getUnitSold()+", "+sales.getUnitPrice()+", "+
											sales.getCreatedBy()+"]");

		List<?> list = query.list();
		String result = (String) list.get(0);
		LoggingUtility.log(getClass(), "Add Daily Sales Attempt Result: "+result);
		
		return result;
	}

}
