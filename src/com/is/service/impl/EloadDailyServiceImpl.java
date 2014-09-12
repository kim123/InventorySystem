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

import com.is.model.EloadDailyBalance;
import com.is.model.EloadDailySales;
import com.is.model.EloadPrices;
import com.is.model.Page;
import com.is.service.interfaze.ELoadDailyService;
import com.is.utilities.Constants;
import com.is.utilities.LoggingUtility;
import com.is.utilities.NumberUtility;

public class EloadDailyServiceImpl extends BaseServiceImpl implements ELoadDailyService{

	public Page viewEloadDailyBalanceLogs(Map<String, Object> constraints) {
		Page page = new Page();
		page.setPageSize((Integer)constraints.get(PAGE_SIZE));
		page.setContents(getEloadDailyBalanceList(constraints));
		page.setTotalSizeOfContents(page.getContents().size());
		page.setTotalRecords(getTotalEloadDailyBalanceRecords(constraints));
		if (page.getContents().size() < page.getTotalRecords()) {
			page.setPageResult((Integer)constraints.get(PAGE_NUM));
		} else {
			page.setPageResult(0);
		}
		return page;
	}
	
	private String getEloadDailyBalanceQuery(Map<String, Object> constraints){
		StringBuilder sql = new StringBuilder();
		sql.append("select daily_balance_id,created_by,starting_eload_globe,starting_eload_smart,starting_eload_sun, ");
		sql.append("	additional_balance_globe,additional_balance_smart,additional_balance_sun, ");
		sql.append("	total_eload_globe,total_eload_smart,total_eload_sun, ");
		sql.append("	ending_balance_globe,ending_balance_smart,ending_balance_sun, ");
		sql.append("	created_date,updated_date ");
		sql.append("from eload_daily_balances ");
		sql.append("where date(created_date)=:createdDate");
		
		return sql.toString();
	}

	public List<EloadDailyBalance> getEloadDailyBalanceList(Map<String, Object> constraints) {
		List<EloadDailyBalance> eloadDailyBalanceList = new ArrayList<EloadDailyBalance>();
		String sql = getEloadDailyBalanceQuery(constraints);
		Query query = getSession().createSQLQuery(sql);
		query.setParameter("createdDate", (String)constraints.get(SEARCH_DATE));
		query.setFirstResult((Integer)constraints.get(PAGE_NUM));
		query.setMaxResults((Integer)constraints.get(PAGE_SIZE));
		
		LoggingUtility.log(getClass(), "Get EloadDailyBalance List: Params["+Arrays.asList(constraints.values().toArray())+"]");
		LoggingUtility.log(getClass(), "Get EloadDailyBalance List: Query["+query.getQueryString()+"]");
		
		List<?> tempList = query.list();
		Iterator<?> iter = tempList.iterator();
		while (iter.hasNext()) {
			Object[] object = (Object[]) iter.next();
			EloadDailyBalance e = new EloadDailyBalance();
			e.setEloadDailyBalanceId((Integer)object[0]);
			e.setCreaetdBy((String)object[1]);
			e.setStartingEloadGlobe(NumberUtility.setBigDecimal((BigDecimal)object[2]));
			e.setStartingEloadSmart(NumberUtility.setBigDecimal((BigDecimal)object[3]));
			e.setStartingEloadSun(NumberUtility.setBigDecimal((BigDecimal)object[4]));
			e.setAdditionalBalanceGlobe(NumberUtility.setBigDecimal((BigDecimal)object[5]));
			e.setAdditionalBalanceSmart(NumberUtility.setBigDecimal((BigDecimal)object[6]));
			e.setAdditionalBalanceSun(NumberUtility.setBigDecimal((BigDecimal)object[7]));
			e.setTotalEloadGlobe(NumberUtility.setBigDecimal((BigDecimal)object[8]));
			e.setTotalEloadSmart(NumberUtility.setBigDecimal((BigDecimal)object[9]));
			e.setTotalEloadSun(NumberUtility.setBigDecimal((BigDecimal)object[10]));
			e.setEndingBalanceGlobe(NumberUtility.setBigDecimal((BigDecimal)object[11]));
			e.setEndingBalanceSmart(NumberUtility.setBigDecimal((BigDecimal)object[12]));
			e.setEndingBalanceSun(NumberUtility.setBigDecimal((BigDecimal)object[13]));
			e.setCreatedDate((Timestamp)object[14]);
			e.setUpdatedDate((Timestamp)object[15]);
			eloadDailyBalanceList.add(e);
		}
		
		return eloadDailyBalanceList;
	}
	
	private Integer getTotalEloadDailyBalanceRecords(Map<String, Object> constraints){
		String hql = "SELECT count(1) as totalRecord from("+getEloadDailyBalanceQuery(constraints)+") a";
		Query query = getSession().createSQLQuery(hql);
		query.setParameter("createdDate", (String)constraints.get(SEARCH_DATE));
		query.setFirstResult((Integer)constraints.get(PAGE_NUM));
		query.setMaxResults((Integer)constraints.get(PAGE_SIZE));
		
		LoggingUtility.log(getClass(), "Get EloadDailyBalanceRecords Total: Query["+query.getQueryString()+"]");
		BigInteger totalRecord = (BigInteger) query.list().get(0);
		LoggingUtility.log(getClass(), "Get EloadDailyBalanceRecords: Total["+totalRecord.intValue()+"]");
		
		return totalRecord.intValue();	
	}

	public String updateEloadDailyBalance(EloadDailyBalance eloadDailyBalance) {
		String sql = "CALL UpdateEloadDailyBalance(:eloadDailyBalanceId, :additionalBalanceGlobe, :additionalBalanceSmart, :additionalBalanceSun, :updatedBy)";
		Query query = getSession().createSQLQuery(sql);
		query.setParameter("eloadDailyBalanceId", eloadDailyBalance.getEloadDailyBalanceId());
		query.setParameter("additionalBalanceGlobe", eloadDailyBalance.getAdditionalBalanceGlobe());
		query.setParameter("additionalBalanceSmart", eloadDailyBalance.getAdditionalBalanceSmart());
		query.setParameter("additionalBalanceSun", eloadDailyBalance.getAdditionalBalanceSun());
		query.setParameter("updatedBy", eloadDailyBalance.getCreaetdBy());
		
		LoggingUtility.log(getClass(), "Update EloadDailyBalance Attempt: Params["+eloadDailyBalance.getEloadDailyBalanceId()+", "+
				eloadDailyBalance.getAdditionalBalanceGlobe()+", "+eloadDailyBalance.getAdditionalBalanceSmart()+", "+eloadDailyBalance.getAdditionalBalanceSun()+"]");

		List<?> list = query.list();
		String result = (String) list.get(0);
		LoggingUtility.log(getClass(), "Update EloadDailyBalance Attempt Result: "+result);
		
		return result;
	}

	public Page viewEloadDailySalesSmart(String searchDate, int type) {
		Page page = new Page();
		page.setContents(getEloadDailySaleList(searchDate, Constants.ELOAD_SMART_PRODUCT_ID, type));

		return page;
	}

	public Page viewEloadDailySalesGlobe(String searchDate, int type) {
		Page page = new Page();
		page.setContents(getEloadDailySaleList(searchDate, Constants.ELOAD_GLOBE_PRODUCT_ID, type));

		return page;
	}

	public Page viewEloadDailySalesSun(String searchDate, int type) {
		Page page = new Page();
		page.setContents(getEloadDailySaleList(searchDate, Constants.ELOAD_SUN_PRODUCT_ID, type));

		return page;
	}
	
	private List<EloadDailySales> getEloadDailySaleList(String searchDate, String eload, int type){
		List<EloadDailySales> eloadDailySaleList = new ArrayList<EloadDailySales>();
		StringBuilder sql = new StringBuilder("select b.prize_id,b.price,");
		sql.append(" 		(CASE a.quantity IS NULL WHEN TRUE THEN 0 ELSE a.quantity END) quantity, ");
		sql.append(" 		(CASE a.total IS NULL WHEN TRUE THEN 0 ELSE a.total END) total, ");
		sql.append(" 		a.created_by,a.created_date ");
		sql.append(" from ( ");
		sql.append(" 	select s.price_id,s.quantity,s.total,s.created_by,s.created_date from eload_daily_sales s ");
		sql.append(" 	where date(created_date)=:createdDate and eload_product_id=:productId ");
		sql.append(" ) a right join ( ");
		if (type==ENABLED_PRICE_LIST_TYPE) {
			sql.append(" 	select prize_id,price,enable_status from eload_daily_prices where eload_product_id=:productId2 and enable_status=0 order by price asc ");
		} else {
			sql.append(" 	select prize_id,price,enable_status from eload_daily_prices where eload_product_id=:productId2 order by price asc ");
		}
		sql.append(" ) b on b.prize_id=a.price_id ");
		
		Query query = getSession().createSQLQuery(sql.toString());
		query.setParameter("createdDate", searchDate);
		query.setParameter("productId", eload);
		query.setParameter("productId2", eload);
		
		LoggingUtility.log(getClass(), "Get EloadDailyBalance List: Params["+searchDate+", "+eload+", "+eload+"]");
		LoggingUtility.log(getClass(), "Get EloadDailyBalance List: Query["+query.getQueryString()+"]");
		
		List<?> list = query.list();
		Iterator<?> iterator = list.iterator();
		while (iterator.hasNext()) {
			Object[] o = (Object[]) iterator.next();
			EloadDailySales e = new EloadDailySales();
			e.setPriceId((Integer)o[0]);
			e.setPrice((BigDecimal)o[1]);
			e.setQuantity((Integer)o[2]);
			e.setTotal((BigDecimal)o[3]);
			e.setUpdatedBy((String)o[4]);
			e.setUpdatedDate((Timestamp)o[5]);
			eloadDailySaleList.add(e);
		}
		
		return eloadDailySaleList;
	}

	public String addEloadDailySales(String eloadId, EloadDailySales[] eloadDailySalesArray, String createdBy) {
		String sql = "CALL AddEloadDailySales(:eloadproductid,:salesvalue,:recordnumber,:updatedBy)";
		//salesvalue -> priceid-quantity;
		Query query = getSession().createSQLQuery(sql);
		query.setParameter("eloadproductid", eloadId);
		
		StringBuilder salesValueStr = new StringBuilder();
		for (EloadDailySales e : eloadDailySalesArray) {
			salesValueStr.append(e.getPriceId()).append("-").append(e.getQuantity()).append(";");
		}
		
		query.setParameter("salesvalue", salesValueStr.toString());
		query.setParameter("recordnumber", eloadDailySalesArray.length);
		query.setParameter("updatedBy", createdBy);
		
		LoggingUtility.log(getClass(), "Update EloadDailySales Attempt: Params["+eloadId+", "+salesValueStr.toString()+", "+
											eloadDailySalesArray.length+", "+createdBy+"]");

		List<?> list = query.list();
		String result = (String) list.get(0);
		LoggingUtility.log(getClass(), "Update EloadDailySales Attempt Result: "+result);
		
		return result;
	}

	public Page viewEloadPrices(int pageNum, int pageSize, String eload) {
		Page page = new Page();
		page.setPageSize(pageSize);
		page.setContents(getEloadPriceList(pageNum, pageSize, eload));
		page.setTotalSizeOfContents(page.getContents().size());
		page.setTotalRecords(getTotalEloadPriceList(pageNum, pageSize, eload));
		if (page.getContents().size() < page.getTotalRecords()) {
			page.setPageResult(pageNum);
		} else {
			page.setPageResult(0);
		}
		return page;
	}
	
	private String getEloadPricesQuery(int pageNum, int pageSize, String eload){
		StringBuilder sql = new StringBuilder("select prize_id,price,retail_price,markup_price,enable_status,created_by,created_date");
		sql.append(" from eload_daily_prices where eload_product_id='");
		if (eload.equals(GLOBE)) {
			sql.append(Constants.ELOAD_GLOBE_PRODUCT_ID);
		} else if (eload.equals(SMART)) {
			sql.append(Constants.ELOAD_SMART_PRODUCT_ID);
		} else if (eload.equals(SUN)) {
			sql.append(Constants.ELOAD_SUN_PRODUCT_ID);
		}
		sql.append("' order by price asc ");
		
		return sql.toString();
	}
	
	private List<EloadPrices> getEloadPriceList(int pageNum, int pageSize, String eload){
		List<EloadPrices> eloadPriceList = new ArrayList<EloadPrices>();
		String sql = getEloadPricesQuery(pageNum, pageSize, eload);
		Query query = getSession().createSQLQuery(sql);
		query.setFirstResult(pageNum);
		query.setMaxResults(pageSize);
		
		LoggingUtility.log(getClass(), "Get EloadPrices List: Params["+pageNum+", "+pageSize+", "+eload+"]");
		LoggingUtility.log(getClass(), "Get EloadPrices List: Query["+query.getQueryString()+"]");
		
		List<?> tempList = query.list();
		Iterator<?> iter = tempList.iterator();
		while (iter.hasNext()) {
			Object[] o = (Object[]) iter.next();
			EloadPrices e = new EloadPrices();
			e.setPriceId((Integer)o[0]);
			e.setPrice(NumberUtility.setBigDecimal((BigDecimal)o[1]));
			e.setRetailPrice(NumberUtility.setBigDecimal((BigDecimal)o[2]));
			e.setMarkupPrice(NumberUtility.setBigDecimal((BigDecimal)o[3]));
			e.setEnableStatus((Integer)o[4]);
			e.setUpdatedBy((String)o[5]);
			e.setUpdatedDate((Timestamp)o[6]);
			eloadPriceList.add(e);
		}
		
		return eloadPriceList;
	}
	
	private Integer getTotalEloadPriceList(int pageNum, int pageSize, String eload){
		String hql = "SELECT count(1) as totalRecord from("+getEloadPricesQuery(pageNum, pageSize, eload)+") a";
		Query query = getSession().createSQLQuery(hql);
		query.setFirstResult(pageNum);
		query.setMaxResults(pageSize);
		
		LoggingUtility.log(getClass(), "Get EloadPriceRecords Total: Query["+query.getQueryString()+"]");
		BigInteger totalRecord = (BigInteger) query.list().get(0);
		LoggingUtility.log(getClass(), "Get EloadPriceRecords: Total["+totalRecord.intValue()+"]");
		
		return totalRecord.intValue();	
	}

	public String addEloadPrice(EloadPrices eloadPrice) {
		String sql = "CALL AddEloadDailyPrice(:p_eloadproductid,:p_price,:p_markupprice,:p_retailprice,:p_created_by)";
		Query query = getSession().createSQLQuery(sql);
		query.setParameter("p_eloadproductid", eloadPrice.getEloadProductId());
		query.setParameter("p_price", eloadPrice.getPrice());
		query.setParameter("p_markupprice", eloadPrice.getMarkupPrice());
		query.setParameter("p_retailprice", eloadPrice.getRetailPrice());
		query.setParameter("p_created_by", eloadPrice.getUpdatedBy());
		
		LoggingUtility.log(getClass(), "Add Eload Price Attempt: Params["+eloadPrice.getEloadProductId()+", "+eloadPrice.getPrice()+", "+
												eloadPrice.getMarkupPrice()+", "+eloadPrice.getRetailPrice()+", "+eloadPrice.getUpdatedBy()+"]");
		
		List<?> list = query.list();
		String result = (String)list.get(0);
		
		return result;
	}

	public String updateEloadPrice(EloadPrices eloadPrice) {
		String sql = "CALL UpdateEloadDailyPrice(:p_priceId,:p_enableStatus,:p_updateby)";
		Query query = getSession().createSQLQuery(sql);
		query.setParameter("p_priceId", eloadPrice.getPriceId());
		query.setParameter("p_enableStatus", eloadPrice.getEnableStatus());
		query.setParameter("p_updateby", eloadPrice.getUpdatedBy());
		
		LoggingUtility.log(getClass(), "Add Eload Price Attempt: Params["+eloadPrice.getPriceId()+", "+eloadPrice.getEnableStatus()+", "+
												eloadPrice.getUpdatedBy()+"]");
		
		List<?> list = query.list();
		String result = (String)list.get(0);
		
		return result;
	}

}
