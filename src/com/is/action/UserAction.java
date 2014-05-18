package com.is.action;

import java.util.List;

import org.apache.commons.lang.StringUtils;

import com.is.model.Role;
import com.is.model.User;
import com.is.model.UserStatus;
import com.is.service.impl.RoleServiceImpl;
import com.is.service.impl.UserServiceImpl;
import com.is.service.interfaze.RoleService;
import com.is.service.interfaze.UserService;
import com.is.utilities.Constants;
import com.is.utilities.MD5Encode;
import com.is.utilities.SessionUtility;

@SuppressWarnings("serial")
public class UserAction extends BaseAction{
	
	private static UserService userService;
	private static RoleService roleService;
	
	static {
		if (userService==null) {
			userService = new UserServiceImpl();
		}
		if (roleService==null) {
			roleService = new RoleServiceImpl();
		}
	}
	
	private User user;
	private String oldPassword;

	public List<UserStatus> userStatuses = UserStatus.getUserStatusList();
	public List<Role> roles = roleService.getRoles();
	
	public String getOldPassword() {
		return oldPassword;
	}

	public void setOldPassword(String oldPassword) {
		this.oldPassword = oldPassword;
	}

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
	
	public String addUser(){
		setMenuActive("1");
		
		
		return SUCCESS;
	}
	
	public String modifyOwnPassword(){
		if (StringUtils.isBlank(user.getPassword())) {
			setMessage(Constants.CHANGE_PASSWORD_ENTER_NEW_PASSWORD);
		} else if (StringUtils.isBlank(oldPassword)){
			setMessage(Constants.CHANGE_PASSWORD_ENTER_OLD_PASSWORD);
		}else {
			setOldPassword(MD5Encode.encodeMD5(oldPassword));
			user.setPassword(MD5Encode.encodeMD5(user.getPassword()));
			user.setCreatedBy(SessionUtility.getUser().getUserName());
			String result = userService.modifyOwnPassword(user, oldPassword);
			setMessage(result);
		}
		
		return SUCCESS;
	}

}
