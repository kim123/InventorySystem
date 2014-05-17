package com.is.hibernate.listener;

import java.io.File;
import java.net.URL;

import javax.servlet.ServletContextEvent;
import javax.servlet.ServletContextListener;

import org.hibernate.HibernateException;
import org.hibernate.SessionFactory;
import org.hibernate.boot.registry.StandardServiceRegistry;
import org.hibernate.boot.registry.StandardServiceRegistryBuilder;
import org.hibernate.cfg.Configuration;

import com.is.utilities.Constants;
import com.is.utilities.LoggingUtility;

public class HibernateListener implements ServletContextListener{

	private Configuration configuration;
	private SessionFactory sessionFactory;
	private StandardServiceRegistry serviceRegistry;
	private StandardServiceRegistryBuilder serviceRegistryBuilder;
	
	public void contextDestroyed(ServletContextEvent arg0) {		
	}

	public void contextInitialized(ServletContextEvent event) {
		URL url = HibernateListener.class.getResource("/hibernate.cfg.xml");
		configuration = new Configuration().configure(new File(url.getFile()));
		serviceRegistryBuilder = new StandardServiceRegistryBuilder();
		serviceRegistryBuilder.applySettings(configuration.getProperties());
		serviceRegistry = serviceRegistryBuilder.build();
		try {
			sessionFactory = configuration.buildSessionFactory(serviceRegistry);
			LoggingUtility.log(getClass(), "Creating sessionFactory using URL["+url.getPath()+"]");
			event.getServletContext().setAttribute(Constants.HIBERNATE_SESSION, sessionFactory);
		} catch (HibernateException e) {
			LoggingUtility.log(getClass(), "Exception occured in building Hibernate Session: "+e.getMessage());
		}
	}

}
