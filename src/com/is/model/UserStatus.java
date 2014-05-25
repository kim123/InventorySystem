package com.is.model;

import java.util.ArrayList;
import java.util.List;

public class UserStatus {
	
	private String description;
	private int code;
	private static List<UserStatus> userStatusList;
	
	public String getDescription() {
		return description;
	}
	public void setDescription(String description) {
		this.description = description;
	}
	public int getCode() {
		return code;
	}
	public void setCode(int code) {
		this.code = code;
	}

	public static List<UserStatus> getUserStatusList() {
		userStatusList = new ArrayList<UserStatus>();
		
		UserStatus enabled = new UserStatus();
		enabled.setDescription("Enabled");
		enabled.setCode(0);
		UserStatus disabled = new UserStatus();
		disabled.setDescription("Disabled");
		disabled.setCode(1);
		
		userStatusList.add(enabled);
		userStatusList.add(disabled);
		
		return userStatusList;		
	}
	
	

}
