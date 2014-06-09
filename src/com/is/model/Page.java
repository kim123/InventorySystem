package com.is.model;

import java.util.List;

public class Page {
	
	private List<?> contents;
	private int[] pages;
	private int pagesLength;
	private int totalRecords;
	private int beginIndex;
	private int endIndex;
	private int pageNumber;
	private int pageResult;
	private int pageSize;
	private String query;

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
	public int getBeginIndex() {
		return beginIndex;
	}
	public void setBeginIndex(int beginIndex) {
		this.beginIndex = beginIndex;
	}
	public int getEndIndex() {
		return endIndex;
	}
	public void setEndIndex(int endIndex) {
		this.endIndex = endIndex;
	}
	public int getPageNumber() {
		return pageNumber;
	}
	public void setPageNumber(int pageNumber) {
		this.pageNumber = pageNumber;
	}
	public int getPageResult() {
		return pageResult;
	}
	public void setPageResult(int pageResult) {
		this.pageResult = pageResult;
	}
	public int[] getPages() {
		return pages;
	}
	public void setPages(int[] pages) {
		this.pages = pages;
	}
	public int getPageSize() {
		return pageSize;
	}
	public void setPageSize(int pageSize) {
		this.pageSize = pageSize;
	}
	public String getQuery() {
		return query;
	}
	public void setQuery(String query) {
		this.query = query;
	}
	public int getPagesLength() {
		return pagesLength;
	}
	public void setPagesLength(int pagesLength) {
		this.pagesLength = pagesLength;
	}
	
	

}
