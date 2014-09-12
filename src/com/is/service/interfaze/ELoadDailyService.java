package com.is.service.interfaze;

import java.util.List;
import java.util.Map;

import com.is.model.EloadDailyBalance;
import com.is.model.EloadDailySales;
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
	
	Page viewEloadDailyBalanceLogs(Map<String, Object> constraints);
	List<EloadDailyBalance> getEloadDailyBalanceList(Map<String, Object> constraints);
	String updateEloadDailyBalance(EloadDailyBalance eloadDailyBalance);
	
	Page viewEloadDailySalesSmart(String searchDate, int type);
	Page viewEloadDailySalesGlobe(String searchDate, int type);
	Page viewEloadDailySalesSun(String searchDate, int type);
	
	String addEloadDailySales(String eloadId, EloadDailySales[] eloadDailySalesArray, String createdBy);
	
	Page viewEloadPrices(int pageNum, int pageSize, String eload);
	
	String addEloadPrice(EloadPrices eloadPrice);
	String updateEloadPrice(EloadPrices eloadPrice);

}
