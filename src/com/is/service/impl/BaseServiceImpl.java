package com.is.service.impl;

import org.apache.struts2.ServletActionContext;
import org.hibernate.Session;
import org.hibernate.SessionFactory;

import com.is.utilities.Constants;

public class BaseServiceImpl {
	
	private static Session session;

	protected Session getSession() {
		if (session==null) {
			SessionFactory sessionFactory = (SessionFactory) ServletActionContext.getServletContext().getAttribute(Constants.HIBERNATE_SESSION);
			session = sessionFactory.openSession();
		}
		return session;
	}
	
	protected void closeSession(){
		if (session!=null) {
			session.close();
		}
	}
	
	protected void nullifySession(){
		session = null;
	}

}
