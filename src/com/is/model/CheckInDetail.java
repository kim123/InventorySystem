package com.is.model;

import java.math.BigDecimal;

public class CheckInDetail {
	
	private BigDecimal startingCash;
	private BigDecimal startingGlobeEload;
	private BigDecimal startingSmartEload;
	private BigDecimal startingSunEload;
	private int onDutyStatus;
	
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
	public int getOnDutyStatus() {
		return onDutyStatus;
	}
	public void setOnDutyStatus(int onDutyStatus) {
		this.onDutyStatus = onDutyStatus;
	}
	
	

}
