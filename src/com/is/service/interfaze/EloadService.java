package com.is.service.interfaze;

import java.util.Map;

import com.is.model.Page;

public interface EloadService{
    
    Page viewBalances(Map<String, Object> constraints);
    String addDailyBalance(Eload eload);
    Page viewSales(Map<String, Object> constraints);
    String addDailySales(Eload eload);
    
}
