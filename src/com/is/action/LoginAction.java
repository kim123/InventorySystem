package com.is.action;

import org.apache.commons.lang.StringUtils;

import com.is.model.User;
import com.is.service.impl.UserServiceImpl;
import com.is.service.interfaze.UserService;
import com.is.utilities.Constants;
import com.is.utilities.MD5Encode;
import com.is.utilities.SessionUtility;

@SuppressWarnings("serial")
public class LoginAction extends BaseAction{
	
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
		if (StringUtils.isEmpty(user.getUserName())) {
			setMessage(getText(Constants.LOGIN_FAILED_ENTER_USERNAME));
			return INPUT;
		} else if (StringUtils.isEmpty(user.getPassword())) {
			setMessage(getText(Constants.LOGIN_FAILED_ENTER_PASSWORD));
			return INPUT;
		}
		user.setPassword(MD5Encode.encodeMD5(user.getPassword()));
		String result = userService.login(user);
		if (!result.equals(Constants.SUCCESS)) {
			setMessage(result);
			return INPUT;
		}
	
		return SUCCESS;
	}
	
	public String logout(){
		SessionUtility.invalidateUserSession();
		return SUCCESS;
	}

}
