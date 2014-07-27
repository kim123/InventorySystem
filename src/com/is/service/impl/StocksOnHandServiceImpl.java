package com.is.service.impl;

import java.math.BigInteger;
import java.sql.Timestamp;
import java.util.ArrayList;
import java.util.Arrays;
import java.util.Iterator;
import java.util.List;
import java.util.Map;

import org.hibernate.Query;

import com.is.model.Page;
import com.is.model.StocksOnHand;
import com.is.service.interfaze.StocksOnHandService;
import com.is.utilities.LoggingUtility;

public class StocksOnHandServiceImpl extends BaseServiceImpl implements StocksOnHandService{

	public Page viewStocksOnHand(Map<String, Object> constraints) {
		Page page = new Page();
		page.setPageSize((Integer)constraints.get(PAGE_SIZE));
		page.setContents(getStocksOnHandList(constraints));
		page.setTotalSizeOfContents(page.getContents().size());
		page.setTotalRecords(getTotalStocksOnHand(constraints));
		if (page.getContents().size() < page.getTotalRecords()) {
			page.setPageResult((Integer)constraints.get(PAGE_NUM));
		} else {
			page.setPageResult(0);
		}
		return page;
	}
	
	private String getStocksOnHandQuery(Map<String, Object> constraints){
		StringBuilder sql = new StringBuilder();
		sql.append("select p.product_id,p.product_name,c.name category,s.daily_on_hand_id,s.on_hand_product_id,");
		sql.append("	(CASE s.ending_quantity IS NULL WHEN TRUE THEN 0 ELSE s.ending_quantity END) quantity,s.created_date,s.created_by, ");
		sql.append(" 	(CASE s.inventory_id IS NULL WHEN TRUE THEN 0 ELSE s.inventory_id END) inventory_id ");
		sql.append("from product p ");
		sql.append("left join (");
		sql.append("	select daily_on_hand_id,on_hand_product_id,ending_quantity,created_date,created_by,inventory_id from (");
		sql.append("		select daily_on_hand_id,on_hand_product_id,ending_quantity,created_date,created_by,inventory_id ");
		sql.append("			from daily_on_hand_products ");
		sql.append("		order by created_date desc ");
		sql.append("	)a group by on_hand_product_id ");
		sql.append(") s on s.on_hand_product_id=p.product_id ");
		sql.append("join category c on c.category_id=p.category_id ");
		sql.append("WHERE 1=1 ");
		
		if (constraints.containsKey(CATEGORY)) {
			sql.append(" AND c.category_id=:varcategory");
		}
		if (constraints.containsKey(PRODUCT_NAME)) {
			sql.append(" AND p.product_name like '%"+(String)constraints.get(PRODUCT_NAME)+"%' ");
		}
		if (constraints.containsKey(QUANTITY)) {
			if (((Integer)constraints.get(QUANTITY))==0) {
				sql.append(" AND (s.ending_quantity ").append((String)constraints.get(OPERATOR_QUANTITY))
					.append(" ").append(" 0 OR s.ending_quantity is null) ");
			} else {
				sql.append(" AND s.ending_quantity ").append((String)constraints.get(OPERATOR_QUANTITY))
					.append(" ").append((Integer)constraints.get(QUANTITY)).append(" ");
			}
		}
		
		return sql.toString();
	}
	
	private List<StocksOnHand> getStocksOnHandList(Map<String, Object> constraints){
		List<StocksOnHand> list = new ArrayList<StocksOnHand>();
		String hql = getStocksOnHandQuery(constraints);
		Query query = getSession().createSQLQuery(hql);
		if (hql.contains("varcategory")) {
			query.setParameter("varcategory", (String)constraints.get(CATEGORY));
		}
		query.setFirstResult((Integer)constraints.get(PAGE_NUM));
		query.setMaxResults((Integer)constraints.get(PAGE_SIZE));
		
		LoggingUtility.log(getClass(), "Get StocksOnHand List: Params["+Arrays.asList(constraints.values().toArray())+"]");
		LoggingUtility.log(getClass(), "Get StocksOnHand List: Query["+query.getQueryString()+"]");
		
		List<?> tempList = query.list();
		Iterator<?> iter = tempList.iterator();
		while (iter.hasNext()) {
			Object[] object = (Object[]) iter.next();
			StocksOnHand s = new StocksOnHand();
			s.setProductId((Integer)object[0]);
			s.setProductName((String)object[1]);
			s.setCategory((String)object[2]);
			s.setQuantity(((BigInteger)object[5]).intValue());
			s.setCreatedBy((String)object[7]);
			s.setCreatedDate((Timestamp)object[6]);
			s.setInventoryId(((BigInteger)object[8]).intValue());
			s.setAvailableQuantity(getAvailableQuantityBasedOnInventory(s.getInventoryId()));
			list.add(s);
		}
				
		return list;
	}
	
	private Integer getAvailableQuantityBasedOnInventory(int inventoryId){
		StringBuilder hql = new StringBuilder();
		hql.append("select b.total ");
		hql.append("from (");
		hql.append("	select inventory_id,inventory_product_id,(total-onStocksTotal) total ");
		hql.append("	from( ");
		hql.append("		select i.inventory_id,i.inventory_product_id,i.total, ");
		hql.append("			(CASE a.onstocksTotal is null WHEN true then 0 else a.onstocksTotal END) onStocksTotal ");
		hql.append("		from inventory i left join ( ");
		hql.append("			select d.total_quantity onstocksTotal,d.on_hand_product_id from daily_on_hand_products d ");
		hql.append("				group by d.on_hand_product_id order by d.on_hand_product_id desc ");
		hql.append("		) a on a.on_hand_product_id=i.inventory_product_id where i.inventory_id = :currentinventoryid order by i.inventory_id desc ");
		hql.append("	) a group by inventory_product_id ");
		hql.append(") b join product p on p.product_id=b.inventory_product_id ");
		hql.append("join category c on c.category_id=p.category_id");
		
		Query query = getSession().createSQLQuery(hql.toString());
		query.setParameter("currentinventoryid", inventoryId);
		BigInteger totalRecord = new BigInteger("0");
		if (query.list().size()!=0) {
			totalRecord = (BigInteger) query.list().get(0);
		}
		
		return totalRecord.intValue();
	}
	
	private Integer getTotalStocksOnHand(Map<String, Object> constraints){
		String hql = "SELECT count(1) as totalRecord from("+getStocksOnHandQuery(constraints)+") a";
		Query query = getSession().createSQLQuery(hql);
		if (hql.contains("varcategory")) {
			query.setParameter("varcategory", (String)constraints.get(CATEGORY));
		}
		LoggingUtility.log(getClass(), "Get Stocks On Hand Total: Query["+query.getQueryString()+"]");
		BigInteger totalRecord = (BigInteger) query.list().get(0);
		LoggingUtility.log(getClass(), "Get Stocks On Hand List: Total["+totalRecord.intValue()+"]");
		
		return totalRecord.intValue();		
	}

	public String addStocksOnHand(StocksOnHand stocksOnHand) {
		String hql = "CALL AddStocksOnHand(:productid, :quantity, :inventoryid, :createdby)";
		Query query = getSession().createSQLQuery(hql);
		query.setParameter("productid", stocksOnHand.getProductId());
		query.setParameter("quantity", stocksOnHand.getQuantity());
		query.setParameter("inventoryid", stocksOnHand.getInventoryId());
		query.setParameter("createdby", stocksOnHand.getCreatedBy());
		
		LoggingUtility.log(getClass(), "ADD Stocks on Hand Attempt: Params["+stocksOnHand.getProductId()+", "+
											stocksOnHand.getQuantity()+", "+stocksOnHand.getInventoryId()+", "+
											stocksOnHand.getCreatedBy()+"]");
		
		List<?> list = query.list();
		String result = (String) list.get(0);
		LoggingUtility.log(getClass(), "Add Stocks on Hand Attempt Result: "+result);
		
		return result;
	}


}
