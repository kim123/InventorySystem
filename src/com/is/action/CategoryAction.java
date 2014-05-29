package com.is.action;

import com.is.service.impl.CategoryServiceImpl;
import com.is.service.interfaze.CategoryService;

@SuppressWarnings("serial")
public class CategoryAction extends BaseAction{
	
	private static CategoryService categoryService;
	
	static {
		if (categoryService==null) {
			categoryService = new CategoryServiceImpl();
		}
	}

}
