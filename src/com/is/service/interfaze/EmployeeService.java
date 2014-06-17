package com.is.service.interfaze;

import java.math.BigDecimal;
import java.util.Date;
import java.util.Map;

import com.is.model.CheckInDetail;

public interface EmployeeService{
	
	final String USER_ID = "userId";
	final String STARTING_CASH = "startingCash";
	final String STARTING_GLOBE_ELOAD = "startingGlobeEload";
	final String STARTING_SMART_ELOAD = "startingSmartEload";
	final String STARTING_SUN_ELOAD = "startingSunEload";
	final String TOTAL_CASH = "totalCash";
	final String CASH_HAND_OVER = "cashHandOver";
	final String ENDING_BAL_GLOBE = "endingBalGlobe";
	final String ENDING_BAL_SMART = "endingBalSmart";
	final String ENDING_BAL_SUN = "endingBalSun";
	final String JOURNAL_ENTRY = "journalEntry";
	final String ON_DUTY_ID = "onDutyId";
	final String ELOAD_DAILY_BAL_ID = "eloadDailyBalanceId";
	
	String checkIn(Map<String, Object> params);
	String checkOut(Map<String, Object> params);
	//String recordJournal(int userId, String journalEntry);
	CheckInDetail getCheckInDetail(int userId);
	Date getCheckOutDate(int userId);
	String getJournalEntry(int userId);
	BigDecimal getYesterdayPrevCashEnding();
	
}
