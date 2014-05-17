package com.is.service.interfaze;

import com.is.model.Role;

public interface RoleService {

	String addRole(Role role);
	String viewRolesAndPermission(Role role);
	Role getRole(int roleId);
	Role getRole(String role);
	String modifyRolePermission(Role role);
	
}
