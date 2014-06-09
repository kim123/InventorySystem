package com.is.service.interfaze;

public interface EloadService{
    
    Page viewBalances(Map<String, Object> constraints);
    String addDailyBalance(Eload eload);
    Page viewSales(Map<String, Object> constraints);
    String addDailySales(Eload eload);
    
}
