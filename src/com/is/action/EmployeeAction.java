package com.is.action;

import java.io.PrintWriter;
import java.math.BigDecimal;
import java.util.Date;
import java.util.HashMap;
import java.util.Map;

import org.json.JSONException;
import org.json.JSONObject;

import com.is.model.CheckInDetail;
import com.is.service.impl.EmployeeServiceImpl;
import com.is.service.interfaze.EmployeeService;
import com.is.utilities.Constants;
import com.is.utilities.SessionUtility;

@SuppressWarnings("serial")
public class EmployeeAction extends BaseAction{
	
	private static EmployeeService employeeService;
	
	static {
		if (employeeService==null) {
			employeeService = new EmployeeServiceImpl();
		}
	}
	
	private BigDecimal startingCash;
	private BigDecimal startingGlobeEload;
	private BigDecimal startingSmartEload;
	private BigDecimal startingSunEload;
	private CheckInDetail checkInDetail;
	private String journalEntry;
	private Date checkOutDate;
	private BigDecimal totalCash;
	private BigDecimal cashHandOver;
	private BigDecimal endingBalanceGlobe;
	private BigDecimal endingBalanceSmart;
	private BigDecimal endingBalanceSun;
	
	public BigDecimal getTotalCash() {
		return totalCash;
	}
	public void setTotalCash(BigDecimal totalCash) {
		this.totalCash = totalCash;
	}
	public BigDecimal getCashHandOver() {
		return cashHandOver;
	}
	public void setCashHandOver(BigDecimal cashHandOver) {
		this.cashHandOver = cashHandOver;
	}
	public BigDecimal getEndingBalanceGlobe() {
		return endingBalanceGlobe;
	}
	public void setEndingBalanceGlobe(BigDecimal endingBalanceGlobe) {
		this.endingBalanceGlobe = endingBalanceGlobe;
	}
	public BigDecimal getEndingBalanceSmart() {
		return endingBalanceSmart;
	}
	public void setEndingBalanceSmart(BigDecimal endingBalanceSmart) {
		this.endingBalanceSmart = endingBalanceSmart;
	}
	public BigDecimal getEndingBalanceSun() {
		return endingBalanceSun;
	}
	public void setEndingBalanceSun(BigDecimal endingBalanceSun) {
		this.endingBalanceSun = endingBalanceSun;
	}
	public CheckInDetail getCheckInDetail() {
		return checkInDetail;
	}
	public void setCheckInDetail(CheckInDetail checkInDetail) {
		this.checkInDetail = checkInDetail;
	}
	public BigDecimal getStartingCash() {
		return startingCash;
	}
	public void setStartingCash(BigDecimal startingCash) {
		this.startingCash = startingCash;
	}
	public BigDecimal getStartingGlobeEload() {
		return startingGlobeEload;
	}
	public void setStartingGlobeEload(BigDecimal startingGlobeEload) {
		this.startingGlobeEload = startingGlobeEload;
	}
	public BigDecimal getStartingSmartEload() {
		return startingSmartEload;
	}
	public void setStartingSmartEload(BigDecimal startingSmartEload) {
		this.startingSmartEload = startingSmartEload;
	}
	public BigDecimal getStartingSunEload() {
		return startingSunEload;
	}
	public void setStartingSunEload(BigDecimal startingSunEload) {
		this.startingSunEload = startingSunEload;
	}
	public String getJournalEntry() {
		return journalEntry;
	}
	public void setJournalEntry(String journalEntry) {
		this.journalEntry = journalEntry;
	}
	
	public String checkInPage(){
		setMenuActive("6");
		startingCash = employeeService.getYesterdayPrevCashEnding();
		checkInDetail = employeeService.getCheckInDetail(SessionUtility.getUser().getUserId());
		
		return SUCCESS;
	}
	
	public String checkIn(){
		// set validation same as checkIn.jsp
		PrintWriter out = getPrintWriter();
		JSONObject json = new JSONObject();
		Map<String,Object> params = new HashMap<String, Object>();
		params.put(EmployeeService.USER_ID, SessionUtility.getUser().getUserId());
		params.put(EmployeeService.STARTING_CASH, startingCash);
		params.put(EmployeeService.STARTING_GLOBE_ELOAD, startingGlobeEload);
		params.put(EmployeeService.STARTING_SMART_ELOAD, startingSmartEload);
		params.put(EmployeeService.STARTING_SUN_ELOAD, startingSunEload);
		String result = employeeService.checkIn(params);
		try {
			if (result.equals(Constants.SUCCESS)) {
				json.put(Constants.SUCCESS, true);
			} else {
				json.put(Constants.SUCCESS, false);
			}
			json.put("message", result);
		} catch (JSONException e) {
			e.printStackTrace();
		}
		printJsonAndCloseWriter(out, json);
		
		return null;
	}
	
	public String checkOutPage(){
		setMenuActive("17");
		checkOutDate = employeeService.getCheckOutDate(SessionUtility.getUser().getUserId());
		journalEntry = employeeService.getJournalEntry(SessionUtility.getUser().getUserId());
				
		return SUCCESS;
	}
	
	public String checkOut(){
		// set validation the same as checkOut.jsp
		PrintWriter out = getPrintWriter();
		JSONObject json = new JSONObject();
		Map<String,Object> params = new HashMap<String, Object>();
		params.put(EmployeeService.USER_ID, SessionUtility.getUser().getUserId());
		params.put(EmployeeService.ON_DUTY_ID, SessionUtility.getEmployeeOnDuty().getOnDutyId());
		params.put(EmployeeService.ELOAD_DAILY_BAL_ID, SessionUtility.getEmployeeOnDuty().getEloadDailyBalanceId());
		params.put(EmployeeService.TOTAL_CASH, totalCash);
		params.put(EmployeeService.CASH_HAND_OVER, cashHandOver);
		params.put(EmployeeService.ENDING_BAL_GLOBE, endingBalanceGlobe);
		params.put(EmployeeService.ENDING_BAL_SMART, endingBalanceSmart);
		params.put(EmployeeService.ENDING_BAL_SUN, endingBalanceSun);
		params.put(EmployeeService.JOURNAL_ENTRY, journalEntry);
		
		String result = employeeService.checkOut(params);
		try {
			if (result.equals(Constants.SUCCESS)) {
				json.put(Constants.SUCCESS, true);
			} else {
				json.put(Constants.SUCCESS, false);
			}
			json.put("message", result);
		} catch (JSONException e) {
			e.printStackTrace();
		}
		printJsonAndCloseWriter(out, json);

		
		return null;
	}
	
	/*public String recordJournalPage(){
		setMenuActive("11");
		return SUCCESS;
	}*/
	
	/*public String recordJournalEntry(){
		PrintWriter out = getPrintWriter();
		JSONObject json = new JSONObject();
		String result = employeeService.recordJournal(SessionUtility.getUser().getUserId(), journalEntry);
		try {
			if (result.equals(Constants.SUCCESS)) {
				json.put(Constants.SUCCESS, true);
			} else {
				json.put(Constants.SUCCESS, false);
			}
			json.put("message", result);
		} catch (JSONException e) {
			e.printStackTrace();
		}
		printJsonAndCloseWriter(out, json);
		
		return null;
	}*/
	
	public Date getCheckOutDate() {
		return checkOutDate;
	}
	public void setCheckOutDate(Date checkOutDate) {
		this.checkOutDate = checkOutDate;
	}

}
