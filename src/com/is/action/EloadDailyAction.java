package com.is.action;

import com.is.model.Page;
import com.is.service.impl.EloadDailyServiceImpl;
import com.is.service.interfaze.ELoadDailyService;

@SuppressWarnings("serial")
public class EloadDailyAction extends BaseAction{
	
	private static ELoadDailyService eloadDailyService;
	
	static {
		if (eloadDailyService==null) {
			eloadDailyService = new EloadDailyServiceImpl();
		}
	}
	
	private String searchDate;
	private Page pageEloadBalance;
	private Page pageEloadSalesSmart;
	private Page pageEloadSalesGlobe;
	private Page pageEloadSalesSun;
	private String updatedBy; // for the Eload Daily Sales
	private String updatedDate; // for the Eload Daily Sales
	

}
