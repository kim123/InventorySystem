<%@page language="java" contentType="text/html" %>
<%@include file="../common/taglib.jsp"%>

<script type="text/javascript">
	function addUser(){
		if (document.getElementById('user.userName').value=='') {
			alert('<s:text name="enter.username" />');
			document.getElementById('user.userName').focus();
			return false;
		}
		if (document.getElementById('user.password').value=='') {
			alert('<s:text name="enter.password" />');
			document.getElementById('user.password').focus();
			return false;
		}
		if (document.getElementById('confirmpassword').value=='') {
			alert('<s:text name="confirm.password" />');
			document.getElementById('confirmpassword').focus();
			return false;
		}
		if (document.getElementById('confirmpassword').value!=document.getElementById('user.password').value) {
			alert('<s:text name="confirmed.password.must.be.equal" />');
			document.getElementById('confirmpassword').focus();
			return false;
		}
		if (document.getElementById('user.status').value=='') {
			alert('<s:text name="choose.status.for.user" />');
			document.getElementById('user.status').focus();
			return false;
		}
		if (document.getElementById('user.rankId').value=='') {
			alert('<s:text name="choose.role.for.user" />');
			document.getElementById('user.rankId').focus();
			return false;
		}
		document.getElementById('submitForm').submit();
		
	}
</script>

<div class="modal fade" id="addUserModal" tabindex="-1" role="dialog" aria-labelledby="myModalLabel" aria-hidden="true">
	<div class="modal-dialog">
    <div class="modal-content">
      <div class="modal-header">
        <button type="button" class="close" data-dismiss="modal" aria-hidden="true">&times;</button>
        <h4 class="modal-title" id="myModalLabel">Add User</h4>
      </div>
      <div class="modal-body">
      		<s:form action="addUserAction" method="post" theme="simple" id="submitForm">
       		<table border=1 align="center">
       			<tr>
       				<td>User Name: </td>
       				<td><input type="text" name="user.userName" id="user.userName"/></td>
       				<td>&nbsp;&nbsp;&nbsp;<span class="label label-danger" id="errorMsgUser">*</span></td>
       			</tr>
       			<tr>
       				<td>Password: </td>
       				<td><input type="text" name="user.password" id="user.password"/></td>
       				<td>&nbsp;&nbsp;&nbsp;<span class="label label-danger" id="errorMsgPassword">*</span></td>
       			</tr>
       			<tr>
       				<td>Confirm Password: </td>
       				<td><input type="text" name="confirmpassword" id="confirmpassword"/></td>
       				<td>&nbsp;&nbsp;&nbsp;<span class="label label-danger" id="errorMsgConfirmPassword">*</span></td>
       			</tr>
       			<tr>
       				<td>Full Name: </td>
       				<td><input type="text" name="user.fullName" id="user.fullName"/></td>
       				<td><span class="label label-danger"></span></td>
       			</tr>
       			<tr>
       				<td>Status: </td>
       				<td><s:select list="userStatuses" listKey="code" listValue="description" name="user.status" id="user.status"/><td>
       				<td>&nbsp;&nbsp;&nbsp;<span class="label label-danger" id="errorMsgStatus">*</span></td>
       			</tr>
       			<tr>
       				<td>Role: </td>
       				<td><s:select list="roles" listKey="rankId" listValue="rank" name="name.rankId" id="name.rankId"/></td>
       				<td>&nbsp;&nbsp;&nbsp;<span class="label label-danger" id="errorMsgRole">*</span></td>
       			</tr>
       		</table>
       		</s:form>
      </div>
      <div class="modal-footer">
        <button type="button" class="btn btn-default" data-dismiss="modal">Close</button>
        <button type="button" class="btn btn-primary" onClick="addUser()">Add</button>
      </div>
    </div>
  </div>
</div>

<div class="modal fade" id="modifyRoleModal" tabindex="-1" role="dialog" aria-labelledby="myModalLabel" aria-hidden="true">
	<div class="modal-dialog">
    <div class="modal-content">
      <div class="modal-header">
        <button type="button" class="close" data-dismiss="modal" aria-hidden="true">&times;</button>
        <h4 class="modal-title" id="myModalLabel">Add User</h4>
      </div>
      <div class="modal-body">
      		<s:form action="addUserAction" method="post" theme="simple" id="submitForm">
       		<table border=1 align="center">
       			<tr>
       				<td>User Name: </td>
       				<td><input type="text" name="user.userName" id="user.userName"/></td>
       				<td>&nbsp;&nbsp;&nbsp;<span class="label label-danger" id="errorMsgUser">*</span></td>
       			</tr>
       			<tr>
       				<td>Role: </td>
       				<td><s:select list="roles" listKey="rankId" listValue="rank" name="name.rankId" id="name.rankId"/></td>
       				<td>&nbsp;&nbsp;&nbsp;<span class="label label-danger" id="errorMsgRole">*</span></td>
       			</tr>
       		</table>
       		</s:form>
      </div>
      <div class="modal-footer">
        <button type="button" class="btn btn-default" data-dismiss="modal">Close</button>
        <button type="button" class="btn btn-primary" onClick="addUser()">Add</button>
      </div>
    </div>
  </div>
</div>

<div class="modal fade" id="modifyStatusModal" tabindex="-1" role="dialog" aria-labelledby="myModalLabel" aria-hidden="true">
	<div class="modal-dialog">
    <div class="modal-content">
      <div class="modal-header">
        <button type="button" class="close" data-dismiss="modal" aria-hidden="true">&times;</button>
        <h4 class="modal-title" id="myModalLabel">Add User</h4>
      </div>
      <div class="modal-body">
      		<s:form action="addUserAction" method="post" theme="simple" id="submitForm">
       		<table border=1 align="center">
       			<tr>
       				<td>User Name: </td>
       				<td><input type="text" name="user.userName" id="user.userName"/></td>
       				<td>&nbsp;&nbsp;&nbsp;<span class="label label-danger" id="errorMsgUser">*</span></td>
       			</tr>
       			<tr>
       				<td>Status: </td>
       				<td><s:select list="userStatuses" listKey="code" listValue="description" name="user.status" id="user.status"/><td>
       				<td>&nbsp;&nbsp;&nbsp;<span class="label label-danger" id="errorMsgStatus">*</span></td>
       			</tr>
       		</table>
       		</s:form>
      </div>
      <div class="modal-footer">
        <button type="button" class="btn btn-default" data-dismiss="modal">Close</button>
        <button type="button" class="btn btn-primary" onClick="addUser()">Add</button>
      </div>
    </div>
  </div>
</div>

<div class="modal fade" id="modifyPasswordModal" tabindex="-1" role="dialog" aria-labelledby="myModalLabel" aria-hidden="true">
	<div class="modal-dialog">
    <div class="modal-content">
      <div class="modal-header">
        <button type="button" class="close" data-dismiss="modal" aria-hidden="true">&times;</button>
        <h4 class="modal-title" id="myModalLabel">Add User</h4>
      </div>
      <div class="modal-body">
      		<s:form action="modifyOwnPasswordAction" method="post" theme="simple" id="submitForm">
		        	<table border=0 align="center">
		        		<tr>
		        			<td>Old Password: </td>
		        			<td><input type="password" name="oldPassword" id="oldPassword" placeholder="Old Password"/></td>
		        			<td>&nbsp;&nbsp;&nbsp;<span class="label label-danger">*</span></td>
		        		</tr>
		        		<tr>
		        			<td>New Password: </td>
		        			<td><input type="password" name="user.password" id="password" placeholder="New Password"/></td>
		        			<td>&nbsp;&nbsp;&nbsp;<span class="label label-danger">*</span></td>
		        		</tr>
		        		<tr>
		        			<td>Confirm Password: </td>
		        			<td><input type="password" name="confirmpassword" id="confirmpassword" placeholder="Confirm Password"/></td>
		        			<td>&nbsp;&nbsp;&nbsp;<span class="label label-danger">*</span></td>
		        		</tr>
		        		<input type="hidden" name="user.userId" value="${sessionScope.userSession.user.userId }"/>
		        	</table>
		        	</s:form>
      </div>
      <div class="modal-footer">
        <button type="button" class="btn btn-default" data-dismiss="modal">Close</button>
        <button type="button" class="btn btn-primary" onClick="addUser()">Add</button>
      </div>
    </div>
  </div>
</div>

<div class="col-sm-9 col-sm-offset-3 col-md-10 col-md-offset-2 main">

	<h2 class="page-header">Users</h2>
	<button class="btn btn-primary" data-toggle="modal" data-target="#addUserModal">
	 	Add User
	</button>
	<br/><br/>
	<h4 class="sub-header">User List</h4>
	<div class="table-responsive">
		<table class="table table-striped">
			<thead>
                <tr>
                  <th>User ID</th>
                  <th>User Name</th>
                  <th>Full Name</th>
                  <th>Status</th>
                  <th>Role</th>
                  <th>Updated Date</th>
                  <th>Updated By</th>
                  <th>Action</th>
                </tr>
           </thead>		
           <tbody>
           		<c:forEach items="${page.contents}" var="query">
           			<tr>
	           			<td>${query.userId }</td>
	           			<td>${query.userName }</td>
	           			<td>${query.fullName }</td>
	           			<td>
							<c:if test="${query.status eq 0 }">
								Enabled
							</c:if>
							<c:if test="${query.status eq 1 }">
								<span style="color:red">Disabled</span>
							</c:if>
						</td>
						<td>${query.rank }</td>
	           			<td><fmt:formatDate type="both" value="${query.createdDate}" /></td>
	           			<td>${query.createdBy }</td>
	           			<td>
	           				<c:if test="${sessionScope.userSession.role.rankId ne 1}">
	           					<a href="#" data-toggle="modal" data-target="#modifyRoleModal" onclick="setValues('role','${query.userId }','${query.userName }','${query.rank }');">Role</a> |
	           				</c:if>
	           				<c:if test="${sessionScope.userSession.role.rankId ne 1}">
	           					<a href="#" data-toggle="modal" data-target="#modifyStatusModal" onclick="setValues('status','${query.userId }','${query.userName }','${query.status}');">Status</a> |
	           				</c:if>
	           				<a href="#" data-toggle="modal" data-target="#modifyPasswordModal" onclick="setValues('password','${query.userId }','${query.userName }','${query.status}','-');">Password</a>
	           			</td>
	           		</tr>
           		</c:forEach>
           		<tr>
           			<td colspan="7"></td>
           		</tr>
           </tbody>
		</table>
	</div>
					
</div>