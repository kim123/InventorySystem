package com.is.service.interfaze;

import java.util.List;

import com.is.model.EloadDailyBalance;
import com.is.model.EloadPrices;
import com.is.model.Page;

public interface ELoadDailyService {
	
	final String SEARCH_DATE = "searchStartDate";
	final String PAGE_NUM = "pageNum";
	final String PAGE_SIZE = "pageSize";
	
	// E-LOAD String
	final String GLOBE = "globe";
	final String SMART = "smart";
	final String SUN = "sun";
	
	final int ENABLED_PRICE_LIST_TYPE = 0;
	final int COMPLETE_PRICE_LIST_TYPE = 1;
	
	Page viewEloadDailyBalanceLogs(String searchDate);
	List<EloadDailyBalance> getEloadDailyBalanceList(String searchDate);
	String updateEloadDailyBalance(String eloadType, EloadDailyBalance eloadDailyBalance);
	
	Page viewEloadDailySalesSmart(String searchDate, int type);
	Page viewEloadDailySalesGlobe(String searchDate, int type);
	Page viewEloadDailySalesSun(String searchDate, int type);
	
	String addEloadDailySales(String eloadId, int priceId, int quantity, String createdBy);
	
	List<EloadPrices> getEloadProductIds();
	Page viewEloadPrices(String eload, Double price, String priceOperator, Double retailPrice, String retailOperator, 
							Double markupPrice, String markupOperator, String enableStatus);
	
	String addEloadPrice(EloadPrices eloadPrice);
	String updateEloadPrice(EloadPrices eloadPrice);

}
