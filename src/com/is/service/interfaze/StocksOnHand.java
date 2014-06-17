package com.is.service.interfaze;

import java.util.Map;

import com.is.model.Page;

public interface StocksOnHand{

    Page viewStocksOnHandLogs(Map<String, Object> constraints);
    String updateStocksOnHand(StocksOnHand stocks);

}
