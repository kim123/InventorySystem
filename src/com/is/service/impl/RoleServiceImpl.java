package com.is.service.impl;

import java.sql.Timestamp;
import java.util.ArrayList;
import java.util.Iterator;
import java.util.List;

import org.hibernate.Query;

import com.is.model.Role;
import com.is.service.interfaze.RoleService;
import com.is.utilities.LoggingUtility;

public class RoleServiceImpl extends BaseServiceImpl implements RoleService{

	public String addRole(Role role) {
		String hql = "CALL AddRole(:role, :permission, :createdby)";
		Query query = getSession().createSQLQuery(hql);
		query.setParameter("role", role.getRank());
		query.setParameter("permission", role.getPermission());
		query.setParameter("createdby", role.getCreatedBy());
		LoggingUtility.log(getClass(), "Add Role: Params["+role.getRank()+","+role.getPermission()+","+role.getCreatedBy()+"]");
		
		List<?> list = query.list();
		String result = (String) list.get(0);

		return result;
	}

	public String viewRolesAndPermission(Role role) {
		// TODO Auto-generated method stub
		return null;
	}

	public Role getRole(int roleId) {
		String hql = "SELECT permission FROM rank WHERE rank_id=:rankid";
		Query query = getSession().createSQLQuery(hql);
		query.setParameter("rankid", roleId);
		
		List<?> list = query.list();
		Object[] object = (Object[]) list.get(0);
		Role role = new Role();
		if (object!=null) {
			role.setPermission((String)object[0]);
		} else {
			role.setPermission("");
		}
				
		return role;
	}

	public Role getRole(String role) {
		// TODO Auto-generated method stub
		return null;
	}

	public String modifyRolePermission(Role role) {
		// TODO Auto-generated method stub
		return null;
	}

	public List<Role> getRoles() {
		List<Role> roles = new ArrayList<Role>();
		String hql = "SELECT * FROM rank";
		Query query = getSession().createSQLQuery(hql);
		List<?> list = query.list();
		Iterator<?> iter = list.iterator();
		while (iter.hasNext()) {
			Object[] object = (Object[]) iter.next();
			Role role = new Role();
			role.setRankId((int) object[0]);
			role.setRank((String) object[1]);
			role.setPermission((String) object[2]);
			role.setCreatedDate((Timestamp) object[3]);
			role.setCreatedBy((String) object[4]);
			roles.add(role);
		}
		
		return roles;
	}

}
