package com.is.utilities;

import java.util.HashMap;
import java.util.Map;

import org.apache.log4j.Logger;

public class LoggingUtility {
	
	private static Logger logger;
	@SuppressWarnings("rawtypes")
	private static Map<Class, Logger> loggers;
	
	@SuppressWarnings("rawtypes")
	public static void log(Class clazz, String message){
		Logger log = getLogger(clazz);
		log.info(message);
	}
	
	@SuppressWarnings("rawtypes")
	private static Logger getLogger(Class clazz){
		if (loggers==null) {
			loggers = new HashMap<Class, Logger>();
		}
		if (loggers.containsKey(clazz)) {
			logger = loggers.get(clazz);
		} else {
			logger = Logger.getLogger(clazz);
			loggers.put(clazz, logger);
		}
		return logger;
	}

}
