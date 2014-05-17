package com.is.action;

import com.is.model.User;
import com.is.service.impl.UserServiceImpl;
import com.is.service.interfaze.UserService;

@SuppressWarnings("serial")
public class UserAction extends BaseAction{
	
	private static UserService userService;
	
	static {
		if (userService==null) {
			userService = new UserServiceImpl();
		}
	}
	
	private User user;

	public User getUser() {
		return user;
	}

	public void setUser(User user) {
		this.user = user;
	}
	
	public String execute(){
		setMenuActive("1");
		page = userService.viewUsers();
		
		return SUCCESS;
	}
	
	

}
