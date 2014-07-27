package com.is.service.interfaze;

import java.util.Map;

import com.is.model.EloadDailyBalance;
import com.is.model.EloadDailySales;
import com.is.model.Page;

public interface EloadService{
    
    Page viewBalances(Map<String, Object> constraints);
    String addDailyBalance(EloadDailyBalance eload);
    Page viewSales(Map<String, Object> constraints);
    String addDailySales(EloadDailySales eload);
    
}
