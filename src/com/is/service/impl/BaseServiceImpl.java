package com.is.service.impl;

import org.apache.struts2.ServletActionContext;
import org.hibernate.Session;
import org.hibernate.SessionFactory;

import com.is.utilities.Constants;

public class BaseServiceImpl {
	
	private Session session;

	protected Session getSession() {
		SessionFactory sessionFactory = (SessionFactory) 
											ServletActionContext.getServletContext().getAttribute(Constants.HIBERNATE_SESSION);
		session = sessionFactory.openSession();
		return session;
	}

}
