package com.is.security.interceptor;

import com.is.model.User;
import com.is.utilities.Constants;
import com.opensymphony.xwork2.ActionInvocation;
import com.opensymphony.xwork2.interceptor.Interceptor;

@SuppressWarnings("serial")
public class UserInterceptor implements Interceptor{

	public void destroy() {
	}

	public void init() {

	}

	public String intercept(ActionInvocation invocation) throws Exception {

		User user = (User) invocation.getInvocationContext().getSession().get(Constants.USER_SESSION);
		if (user==null) {
			return "login";
		}
		
		return invocation.invoke();
	}
	
	

}
