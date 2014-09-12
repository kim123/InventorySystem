package com.is.utilities;

public class Constants {
	
	public static final String USER_SESSION = "userSession";
	public static final String HIBERNATE_SESSION = "hibernateSession";
	public static final String EMPLOYEE_ON_DUTY_SESSION = "onDutySession";
	public static final String SUCCESS = "success";
	
	public static final String LOGIN_FAILED_ENTER_USERNAME = "enter.username";
	public static final String LOGIN_FAILED_ENTER_PASSWORD = "enter.password";
	public static final String LOGIN_FAILED_USER_NOT_EXISTING = "user.not.existing";
	public static final String LOGIN_FAILED_INCORRECT_PASSWORD = "incorrect.password";
	public static final String LOGIN_FAILED_ACCOUNT_DISABLED = "account.disabled";
	
	public static final String CHANGE_PASSWORD_ENTER_NEW_PASSWORD = "new.password.must.not.be.empty";
	public static final String CHANGE_PASSWORD_ENTER_OLD_PASSWORD = "old.password.must.not.be.empty";
	
	public static final String PAGE_TYPE_PREVIOUS = "previous";
	public static final String PAGE_TYPE_NEXT = "next";
	
	public static final String ELOAD_GLOBE_PRODUCT_ID = PropertyUtility.getPropertyValue("eload.price.smart");
	public static final String ELOAD_SMART_PRODUCT_ID = PropertyUtility.getPropertyValue("eload.price.globe");
	public static final String ELOAD_SUN_PRODUCT_ID = PropertyUtility.getPropertyValue("eload.price.sun");
	

}
