package com.is.utilities;

import java.io.IOException;
import java.io.InputStream;
import java.util.Properties;

public class PropertyUtility{

	private static Properties property;
  
	static {
		if (property==null) {
			property = new Properties();
		}		
		InputStream is = PropertyUtility.class.getClassLoader().getResourceAsStream("systemConfig.properties");
		try {
			property.load(is);
			is.close();
		} catch (IOException e) {
			e.printStackTrace();
		}
	}
  
	public static String getPropertyValue(String key){
		return property.getProperty(key);
	}
  
}
