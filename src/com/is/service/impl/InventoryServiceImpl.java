package com.is.service.impl;

import java.math.BigInteger;
import java.sql.Timestamp;
import java.util.ArrayList;
import java.util.Arrays;
import java.util.Iterator;
import java.util.List;
import java.util.Map;

import org.hibernate.Query;

import com.is.model.Inventory;
import com.is.model.Page;
import com.is.service.interfaze.InventoryService;
import com.is.utilities.LoggingUtility;

public class InventoryServiceImpl extends BaseServiceImpl implements InventoryService{

	public Page viewInventoryLogs(Map<String, Object> constraints) {
		Page page = new Page();
		page.setPageSize((Integer)constraints.get(PAGE_SIZE));
		page.setContents(getInventoryStockList(constraints));
		page.setTotalSizeOfContents(page.getContents().size());
		page.setTotalRecords(getTotalStocks(constraints));
		if (page.getContents().size() < page.getTotalRecords()) {
			page.setPageResult((Integer)constraints.get(PAGE_NUM));
			//setPageParameters(constraints, page);
		} else {
			//page.setParameters(null);
			page.setPageResult(0);
		}
		return page;
	}
	
	private String getStocksInventoryQuery(Map<String, Object> constraints){
		StringBuilder hql = new StringBuilder()
								.append("select b.inventory_id,b.inventory_product_id,b.total,b.created_date,b.created_by,p.product_name,c.name ")
								.append("from (")
								.append("	select inventory_id,inventory_product_id,(total-onStocksTotal) total,created_date,created_by ")
								.append("	from(")
								.append("		 select i.inventory_id,i.inventory_product_id,i.total,i.created_date,i.created_by,")
								.append("		 	(CASE a.onstocksTotal IS NULL WHEN TRUE THEN 0 ELSE a.onstocksTotal END) onStocksTotal ")
								.append("		 from inventory i left join (")
								.append("		 	select d.total_quantity onstocksTotal,d.on_hand_product_id from daily_on_hand_products d ")
								.append("		 		group by d.on_hand_product_id order by d.on_hand_product_id desc ")
								.append("		 ) a on a.on_hand_product_id=i.inventory_product_id order by i.inventory_id desc")
								.append("	) a group by inventory_product_id ")
								.append(") b join product p on p.product_id=b.inventory_product_id ")
								.append("join category c on c.category_id=p.category_id ")
								.append("where 1=1 ");
		if (constraints.containsKey(PRODUCT_NAME)) {
			hql.append(" AND product_name like '%"+(String)constraints.get(PRODUCT_NAME)+"%' ");
		}
		if (constraints.containsKey(CATEGORY)) {
			hql.append(" AND c.category_id=:varcategory ");
		}
		if (constraints.containsKey(TOTAL_QUANTITY)) {
			hql.append(" AND b.total ").append((String)constraints.get(OPERATOR_TOTAL))
					.append(" ").append((Integer)constraints.get(TOTAL_QUANTITY)).append(" ");
		}
		
		return hql.toString();
	}
	
	public List<Inventory> getInventoryStockList(Map<String, Object> constraints) {
		List<Inventory> inventoryList = new ArrayList<Inventory>();
		String hql = getStocksInventoryQuery(constraints);
		Query query = getSession().createSQLQuery(hql);
		if (hql.contains("varcategory")) {
			query.setParameter("varcategory", (String)constraints.get(CATEGORY));
		}
		query.setFirstResult((Integer)constraints.get(PAGE_NUM));
		query.setMaxResults((Integer)constraints.get(PAGE_SIZE));
		
		LoggingUtility.log(getClass(), "Get InventoryStock List: Params["+Arrays.asList(constraints.values().toArray())+"]");
		LoggingUtility.log(getClass(), "Get InventoryStock List: Query["+query.getQueryString()+"]");
		
		List<?> list = query.list();
		Iterator<?> iter = list.iterator();
		while (iter.hasNext()) {
			Object[] object = (Object[]) iter.next();
			Inventory inventory = new Inventory();
			inventory.setInventoryId((Integer)object[0]);
			inventory.setProductId((Integer)object[1]);
			inventory.setTotal(((BigInteger)object[2]).intValue());
			inventory.setCreatedDate((Timestamp)object[3]);
			inventory.setCreatedBy((String)object[4]);
			inventory.setProductName((String)object[5]);
			inventory.setCategoryName((String)object[6]);
			inventoryList.add(inventory);
		}
		
		return inventoryList;
	}
	
	private Integer getTotalStocks(Map<String, Object> constraints){
		String hql = "SELECT count(1) as totalRecord from("+getStocksInventoryQuery(constraints)+") a";
		Query query = getSession().createSQLQuery(hql);
		if (hql.contains("varcategory")) {
			query.setParameter("varcategory", (String)constraints.get(CATEGORY));
		}
		LoggingUtility.log(getClass(), "Get Stocks Total: Query["+query.getQueryString()+"]");
		BigInteger totalRecord = (BigInteger) query.list().get(0);
		LoggingUtility.log(getClass(), "Get Stocks List: Total["+totalRecord.intValue()+"]");
		
		return totalRecord.intValue();
	}

	public String addStocks(Inventory inventory) {
		String hql = "CALL AddStocksInventory(:productid, :quantity, :createdby)";
		Query query = getSession().createSQLQuery(hql);
		query.setParameter("productid", inventory.getProductId());
		query.setParameter("quantity", inventory.getQuantity());
		query.setParameter("createdby", inventory.getCreatedBy());
		
		LoggingUtility.log(getClass(), "ADD Inventory Stock Attempt: Params["+inventory.getProductId()+", "+inventory.getQuantity()+", "+inventory.getCreatedBy()+"]");
		
		List<?> list = query.list();
		String result = (String) list.get(0);
		LoggingUtility.log(getClass(), "Add Inventory Stock Attempt Result: "+result);
		
		return result;
	}

}
