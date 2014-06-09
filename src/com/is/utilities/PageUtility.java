package com.is.utilities;

import com.is.model.Page;

public class PageUtility {
	
	public static void computeNumberOfPages(Page page){
		int totalRecords = page.getTotalRecords();
		int pageSize = page.getPageSize();
		int quotient = totalRecords / pageSize;
		int remainder = totalRecords % 20;
		int totalPages = 0;
		if (remainder!=0) {
			totalPages = 1;
		}
		totalPages = totalPages + quotient;
		
		int[] pages = new int[totalPages];
		int pageResult = 1; //result row
		for (int i = 0; i < pages.length; i++) {
			pages[i] = pageResult;
			pageResult = pageResult + pageSize;
		}
		
		page.setPages(pages);
		page.setPagesLength(pages.length);
	}
	
	public static void setDefaultIndexes(Page page){
		page.setBeginIndex(0);
		page.setEndIndex(4);
		page.setPageNumber(1);
	}

}
