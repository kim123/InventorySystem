package com.is.model;

import java.util.List;

public class Page {
	
	private List<?> contents;
	private int totalSizeOfContents;
	private int totalRecords;
	private int pageResult;
	private int pageNum;
	private int pageSize;
	private List<String> parameters;

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
	public int getPageResult() {
		return pageResult;
	}
	public void setPageResult(int pageResult) {
		this.pageResult = pageResult;
	}
	public int getPageSize() {
		return pageSize;
	}
	public void setPageSize(int pageSize) {
		this.pageSize = pageSize;
	}
	public List<String> getParameters() {
		return parameters;
	}
	public void setParameters(List<String> parameters) {
		this.parameters = parameters;
	}
	public int getPageNum() {
		return pageNum;
	}
	public void setPageNum(int pageNum) {
		this.pageNum = pageNum;
	}
	public int getTotalSizeOfContents() {
		return totalSizeOfContents;
	}
	public void setTotalSizeOfContents(int totalSizeOfContents) {
		this.totalSizeOfContents = totalSizeOfContents;
	}
	
	

}
