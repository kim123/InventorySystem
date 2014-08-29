package com.is.service.impl;

import java.math.BigDecimal;
import java.math.BigInteger;
import java.sql.Timestamp;
import java.util.ArrayList;
import java.util.Arrays;
import java.util.Iterator;
import java.util.List;
import java.util.Map;

import org.hibernate.Query;

import com.is.model.Page;
import com.is.model.ProductPriceList;
import com.is.service.interfaze.ProductPriceService;
import com.is.utilities.LoggingUtility;

public class ProductPriceServiceImpl extends BaseServiceImpl implements ProductPriceService{ 

	public Page viewProductsAndPrices(Map<String, Object> constraints) {
		Page page = new Page();
		page.setPageSize((Integer)constraints.get(PAGE_SIZE));
		page.setContents(getProductPriceList(constraints));
		page.setTotalSizeOfContents(page.getContents().size());
		page.setTotalRecords(getTotalProducts(constraints));
		if (page.getContents().size() < page.getTotalRecords()) {
			page.setPageResult((Integer)constraints.get(PAGE_NUM));
			setPageParameters(constraints, page);
		} else {
			page.setParameters(null);
			page.setPageResult(0);
		}
		return page;
	}
	
	private void setPageParameters(Map<String, Object> constraints, Page page){
		List<String> pageParams = new ArrayList<String>();
		if (constraints.containsKey(PRODUCT_NAME)) {
			pageParams.add(PRODUCT_NAME+"-"+(String) constraints.get(PRODUCT_NAME));
		}
		if (constraints.containsKey(CATEGORY)) {
			pageParams.add(CATEGORY+"-"+(String) constraints.get(CATEGORY));
		}
		if (constraints.containsKey(HISTORY)) {
			pageParams.add(HISTORY+"-"+(String) constraints.get(HISTORY));
		}
		if (constraints.containsKey(RETAIL_PRICE)) {
			pageParams.add(OPERATOR_RETAIL_PRICE+"-"+(String)constraints.get(OPERATOR_RETAIL_PRICE));
			pageParams.add(RETAIL_PRICE+"-"+((BigDecimal)constraints.get(RETAIL_PRICE)).toPlainString());
		}
		if (constraints.containsKey(SELLING_MAX_PRICE)) {
			pageParams.add(OPERATOR_SELLING_MAX+"-"+(String)constraints.get(OPERATOR_SELLING_MAX));
			pageParams.add(SELLING_MAX_PRICE+"-"+((BigDecimal)constraints.get(SELLING_MAX_PRICE)).toPlainString());
		}
		if (constraints.containsKey(SELLING_MIN_PRICE)) {
			pageParams.add(OPERATOR_SELLING_MIN+"-"+(String)constraints.get(OPERATOR_SELLING_MIN));
			pageParams.add(SELLING_MIN_PRICE+"-"+((BigDecimal)constraints.get(SELLING_MIN_PRICE)).toPlainString());
		}
	}
	
	private List<?> getProductPriceList(Map<String, Object> constraints){
		List<ProductPriceList> prodList = new ArrayList<ProductPriceList>();
		String hql = getProductPriceQuery(constraints);
		Query query = getSession().createSQLQuery(hql);
		if (hql.contains("varcategory")) {
			query.setParameter("varcategory", (String)constraints.get(CATEGORY));
		}
		if (hql.contains("varhistory")) {
			query.setParameter("varhistory", (String)constraints.get(HISTORY));
		}
		query.setFirstResult((Integer)constraints.get(PAGE_NUM));
		query.setMaxResults((Integer)constraints.get(PAGE_SIZE));
		LoggingUtility.log(getClass(), "Get ProductPrice List: Params["+Arrays.asList(constraints.values().toArray())+"]");
		LoggingUtility.log(getClass(), "Get ProductPrice List: Query["+query.getQueryString()+"]");
		
		List<?> list = query.list();
		Iterator<?> iter = list.iterator();
		while (iter.hasNext()) {
			Object[] object = (Object[]) iter.next();
			ProductPriceList ppl = new ProductPriceList();
			ppl.setProductId((Integer)object[0]);
			ppl.setProductName((String)object[1]);
			ppl.setCategory((String)object[2]);
			ppl.setProductCreatedDate((Timestamp)object[3]);
			ppl.setProductCreatedBy((String)object[4]);
			ppl.setIsHistory((Integer)object[5]);
			ppl.setRetailPrice((BigDecimal)object[6]);
			ppl.setMaxSellingPrice((BigDecimal)object[7]);
			ppl.setMinSellingPrice((BigDecimal)object[8]);
			ppl.setPriceCreatedDate((Timestamp)object[9]);
			ppl.setPriceCreatedBy((String)object[10]);
			prodList.add(ppl);
		}
		
		return prodList;
	}
	
	private Integer getTotalProducts(Map<String, Object> constraints){
		String hql = "SELECT count(1) as totalRecord from("+getProductPriceQuery(constraints)+") a";
		Query query = getSession().createSQLQuery(hql);
		if (hql.contains("varcategory")) {
			query.setParameter("varcategory", (String)constraints.get(CATEGORY));
		}
		if (hql.contains("varhistory")) {
			query.setParameter("varhistory", (String)constraints.get(HISTORY));
		}
		//query.setFirstResult((Integer)constraints.get(PAGE_NUM));
		//query.setMaxResults((Integer)constraints.get(PAGE_SIZE));
		LoggingUtility.log(getClass(), "Get ProductPrice Total: Query["+query.getQueryString()+"]");
		BigInteger totalRecord = (BigInteger) query.list().get(0);
		LoggingUtility.log(getClass(), "Get ProductPrice List: Total["+totalRecord.intValue()+"]");
		
		return totalRecord.intValue();
	}
	
	private String getProductPriceQuery(Map<String, Object> constraints){
		StringBuilder hql = new StringBuilder("select p.product_id,p.product_name,c.name category,p.created_date,p.created_by,p.is_history,");
		hql.append("r.retail_price,r.selling_max_price,r.selling_min_price,r.created_date priceUpdatedDate,r.created_by priceCreatedBy ");
		hql.append("from product p ");
		hql.append("join category c on c.category_id=p.category_id ");
		hql.append("join price r on r.price_product_id=p.product_id ");
		hql.append("where 1=1 ");
		
		if (constraints.containsKey(PRODUCT_NAME)) {
			hql.append(" AND p.product_name LIKE '%"+(String) constraints.get(PRODUCT_NAME)+"%' ");
		}
		if (constraints.containsKey(CATEGORY)) {
			hql.append(" AND c.category_id=:varcategory ");
		}
		if (constraints.containsKey(HISTORY)) {
			hql.append(" AND p.is_history=:varhistory ");
		}
		if (constraints.containsKey(RETAIL_PRICE)) {
			hql.append(" AND r.retail_price ").append((String)constraints.get(OPERATOR_RETAIL_PRICE))
					.append(" ").append((BigDecimal)constraints.get(RETAIL_PRICE)).append(" ");
		}
		if (constraints.containsKey(SELLING_MAX_PRICE)) {
			hql.append(" AND r.selling_max_price ").append((String)constraints.get(OPERATOR_SELLING_MAX))
					.append(" ").append((BigDecimal)constraints.get(SELLING_MAX_PRICE)).append(" ");
		}
		if (constraints.containsKey(SELLING_MIN_PRICE)) {
			hql.append(" AND r.selling_min_price ").append((String)constraints.get(OPERATOR_SELLING_MIN))
					.append(" ").append((BigDecimal)constraints.get(SELLING_MIN_PRICE)).append(" ");
		}
		hql.append("order by r.created_date desc ");
		return hql.toString();
	}

	public ProductPriceList getProductPrice(int productId) {
		StringBuilder hql = new StringBuilder("select p.product_id,p.product_name,c.name category,p.created_date,p.created_by,p.is_history,");
		hql.append("r.retail_price,r.selling_max_price,r.selling_min_price,r.created_date priceUpdatedDate,r.created_by priceCreatedBy ");
		hql.append("from product p ");
		hql.append("join category c on c.category_id=p.category_id ");
		hql.append("join price r on r.price_product_id=p.product_id ");
		hql.append("where p.product_id=:productid ");
		
		Query query = getSession().createSQLQuery(hql.toString());
		query.setParameter("productid", productId);
		List<?> list = query.list();
		Object[] object = (Object[]) list.get(0);
		
		ProductPriceList ppl = new ProductPriceList();
		ppl.setProductId((Integer)object[0]);
		ppl.setProductName((String)object[1]);
		ppl.setCategory((String)object[2]);
		ppl.setProductCreatedDate((Timestamp)object[3]);
		ppl.setProductCreatedBy((String)object[4]);
		ppl.setIsHistory((Integer)object[5]);
		ppl.setRetailPrice((BigDecimal)object[6]);
		ppl.setMaxSellingPrice((BigDecimal)object[7]);
		ppl.setMinSellingPrice((BigDecimal)object[8]);
		ppl.setPriceCreatedDate((Timestamp)object[9]);
		ppl.setPriceCreatedBy((String)object[10]);
		
		return ppl;
	}

	public ProductPriceList getProductPrice(String productName) {
		StringBuilder hql = new StringBuilder("select p.product_id,p.product_name,c.name category,p.created_date,p.created_by,p.is_history,");
		hql.append("r.retail_price,r.selling_max_price,r.selling_min_price,r.created_date priceUpdatedDate,r.created_by priceCreatedBy ");
		hql.append("from product p ");
		hql.append("join category c on c.category_id=p.category_id ");
		hql.append("join price r on r.price_product_id=p.product_id ");
		hql.append("where p.product_name=:productname ");
		
		Query query = getSession().createSQLQuery(hql.toString());
		query.setParameter("productname", productName);
		List<?> list = query.list();
		Object[] object = (Object[]) list.get(0);
		
		ProductPriceList ppl = new ProductPriceList();
		ppl.setProductId((Integer)object[0]);
		ppl.setProductName((String)object[1]);
		ppl.setCategory((String)object[2]);
		ppl.setProductCreatedDate((Timestamp)object[3]);
		ppl.setProductCreatedBy((String)object[4]);
		ppl.setIsHistory((Integer)object[5]);
		ppl.setRetailPrice((BigDecimal)object[6]);
		ppl.setMaxSellingPrice((BigDecimal)object[7]);
		ppl.setMinSellingPrice((BigDecimal)object[8]);
		ppl.setPriceCreatedDate((Timestamp)object[9]);
		ppl.setPriceCreatedBy((String)object[10]);
		
		return ppl;
	}

	public String addProductPrice(ProductPriceList productPrice) {
		String hql = "CALL AddProduct(:productname,:category,:createdby,:retailprice,:sellingmaxprice,:sellingMinPrice)";
		Query query = getSession().createSQLQuery(hql);
		query.setParameter("productname", productPrice.getProductName());
		query.setParameter("category", productPrice.getCategory());
		query.setParameter("createdby", productPrice.getProductCreatedBy());
		query.setParameter("retailprice", productPrice.getRetailPrice());
		query.setParameter("sellingmaxprice", productPrice.getMaxSellingPrice());
		query.setParameter("sellingMinPrice", productPrice.getMinSellingPrice());
		LoggingUtility.log(getClass(), "Add Product: Params["+productPrice.getProductName()+","+productPrice.getCategory()+
															","+productPrice.getProductCreatedBy()+","+productPrice.getRetailPrice()+
															","+productPrice.getMaxSellingPrice()+","+productPrice.getMinSellingPrice()+"]");
		
		List<?> list = query.list();
		String result = (String) list.get(0);
		LoggingUtility.log(getClass(), "Add Product Attempt Result: "+result);
		
		return result;
	}

	public String updatePrices(ProductPriceList productPrice) {
		String hql = "CALL UpdatePrices(:productid,:retailprice,:sellingmaxprice,:sellingMinPrice,:updatedby)";
		Query query = getSession().createSQLQuery(hql);
		query.setParameter("productid", productPrice.getProductId());
		query.setParameter("retailprice", productPrice.getRetailPrice());
		query.setParameter("sellingmaxprice", productPrice.getMaxSellingPrice());
		query.setParameter("sellingMinPrice", productPrice.getMinSellingPrice());
		query.setParameter("updatedby", productPrice.getPriceCreatedBy());
		LoggingUtility.log(getClass(), "Update Prices: Params["+productPrice.getProductId()+","+productPrice.getRetailPrice()+
																","+productPrice.getMaxSellingPrice()+","+productPrice.getMinSellingPrice()+
																","+productPrice.getPriceCreatedBy()+"]");
		
		List<?> list = query.list();
		String result = (String) list.get(0);
		LoggingUtility.log(getClass(), "Update Prices Attempt Result: "+result);
		
		return result;
	}

	public String archiveProduct(ProductPriceList productPrice) {
		String hql = "CALL ArchiveProduct(:productid,:status,:updatedby)";
		Query query = getSession().createSQLQuery(hql);
		query.setParameter("productid", productPrice.getProductId());
		query.setParameter("status", productPrice.getIsHistory());
		query.setParameter("updatedby", productPrice.getProductCreatedBy());	
		LoggingUtility.log(getClass(), "Archive Product: Params["+productPrice.getProductId()+","+productPrice.getIsHistory()+","+productPrice.getProductCreatedBy()+"]");
		
		List<?> list = query.list();
		String result = (String) list.get(0);
		LoggingUtility.log(getClass(), "Archive Product Attempt Result: "+result);
		
		return result;
	}

	public List<ProductPriceList> productPriceList(int categoryId) {
		List<ProductPriceList> productPriceList = new ArrayList<ProductPriceList>();
		String hql = "select p.product_id,p.product_name,r.selling_max_price,r.selling_min_price from product p "
						+ "join price r on r.price_product_id=p.product_id where p.category_id=:categoryid";
		Query query = getSession().createSQLQuery(hql);
		query.setParameter("categoryid", categoryId);
		
		List<?> list = query.list();
		Iterator<?> iter = list.iterator();
		while (iter.hasNext()) {
			Object[] object = (Object[]) iter.next();
			ProductPriceList ppl = new ProductPriceList();
			ppl.setProductId((Integer)object[0]);
			ppl.setProductName((String)object[1]);
			ppl.setMaxSellingPrice((BigDecimal)object[2]);
			ppl.setMinSellingPrice((BigDecimal)object[3]);
			productPriceList.add(ppl);
		}
		
		return productPriceList;
	}

	public List<ProductPriceList> productPriceList() {
		List<ProductPriceList> productPriceList = new ArrayList<ProductPriceList>();
		String hql = "select product_id,product_name from product order by category_id asc";
		Query query = getSession().createSQLQuery(hql);
		
		List<?> list = query.list();
		Iterator<?> iter = list.iterator();
		while (iter.hasNext()) {
			Object[] object = (Object[]) iter.next();
			ProductPriceList ppl = new ProductPriceList();
			ppl.setProductId((Integer)object[0]);
			ppl.setProductName((String)object[1]);
			productPriceList.add(ppl);
		}
		
		return productPriceList;
	}
	
}