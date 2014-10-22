package com.is.service.impl;

import java.math.BigDecimal;
import java.math.BigInteger;
import java.math.RoundingMode;
import java.sql.Timestamp;
import java.util.ArrayList;
import java.util.Iterator;
import java.util.List;

import org.apache.commons.lang3.StringUtils;
import org.hibernate.Query;

import com.is.model.EloadDailyBalance;
import com.is.model.EloadDailySales;
import com.is.model.EloadPrices;
import com.is.model.Page;
import com.is.service.interfaze.ELoadDailyService;
import com.is.utilities.Constants;
import com.is.utilities.LoggingUtility;
import com.is.utilities.NumberUtility;
import com.is.utilities.UserUtility;

public class EloadDailyServiceImpl extends BaseServiceImpl implements ELoadDailyService{

	public Page viewEloadDailyBalanceLogs(String searchDate) {
		Page page = new Page();
		//page.setPageSize((Integer)constraints.get(PAGE_SIZE));
		page.setContents(getEloadDailyBalanceList(searchDate));
		page.setTotalSizeOfContents(page.getContents().size());
		//page.setTotalRecords(getTotalEloadDailyBalanceRecords(constraints));
		//if (page.getContents().size() < page.getTotalRecords()) {
		//	page.setPageResult((Integer)constraints.get(PAGE_NUM));
		//} else {
		//	page.setPageResult(0);
		//}
		return page;
	}
	
	private String getEloadDailyBalanceQuery(String searchDate){
		StringBuilder sql = new StringBuilder();
		sql.append("select daily_balance_id,created_by,starting_eload_globe,starting_eload_smart,starting_eload_sun, ");
		sql.append(" 	(CASE additional_balance_globe IS NULL WHEN TRUE THEN 0 ELSE additional_balance_globe END) additional_balance_globe, ");
		sql.append(" 	(CASE additional_balance_smart IS NULL WHEN TRUE THEN 0 ELSE additional_balance_smart END) additional_balance_smart, ");
		sql.append(" 	(CASE additional_balance_sun IS NULL WHEN TRUE THEN 0 ELSE additional_balance_sun END) additional_balance_sun, ");
		sql.append("	total_eload_globe,total_eload_smart,total_eload_sun, ");
		sql.append("	ending_balance_globe,ending_balance_smart,ending_balance_sun, ");
		sql.append(" 	actual_sold_out_globe,actual_sold_out_smart,actual_sold_out_sun, ");
		sql.append("	created_date,updated_date_smart,updated_date_globe,updated_date_sun ");
		sql.append("from eload_daily_balances ");
		sql.append("where date(created_date)=:createdDate");
		
		return sql.toString();
	}

	public List<EloadDailyBalance> getEloadDailyBalanceList(String searchDate) {
		List<EloadDailyBalance> eloadDailyBalanceList = new ArrayList<EloadDailyBalance>();
		String sql = getEloadDailyBalanceQuery(searchDate);
		Query query = getSession().createSQLQuery(sql);
		query.setParameter("createdDate", searchDate);
		
		LoggingUtility.log(getClass(), "Get EloadDailyBalance List: Params["+searchDate+"]");
		LoggingUtility.log(getClass(), "Get EloadDailyBalance List: Query["+query.getQueryString()+"]");
		
		List<?> tempList = query.list();
		Iterator<?> iter = tempList.iterator();
		while (iter.hasNext()) {
			Object[] object = (Object[]) iter.next();
			EloadDailyBalance e = new EloadDailyBalance();
			e.setEloadDailyBalanceId((Integer)object[0]);
			e.setCreaetdBy(UserUtility.getUserBasedOnUserId(Integer.valueOf((String)object[1])).getUserName());
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
			e.setActualSoldOutGlobe(NumberUtility.setBigDecimal((BigDecimal)object[14]));
			e.setActualSoldOutSmart(NumberUtility.setBigDecimal((BigDecimal)object[15]));
			e.setActualSoldOutSun(NumberUtility.setBigDecimal((BigDecimal)object[16]));
			e.setCreatedDate((Timestamp)object[17]);
			e.setUpdatedDateSmart((Timestamp)object[18]);
			e.setUpdatedDateGlobe((Timestamp)object[19]);
			e.setUpdatedDateSun((Timestamp)object[20]);
			eloadDailyBalanceList.add(e);
		}
		
		return eloadDailyBalanceList;
	}
	
	/*private Integer getTotalEloadDailyBalanceRecords(String searchDate){
		String hql = "SELECT count(1) as totalRecord from("+getEloadDailyBalanceQuery(searchDate)+") a";
		Query query = getSession().createSQLQuery(hql);
		query.setParameter("createdDate", searchDate);
		
		LoggingUtility.log(getClass(), "Get EloadDailyBalanceRecords Total: Query["+query.getQueryString()+"]");
		BigInteger totalRecord = (BigInteger) query.list().get(0);
		LoggingUtility.log(getClass(), "Get EloadDailyBalanceRecords: Total["+totalRecord.intValue()+"]");
		
		return totalRecord.intValue();	
	}*/

	public String updateEloadDailyBalance(String eloadType, EloadDailyBalance eloadDailyBalance) {
		String sql = "CALL UpdateEloadDailyBalance(:eloadDailyBalanceId, :additionalBalance, :eloadType, :updatedBy)";
		Query query = getSession().createSQLQuery(sql);
		query.setParameter("eloadDailyBalanceId", eloadDailyBalance.getEloadDailyBalanceId());
		query.setParameter("additionalBalance", eloadDailyBalance.getAdditionalBalance());
		query.setParameter("eloadType", eloadType);
		query.setParameter("updatedBy", eloadDailyBalance.getCreaetdBy());
		
		LoggingUtility.log(getClass(), "Update EloadDailyBalance Attempt: Params["+eloadDailyBalance.getEloadDailyBalanceId()+", "+
				eloadDailyBalance.getAdditionalBalance()+", "+eloadType+", "+eloadDailyBalance.getCreaetdBy()+"]");

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
		sql.append(" 	select s.price_id,SUM(s.quantity) quantity, SUM((s.total*s.quantity)) total,s.created_by,s.created_date from eload_daily_sales s");
		sql.append(" 	where date(created_date)=:createdDate and eload_product_id=:productId group by s.price_id ");
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
		
		LoggingUtility.log(getClass(), "Get EloadDailySales List: Params["+searchDate+", "+eload+", "+eload+"]");
		LoggingUtility.log(getClass(), "Get EloadDailySales List: Query["+query.getQueryString()+"]");
		
		List<?> list = query.list();
		Iterator<?> iterator = list.iterator();
		while (iterator.hasNext()) {
			Object[] o = (Object[]) iterator.next();
			EloadDailySales e = new EloadDailySales();
			e.setPriceId((Integer)o[0]);
			e.setPrice((BigDecimal)o[1]);
			e.setQuantity((int)((double)o[2]));
			e.setTotal(new BigDecimal(e.getPrice().doubleValue()*e.getQuantity()).setScale(2, RoundingMode.CEILING));
			//e.setTotal(new BigDecimal((double)o[3]));
			e.setUpdatedBy((String)o[4]);
			e.setUpdatedDate((Timestamp)o[5]);
			eloadDailySaleList.add(e);
		}
		
		return eloadDailySaleList;
	}

	public String addEloadDailySales(String eloadId, int priceId, int quantity, String createdBy) {
		String eloadType =  "";
		if (eloadId.equals(Constants.ELOAD_GLOBE_PRODUCT_ID)) {
			eloadType = GLOBE;
		} else if (eloadId.equals(Constants.ELOAD_SMART_PRODUCT_ID)) {
			eloadType = SMART;
		} else if (eloadId.equals(Constants.ELOAD_SUN_PRODUCT_ID)) {
			eloadType = SUN;
		}
		String sql = "CALL AddEloadDailySales(:eloadproductid,:priceid,:quantity,:updatedBy,:eloadTypef)";
		Query query = getSession().createSQLQuery(sql);
		query.setParameter("eloadproductid", eloadId);
		query.setParameter("priceid", priceId);
		query.setParameter("quantity", quantity);
		query.setParameter("updatedBy", createdBy);
		query.setParameter("eloadTypef", eloadType);
		
		LoggingUtility.log(getClass(), "Update EloadDailySales Attempt: Params["+eloadId+", "+priceId+", "+quantity+", "+createdBy+", "+eloadType+"]");

		List<?> list = query.list();
		String result = (String) list.get(0);
		LoggingUtility.log(getClass(), "Update EloadDailySales Attempt Result: "+result);
		
		return result;
	}

	public Page viewEloadPrices(String eload, Double price, String priceOperator, Double retailPrice, String retailOperator, 
									Double markupPrice, String markupOperator, String enableStatus) {
		Page page = new Page();
		//page.setPageSize(pageSize);
		page.setContents(getEloadPriceList(eload,price,priceOperator,retailPrice,retailOperator,markupPrice,markupOperator,enableStatus));
		page.setTotalSizeOfContents(page.getContents().size());
		page.setTotalRecords(getTotalEloadPriceList(eload,price,priceOperator,retailPrice,retailOperator,markupPrice,markupOperator,enableStatus));
		//if (page.getContents().size() < page.getTotalRecords()) {
		//	page.setPageResult(pageNum);
		//} else {
		//	page.setPageResult(0);
		//}
		return page;
	}
	
	private String getEloadPricesQuery(String eload, Double price, String priceOperator, Double retailPrice, String retailOperator, 
											Double markupPrice, String markupOperator, String enableStatus){
		StringBuilder sql = new StringBuilder("select prize_id,price,retail_price,markup_price,enable_status,created_by,created_date");
		sql.append(" from eload_daily_prices where eload_product_id='");
		if (eload.equals(GLOBE)) {
			sql.append(Constants.ELOAD_GLOBE_PRODUCT_ID);
		} else if (eload.equals(SMART)) {
			sql.append(Constants.ELOAD_SMART_PRODUCT_ID);
		} else if (eload.equals(SUN)) {
			sql.append(Constants.ELOAD_SUN_PRODUCT_ID);
		}
		sql.append("' ");
		if (StringUtils.isNotEmpty(priceOperator) && price!=null) {
			sql.append(" and price ").append(priceOperator).append(" ").append(price);
		}
		if (StringUtils.isNotEmpty(retailOperator) && retailPrice!=null) {
			sql.append(" and retail_price ").append(retailOperator).append(" ").append(retailPrice);
		}
		if (StringUtils.isNotEmpty(markupOperator) && markupPrice!=null) {
			sql.append(" and markup_price ").append(markupOperator).append(" ").append(markupPrice);
		}
		if (StringUtils.isNotEmpty(enableStatus)) {
			sql.append(" and enable_status = '").append(enableStatus).append("' ");
		}
		sql.append(" order by price asc ");
		
		return sql.toString();
	}
	
	private List<EloadPrices> getEloadPriceList(String eload, Double price, String priceOperator, Double retailPrice, String retailOperator, 
													Double markupPrice, String markupOperator, String enableStatus){
		List<EloadPrices> eloadPriceList = new ArrayList<EloadPrices>();
		String sql = getEloadPricesQuery(eload,price,priceOperator,retailPrice,retailOperator,markupPrice,markupOperator,enableStatus);
		Query query = getSession().createSQLQuery(sql);
		
		LoggingUtility.log(getClass(), "Get EloadPrices List: Params["+eload+"]");
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
	
	private Integer getTotalEloadPriceList(String eload, Double price, String priceOperator, Double retailPrice, String retailOperator, 
												Double markupPrice, String markupOperator, String enableStatus){
		String hql = "SELECT count(1) as totalRecord from("+getEloadPricesQuery(eload,price,priceOperator,retailPrice,retailOperator,markupPrice,markupOperator,enableStatus)+") a";
		Query query = getSession().createSQLQuery(hql);
		
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
	
	public List<EloadPrices> getEloadProductIds(){
		List<EloadPrices> eloadProductIds = new ArrayList<EloadPrices>();
		
		EloadPrices eloadSmart = new EloadPrices();
		eloadSmart.setEloadName(SMART.toUpperCase());
		eloadSmart.setEloadProductId(Integer.parseInt(Constants.ELOAD_SMART_PRODUCT_ID));
		eloadProductIds.add(eloadSmart);
		
		EloadPrices eloadGlobe = new EloadPrices();
		eloadGlobe.setEloadName(GLOBE.toUpperCase());
		eloadGlobe.setEloadProductId(Integer.parseInt(Constants.ELOAD_GLOBE_PRODUCT_ID));
		eloadProductIds.add(eloadGlobe);
		
		EloadPrices eloadSun = new EloadPrices();
		eloadSun.setEloadName(SUN.toUpperCase());
		eloadSun.setEloadProductId(Integer.parseInt(Constants.ELOAD_SUN_PRODUCT_ID));
		eloadProductIds.add(eloadSun);
		
		return eloadProductIds;
	}
	
	public static void main(String[]args){
		double d = 13.00;
		int i = 0;
		System.out.println(new BigDecimal(d*i).setScale(2, RoundingMode.CEILING));
	}

}
