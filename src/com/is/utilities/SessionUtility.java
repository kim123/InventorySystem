package com.is.utilities;

import javax.servlet.http.HttpSession;

import org.apache.struts2.ServletActionContext;

import com.is.model.LoginDetail;
import com.is.model.Role;
import com.is.model.User;

public class SessionUtility {
	
	public static void setUserSession(LoginDetail loginDetail){
		HttpSession session = ServletActionContext.getRequest().getSession();
		session.setAttribute(Constants.USER_SESSION, loginDetail);
	}
	
	public static User getUser(){
		LoginDetail loginDetail = (LoginDetail) ServletActionContext.getRequest().getSession().getAttribute(Constants.USER_SESSION);
		if (loginDetail==null) {
			return null;
		} else {
			return loginDetail.getUser();
		}
	}
	
	public static Role getRole(){
		LoginDetail loginDetail = (LoginDetail) ServletActionContext.getRequest().getSession().getAttribute(Constants.USER_SESSION);
		if (loginDetail==null) {
			return null;
		} else {
			return loginDetail.getRole();
		}
	}
	
	public static void invalidateUserSession(){
		ServletActionContext.getRequest().getSession().removeAttribute(Constants.USER_SESSION);
		ServletActionContext.getRequest().getSession().invalidate();
	}

}
