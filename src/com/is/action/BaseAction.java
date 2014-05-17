package com.is.action;

import com.is.model.Page;
import com.opensymphony.xwork2.ActionSupport;

@SuppressWarnings("serial")
public class BaseAction extends ActionSupport{
	
	private String message;
	private String menuActive;
	private int startingResult;
	private int maxResults;
	protected Page page;
	
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
	
	

}
