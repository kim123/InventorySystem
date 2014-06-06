package com.is.utilities;

public class PropertyUtility{

  private static Properties property;
  
  static {
    property = new Properties();
    InputStream is = PropertyUtility.class.getClassLoader().getResourceAsStream("config.properties");
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
