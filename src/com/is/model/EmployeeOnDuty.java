package com.is.model;

import java.sql.Timestamp;

public class EmployeeOnDuty {
	
	private int onDutyId;
	private int userId;
	private int onDutyStatus;
	private Timestamp loginDate;
	private int eloadDailyBalanceId;
	
	public int getOnDutyId() {
		return onDutyId;
	}
	public void setOnDutyId(int onDutyId) {
		this.onDutyId = onDutyId;
	}
	public int getUserId() {
		return userId;
	}
	public void setUserId(int userId) {
		this.userId = userId;
	}
	public int getOnDutyStatus() {
		return onDutyStatus;
	}
	public void setOnDutyStatus(int onDutyStatus) {
		this.onDutyStatus = onDutyStatus;
	}
	public Timestamp getLoginDate() {
		return loginDate;
	}
	public void setLoginDate(Timestamp loginDate) {
		this.loginDate = loginDate;
	}
	public int getEloadDailyBalanceId() {
		return eloadDailyBalanceId;
	}
	public void setEloadDailyBalanceId(int eloadDailyBalanceId) {
		this.eloadDailyBalanceId = eloadDailyBalanceId;
	}
	
	

}
