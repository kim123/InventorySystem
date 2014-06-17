package com.is.security.interceptor;

import com.is.action.LoginAction;
import com.is.model.LoginDetail;
import com.is.utilities.Constants;
import com.opensymphony.xwork2.Action;
import com.opensymphony.xwork2.ActionInvocation;
import com.opensymphony.xwork2.interceptor.Interceptor;

@SuppressWarnings("serial")
public class UserInterceptor implements Interceptor{

	public void destroy() {
	}

	public void init() {

	}

	public String intercept(ActionInvocation invocation) throws Exception {
		Action action = (Action) invocation.getAction();
		if (action instanceof LoginAction) {
			return invocation.invoke();
		}
		LoginDetail loginDetail = (LoginDetail) invocation.getInvocationContext().getSession().get(Constants.USER_SESSION);
		if (loginDetail==null) {
			return "loginuser";
		} else {
			return invocation.invoke();
		}

	}

}
