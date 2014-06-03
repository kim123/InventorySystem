package com.is.action;

import java.io.PrintWriter;

import org.apache.commons.lang.StringUtils;
import org.json.JSONException;
import org.json.JSONObject;

import com.is.model.Category;
import com.is.service.impl.CategoryServiceImpl;
import com.is.service.interfaze.CategoryService;
import com.is.utilities.Constants;
import com.is.utilities.SessionUtility;

@SuppressWarnings("serial")
public class CategoryAction extends BaseAction{
	
	private static CategoryService categoryService;
	
	static {
		if (categoryService==null) {
			categoryService = new CategoryServiceImpl();
		}
	}
	
	private Category category;

	public static CategoryService getCategoryService() {
		return categoryService;
	}

	public static void setCategoryService(CategoryService categoryService) {
		CategoryAction.categoryService = categoryService;
	}

	public Category getCategory() {
		return category;
	}

	public void setCategory(Category category) {
		this.category = category;
	}
	
	public String execute(){
		setMenuActive("3");
		page = categoryService.viewCategories();
		
		return SUCCESS;
	}
	
	public String addCategory(){
		PrintWriter out = getPrintWriter();
		JSONObject json = new JSONObject();
		if (StringUtils.isBlank(category.getCategoryName())) {
			try {
				json.put("message", "category.name.must.not.be.empty");
			} catch (JSONException e) {
				e.printStackTrace();
			}
		} else {
			category.setCreatedBy(SessionUtility.getUser().getUserName());
			String result = categoryService.addCategory(category);
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
		}
		printJsonAndCloseWriter(out, json);
		
		return null;
	}

}
