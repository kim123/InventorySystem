package com.is.service.interfaze;

import com.is.model.Page;
import com.is.model.Role;
import com.is.model.User;

public interface UserService {

	String login(User user);
	String addUser(User user);
	Page viewUsers();
	String modifyRole(Role role);
	String modifyPassword(User user);
	String modifyStatus(User user);
	User getUser(int userId);
	User getUser(String userName);
	
}
