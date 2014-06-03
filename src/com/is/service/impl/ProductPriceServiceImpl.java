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
		page.setContents(getProductPriceList(constraints));
		page.setTotalRecords(getTotalProducts(constraints));
		return page;
	}
	
	private List<?> getProductPriceList(Map<String, Object> constraints){
		List<ProductPriceList> prodList = new ArrayList<ProductPriceList>();
		String hql = getProductPriceQuery(constraints);
		Query query = getSession().createSQLQuery(hql);
		if (hql.contains("productname")) {
			query.setParameter("productname", (String)constraints.get(PRODUCT_NAME));
		}
		if (hql.contains("category")) {
			query.setParameter("category", (String)constraints.get(CATEGORY));
		}
		if (hql.contains("history")) {
			query.setParameter("history", (Integer)constraints.get(HISTORY));
		}
		query.setFirstResult((Integer)constraints.get(PAGE_NUM));
		query.setMaxResults((Integer)constraints.get(PAGE_SIZE));
		LoggingUtility.log(getClass(), "Get ProductPrice List: Params["+Arrays.asList(constraints.values().toArray())+"]");
		LoggingUtility.log(getClass(), "Get ProductPrice List Query["+query.getQueryString()+"]");
		
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
		if (hql.contains("productname")) {
			query.setParameter("productname", (String)constraints.get(PRODUCT_NAME));
		}
		if (hql.contains("category")) {
			query.setParameter("category", (String)constraints.get(CATEGORY));
		}
		if (hql.contains("history")) {
			query.setParameter("history", (Integer)constraints.get(HISTORY));
		}
		query.setFirstResult((Integer)constraints.get(PAGE_NUM));
		query.setMaxResults((Integer)constraints.get(PAGE_SIZE));
	
		BigInteger totalRecord = (BigInteger) query.list().get(0);
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
			hql.append(" AND p.product_name=:productname ");
		}
		if (constraints.containsKey(CATEGORY)) {
			hql.append(" AND c.name=:category ");
		}
		if (constraints.containsKey(HISTORY)) {
			hql.append(" AND p.is_history=:history ");
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
		
		List<?> list = query.list();
		String result = (String) list.get(0);
		
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

		List<?> list = query.list();
		String result = (String) list.get(0);
		
		return result;
	}

	public String archiveProduct(ProductPriceList productPrice) {
		String hql = "CALL ArchiveProduct(:productid,:status,:updatedby)";
		Query query = getSession().createSQLQuery(hql);
		query.setParameter("productid", productPrice.getProductId());
		query.setParameter("status", productPrice.getIsHistory());
		query.setParameter("updatedby", productPrice.getProductCreatedBy());	
		
		List<?> list = query.list();
		String result = (String) list.get(0);
		
		return result;
	}

}
