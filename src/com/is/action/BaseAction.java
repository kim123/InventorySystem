package com.is.action;

import java.io.IOException;
import java.io.PrintWriter;

import org.apache.struts2.ServletActionContext;
import org.json.JSONObject;

import com.is.model.Page;
import com.opensymphony.xwork2.ActionSupport;

@SuppressWarnings("serial")
public class BaseAction extends ActionSupport{
	
	private String message;
	private String menuActive;
	private int startingResult;
	private int maxResults;
	protected Page page;
	protected int pageNum;
	
	public int getPageNum() {
		//if (pageNum==0) {
		//	this.pageNum = 0;
		//} 
		return pageNum;
	}

	public void setPageNum(int pageNum) {
		//if (pageNum==0) {
		//	this.pageNum = 1;
		//} else {
			this.pageNum = pageNum;
		//}
	}

	protected int pageSize;
	
	public int getPageSize() {
		if (pageSize==0) {
			this.pageSize = 20;
		} 
		return pageSize;
	}

	public void setPageSize(int pageSize) {
		if (pageSize==0) {
			this.pageSize = 20;
		} else {
			this.pageSize = pageSize;
		}
	}

	public Page getPage() {
		return page;
	}

	public void setPage(Page page) {
		this.page = page;
	}

	public int getStartingResult() {
		return startingResult;
	}

	public void setStartingResult(int startingResult) {
		this.startingResult = startingResult;
	}

	public int getMaxResults() {
		return maxResults;
	}

	public void setMaxResults(int maxResults) {
		if (maxResults==0) {
			maxResults = 20;
		}
	}

	public String getMenuActive() {
		return menuActive;
	}

	public void setMenuActive(String menuActive) {
		this.menuActive = menuActive;
	}

	public String getMessage() {
		return message;
	}

	public void setMessage(String message) {
		this.message = message;
	}
	
	protected PrintWriter getPrintWriter(){
		PrintWriter out = null;
		try {
			out = ServletActionContext.getResponse().getWriter();
		} catch (IOException e) {
			e.printStackTrace();
		}
		return out;
	}
	
	protected void printJsonAndCloseWriter(PrintWriter out,JSONObject json){
		out.println(json.toString());
		out.close();
	}

}
