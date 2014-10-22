package com.is.utilities;

import com.is.model.User;
import com.is.service.impl.UserServiceImpl;
import com.is.service.interfaze.UserService;

public class UserUtility {
	
	private static UserService userService;
	
	static {
		if (userService==null) {
			userService = new UserServiceImpl();
		}
	}
	
	public static User getUserBasedOnUserId(int userId){
		return userService.getUser(userId);
	}

}
