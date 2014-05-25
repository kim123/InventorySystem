package com.is.service.impl;

import java.math.BigInteger;
import java.sql.Timestamp;
import java.util.ArrayList;
import java.util.Iterator;
import java.util.List;

import org.hibernate.Query;

import com.is.model.LoginDetail;
import com.is.model.Page;
import com.is.model.Role;
import com.is.model.User;
import com.is.model.UserList;
import com.is.service.interfaze.UserService;
import com.is.utilities.Constants;
import com.is.utilities.LoggingUtility;
import com.is.utilities.SessionUtility;

public class UserServiceImpl extends BaseServiceImpl implements UserService{
	
	private void setUserSession(User user){
		StringBuilder hql = new StringBuilder("SELECT u.user_id,u.user_name,u.full_name,u.rank_id,u.status,r.rank,r.permission ")
												.append("FROM user u ")
												.append("JOIN rank r on r.rank_id=u.rank_id ")
												.append("WHERE u.user_name collate utf8_bin = :userName ");
		Query query = getSession().createSQLQuery(hql.toString());
		query.setParameter("userName", user.getUserName());
		Object[] object = (Object[]) query.list().get(0);
		User user2 = new User();
		user2.setUserId((int) object[0]);
		user2.setUserName((String) object[1]);
		user2.setFullName((String) object[2]);
		user2.setStatus((int) object[4]);
		
		Role role = new Role();
		role.setRankId((int) object[3]);
		role.setRank((String) object[5]);
		role.setPermission((String) object[6]);
		LoginDetail loginDetail = new LoginDetail();
		loginDetail.setUser(user2);
		loginDetail.setRole(role);
		
		SessionUtility.setUserSession(loginDetail);
	}

	public String login(User user) {
		String hql = "SELECT Login(:userName, :password)";
		Query query = getSession().createSQLQuery(hql);
		query.setParameter("userName", user.getUserName());
		query.setParameter("password", user.getPassword());
		LoggingUtility.log(getClass(), "Login Attempt: User["+user.getUserName()+"] Password["+user.getPassword()+"]");
		
		List<?> list = query.list();
		String result = (String) list.get(0);
		if (result.equals(Constants.SUCCESS)) {
			setUserSession(user);
		}

		LoggingUtility.log(getClass(), "Login Attempt Result: "+result);
		return result;
	}

	public String addUser(User user) {
		String hql = "CALL AddUser(:username, :fullname, :password, :rankid, :createdby, :bankaccountnum)";
		Query query = getSession().createSQLQuery(hql);
		query.setParameter("username", user.getUserName());
		query.setParameter("fullname", user.getFullName());
		query.setParameter("password", user.getPassword());
		query.setParameter("rankid", user.getRankId());
		query.setParameter("createdby", user.getCreatedBy());
		query.setParameter("bankaccountnum", "");
		LoggingUtility.log(getClass(), "Add User: Params["+user.getUserName()+","+user.getFullName()
										+","+user.getPassword()+","+user.getRankId()+","+user.getCreatedBy()+"]");
		List<?> list = query.list();
		String result = (String) list.get(0);

		LoggingUtility.log(getClass(), "Add User Attempt Result: "+result);
		
		return result;
	}

	public String modifyRole(Role role) {
		// TODO Auto-generated method stub
		return null;
	}
	
	public String modifyOwnPassword(User user, String oldPassword){
		String hql = "CALL ModifyOwnPassword(:userId, :oldPassword, :newPassword, :updatedBy)";
		Query query = getSession().createSQLQuery(hql);
		query.setParameter("userId", user.getUserId());
		query.setParameter("oldPassword", oldPassword);
		query.setParameter("newPassword", user.getPassword());
		query.setParameter("updatedBy", user.getCreatedBy());
		LoggingUtility.log(getClass(), "Check Password: Params["+user.getUserId()+","+oldPassword
																+","+user.getPassword()+","+user.getCreatedBy()+"]");
		
		List<?> list = query.list();
		String result = (String) list.get(0);

		LoggingUtility.log(getClass(), "Modify Own Password Attempt Result: "+result);
		return result;
	}

	public String modifyPassword(User user) {
		String hql = "CALL ModifyPassword(:userId, :password, :updatedBy)";
		Query query = getSession().createSQLQuery(hql.toString());
		query.setParameter("userId", user.getUserId());
		query.setParameter("password", user.getPassword());
		query.setParameter("updatedBy", user.getCreatedBy());
		LoggingUtility.log(getClass(), "Modify Password Attempt: Params["+user.getUserId()+","+user.getPassword()
																			+","+user.getCreatedBy()+"]");
		List<?> list = query.list();
		String result = (String) list.get(0);

		LoggingUtility.log(getClass(), "Modify Password Attempt Result: "+result);
		return result;
	}

	public String modifyStatus(User user) {
		// TODO Auto-generated method stub
		return null;
	}

	public User getUser(int userId) {
		// TODO Auto-generated method stub
		return null;
	}

	public User getUser(String userName) {
		// TODO Auto-generated method stub
		return null;
	}
	
	public Page viewUsers() {
		Page page = new Page();	
		page.setContents(getUserList());
		page.setTotalRecords(getTotalUsers());
		
		return page;
	}
	
	private List<?> getUserList(){
		List<UserList> userList = new ArrayList<UserList>();
		StringBuilder hql = new StringBuilder("SELECT user_id,user_name,full_name,rank_id,status,created_date,created_by,rank ")
												.append("FROM (")
												.append(getUserListQuery())
												.append(")a ");
		Query query = getSession().createSQLQuery(hql.toString());
		List<?> queryList = query.list();
		Iterator<?> queryIter = queryList.iterator();
		while (queryIter.hasNext()) {
			Object[] object = (Object[]) queryIter.next();
			UserList ul = new UserList();
			ul.setUserId((int) object[0]);
			ul.setUserName((String) object[1]);
			ul.setFullName((String) object[2]);
			ul.setRankId((int) object[3]);
			ul.setStatus((int) object[4]);
			ul.setCreatedDate((Timestamp) object[5]);
			ul.setCreatedBy((String) object[6]);
			ul.setRank((String) object[7]);
			userList.add(ul);
		}
		return userList;
	}
	
	private Integer getTotalUsers(){
		StringBuilder hql = new StringBuilder("select count(1) totalRecords from (")
												.append(getUserListQuery())
												.append(")a");
		Query query = getSession().createSQLQuery(hql.toString());
		BigInteger bigInt = (BigInteger) query.list().get(0);
		return bigInt.intValue();
	}
	
	private String getUserListQuery(){
		StringBuilder hql = new StringBuilder("SELECT u.user_id,u.user_name,u.full_name,u.rank_id,u.status,")
												.append("u.created_date,u.created_by,r.rank ")
												.append("FROM user u ")
												.append("JOIN rank r  on r.rank_id=u.rank_id ");
		return hql.toString();
	}


}
