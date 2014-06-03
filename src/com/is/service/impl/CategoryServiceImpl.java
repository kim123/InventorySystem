package com.is.service.impl;

import java.math.BigInteger;
import java.sql.Timestamp;
import java.util.ArrayList;
import java.util.Iterator;
import java.util.List;

import org.hibernate.Query;

import com.is.model.Category;
import com.is.model.Page;
import com.is.service.interfaze.CategoryService;
import com.is.utilities.LoggingUtility;

public class CategoryServiceImpl extends BaseServiceImpl implements CategoryService{

	public Page viewCategories() {
		Page page = new Page();
		page.setContents(getCategoryList());
		page.setTotalRecords(getTotalCategories());
		return page;
	}
	
	public List<?> getCategoryList(){
		List<Category> categoryList = new ArrayList<Category>();
		String hql = "select category_id, name, created_date, created_by from category";
		Query query = getSession().createSQLQuery(hql);
		List<?> list = query.list();
		Iterator<?> iter = list.iterator();
		while (iter.hasNext()) {
			Object[] object = (Object[]) iter.next();
			Category category = new Category();
			category.setCategoryId((int) object[0]);
			category.setCategoryName((String) object[1]);
			category.setCreatedDate((Timestamp) object[2]);
			category.setCreatedBy((String) object[3]);
			categoryList.add(category);
		}
		
		return categoryList;
	}
	
	private Integer getTotalCategories(){
		String hql = "select count(1) as totalRecord from (select category_id, name, created_date, created_by from category) a";
		Query query = getSession().createSQLQuery(hql);
		BigInteger totalRecord = (BigInteger) query.list().get(0);
		return totalRecord.intValue();
	}

	public Category getCategory(int categoryId) {
		String hql = "select category_id, name, created_date, created_by from category where category_id = :id";
		Query query = getSession().createSQLQuery(hql);
		query.setParameter("id", categoryId);
		
		List<?> list = query.list();
		Object[] object = (Object[]) list.get(0);
		Category category = new Category();
		category.setCategoryId((int) object[0]);
		category.setCategoryName((String) object[1]);
		category.setCreatedDate((Timestamp) object[2]);
		category.setCreatedBy((String) object[3]);
		
		return category;
	}

	public Category getCategory(String categoryName) {
		String hql = "select category_id, name, created_date, created_by from category where category_id = :name";
		Query query = getSession().createSQLQuery(hql);
		query.setParameter("name", categoryName);
		
		List<?> list = query.list();
		Object[] object = (Object[]) list.get(0);
		Category category = new Category();
		category.setCategoryId((int) object[0]);
		category.setCategoryName((String) object[1]);
		category.setCreatedDate((Timestamp) object[2]);
		category.setCreatedBy((String) object[3]);
		
		return category;
	}

	public String addCategory(Category category) {
		String hql = "CALL AddCategory(:name, :createdby)";
		Query query = getSession().createSQLQuery(hql);
		query.setParameter("name", category.getCategoryName());
		query.setParameter("createdby", category.getCreatedBy());
		LoggingUtility.log(getClass(), "Add Category Params: ["+category.getCategoryName()+","+category.getCreatedBy()+"]");
		
		List<?> list = query.list();
		String result = (String) list.get(0);
		LoggingUtility.log(getClass(), "Add Category Attempt Result: "+result);
		
		return result;
	}

}