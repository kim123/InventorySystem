package com.is.service.interfaze;

import java.util.List;

import com.is.model.Category;
import com.is.model.Page;

public interface CategoryService {
	
	Page viewCategories();
	List<?> getCategoryList();
	Category getCategory(int categoryId);
	Category getCategory(String categoryName);
	String addCategory(Category category);

}
