package com.is.model;

import java.util.List;

public class Page {
	
	private List<?> contents;
	private int totalRecords;

	public List<?> getContents() {
		return contents;
	}
	public void setContents(List<?> contents) {
		this.contents = contents;
	}
	public int getTotalRecords() {
		return totalRecords;
	}
	public void setTotalRecords(int totalRecords) {
		this.totalRecords = totalRecords;
	}
	
	

}
