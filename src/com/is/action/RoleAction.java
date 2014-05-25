package com.is.action;

import java.io.IOException;
import java.io.PrintWriter;
import java.util.List;

import org.apache.struts2.ServletActionContext;
import org.json.JSONException;
import org.json.JSONObject;

import com.is.model.Role;
import com.is.service.impl.RoleServiceImpl;
import com.is.service.interfaze.RoleService;
import com.is.utilities.Constants;
import com.is.utilities.SessionUtility;

@SuppressWarnings("serial")
public class RoleAction extends BaseAction{
	
	private static RoleService roleService;
	
	static {
		if (roleService==null) {
			roleService = new RoleServiceImpl();
		}
	}
	
	private Role role;
	private int roleId;
	
	public List<Role> roles = roleService.getRoles();

	public int getRoleId() {
		return roleId;
	}

	public void setRoleId(int roleId) {
		this.roleId = roleId;
	}

	public Role getRole() {
		return role;
	}

	public void setRole(Role role) {
		this.role = role;
	}

	public String execute(){
		setMenuActive("2");
		
		return SUCCESS;
	}
	
	public String addRole(){
		setMenuActive("2");
		PrintWriter out = null;
		try {
			out = ServletActionContext.getResponse().getWriter();
		} catch (IOException e) {
			e.printStackTrace();
		}
		JSONObject json = new JSONObject();
		role.setCreatedBy(SessionUtility.getUser().getUserName());
		String result = roleService.addRole(role);
		try {
			if (result.equals(Constants.SUCCESS)) {
				json.put(Constants.SUCCESS, true);
			} else {
				json.put(Constants.SUCCESS, false);
			}
			json.put("message", result);
		} catch (JSONException e) {
			e.printStackTrace();
		}
		
		out.println(json.toString());
		out.close();
		
		return null;
	}
	
	public String getRolePermissionById(){
		PrintWriter out = null;
		try {
			out = ServletActionContext.getResponse().getWriter();
		} catch (IOException e) {
			e.printStackTrace();
		}
		JSONObject json = new JSONObject();
		Role retrievedRole = roleService.getRole(roleId);
		try {
			json.put(Constants.SUCCESS, true);
			json.put("permission", retrievedRole.getPermission());
		} catch (JSONException e) {
			e.printStackTrace();
		}
		
		out.println(json.toString());
		out.close();
		
		return null;
	}
	
}
