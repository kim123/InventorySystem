<%@page language="java" contentType="text/html" %>
<%@include file="../common/taglib.jsp"%>

<script type="text/javascript">
	$(document).ready(function(){
		$('#addUserButton').click(function(e){
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
			
			var dataString = $('#submitFormAddUser').serialize();
			dataString = "user.userName="+document.getElementById('user.userName').value+"&"+
							"user.password="+document.getElementById('user.password').value+"&"+
							"user.fullName="+document.getElementById('user.fullName').value+"&"+
							"user.status="+document.getElementById('user.status').value+"&"+
							"user.rankId="+document.getElementById('user.rankId').value;
			$.ajax({
				 type: "POST",
	             url: "addUserAction.htm",
	             data: dataString,
	             dataType: "json",
	             success: function(data){
	            	 if (data.success) {
	            		 alert(data.message);
	            		 $("#addUserModal").hide();
	            		 location.reload();
	            	 } else {
	            		 alert(data.message);
	            	 }
	             },
	             error: function(errorThrown){
	            	 alert("Error occurred in server: "+errorThrown);
	             }
			});			
		});
		
		$('.mr').click(function(e){
			var userid = e.target.id.split("-")[1]; 
			var username = e.target.id.split("-")[2];
			var rank = e.target.id.split("-")[3];
			$('.userName').val(username+' ['+rank+']');
			$('.userId').val(userid);
		});	
		$('.ms').click(function(e){
			var userid = e.target.id.split("-")[1];
			var username = e.target.id.split("-")[2];
			
			$('.userName').val(username);
			$('.userId').val(userid);
		});
		$('.mp').click(function(e){
			var userid = e.target.id.split("-")[1];
			var username = e.target.id.split("-")[2];
			
			$('.userName').val(username);
			$('.userId').val(userid);
		});
		$('#modifyRoleButton').click(function(e){
			var userid = $('.userId').val();
			var rankid = $('#rankId2').val();
			var dataString = 'user.userId='+userid+'&user.rankId='+rankid;
			$.ajax({
				type: "POST",
				url: "modifyRoleAction.htm",
				data: dataString,
				dataType: "json",
				success: function(data){
					alert(data.message);
					if (data.success) {
						$('#modifyRoleModal').hide();
						location.reload();
					}
				},
				error: function(errorThrown){
					alert('Error 500: '+errorThrown);
				}
			});
		});
		$('#modifyStatusButton').click(function(e){
			var userid = $('.userId').val();
			var statusq = $('#status22').val();
			var dataString = 'user.userId='+userid+'&user.status='+statusq;
			$.ajax({
				type: "POST",
				url: "modifyStatusAction.htm",
				data: dataString,
				dataType: "json",
				success: function(data){
					alert(data.message);
					if (data.success) {
						$('#modifyStatusModal').hide();
						location.reload();
					}
				},
				error: function(errorThrown){
					alert('Error 500: '+errorThrown);
				}
			});
		});
		$('#modifyPasswordButton').click(function(e){
			var userid = $('.userId').val();
			var password = $('#password').val(); alert(password);
			alert(document.getElementById('confirmpassword1').value);
			if (password=='') {
				alert('<s:text name="enter.password" />');
				document.getElementById('password').focus();
				return false;
			} else if (document.getElementById('confirmpassword1').value=='') {
				alert('<s:text name="confirm.password" />');
				document.getElementById('confirmpassword1').focus();
				return false;
			} else if (document.getElementById('confirmpassword1').value!=document.getElementById('password').value) {
				alert('<s:text name="confirmed.password.must.be.equal" />');
				document.getElementById('confirmpassword1').focus();
				return false;
			} else {
				var dataString = 'user.userId='+userid+'&user.password='+password;
				$.ajax({
					type: "POST",
					url: "modifyPasswordAction.htm",
					data: dataString,
					dataType: "json",
					success: function(data){
						alert(data.message);
						if (data.success) {
							$('#modifyPasswordModal').hide();
							location.reload();
						}
					},
					error: function(errorThrown){
						alert('Error 500: '+errorThrown);
					}
				});
			}
		});
	 
	});
</script>

<div class="modal fade" id="addUserModal" tabindex="-1" role="dialog" aria-labelledby="myModalLabel" aria-hidden="true">
	<div class="modal-dialog">
    <div class="modal-content">
      <div class="modal-header">
        <button type="button" class="close" data-dismiss="modal" aria-hidden="true">&times;</button>
        <h4 class="modal-title" id="myModalLabel">Add User</h4>
      </div>
      <div class="modal-body">
      		<s:form action="addUserAction" method="post" theme="simple" id="submitFormAddUser">
       		<table border=0 align="center">
       			<tr>
       				<td>User Name: </td>
       				<td><input type="text" name="user.userName" id="user.userName"/></td>
       				<td>&nbsp;&nbsp;&nbsp;<span class="label label-danger" id="errorMsgUser">*</span></td>
       			</tr>
       			<tr>
       				<td>Password: </td>
       				<td><input type="password" name="user.password" id="user.password"/></td>
       				<td>&nbsp;&nbsp;&nbsp;<span class="label label-danger" id="errorMsgPassword">*</span></td>
       			</tr>
       			<tr>
       				<td>Confirm Password: </td>
       				<td><input type="password" name="confirmpassword" id="confirmpassword"/></td>
       				<td>&nbsp;&nbsp;&nbsp;<span class="label label-danger" id="errorMsgConfirmPassword">*</span></td>
       			</tr>
       			<tr>
       				<td>Full Name: </td>
       				<td><input type="text" name="user.fullName" id="user.fullName"/></td>
       				<td><span class="label label-danger"></span></td>
       			</tr>
       			<tr>
       				<td>Status: </td>
       				<td><s:select list="userStatuses" emptyOption="true" listKey="code" listValue="description" name="user.status" id="user.status" style="width: 155px"/></td>
       				<td>&nbsp;&nbsp;&nbsp;<span class="label label-danger" id="errorMsgStatus">*</span></td>
       			</tr>
       			<tr>
       				<td>Role: </td>
       				<td><s:select list="roles" emptyOption="true" listKey="rankId" listValue="rank" name="user.rankId" id="user.rankId" style="width: 155px"/></td>
       				<td>&nbsp;&nbsp;&nbsp;<span class="label label-danger" id="errorMsgRole">*</span></td>
       			</tr>
       		</table>
       		</s:form>
      </div>
      <div class="modal-footer">
        <button type="button" class="btn btn-default" data-dismiss="modal">Close</button>
        <button type="button" class="btn btn-primary" id="addUserButton">Add</button>
      </div>
    </div>
  </div>
</div>

<div class="modal fade" id="modifyRoleModal" tabindex="-1" role="dialog" aria-labelledby="myModalLabel" aria-hidden="true">
	<div class="modal-dialog">
    <div class="modal-content">
      <div class="modal-header">
        <button type="button" class="close" data-dismiss="modal" aria-hidden="true">&times;</button>
        <h4 class="modal-title" id="myModalLabel">Modify User Role</h4>
      </div>
      <div class="modal-body">
       		<table border=1 align="center">
       			<tr>
       				<td>User Name: </td>
       				<td><input type="text" name="user.userName" id="user.userName" class="userName" value="" disabled/></td>
       				<td>&nbsp;&nbsp;&nbsp;<span class="label label-danger" id="errorMsgUser">*</span></td>
       			</tr>
       			<tr>
       				<td>Role: </td>
       				<td><s:select list="roles" listKey="rankId" listValue="rank" name="user.rankId" id="rankId2" theme="simple"/></td>
       				<td>&nbsp;&nbsp;&nbsp;<span class="label label-danger" id="errorMsgRole">*</span></td>
       			</tr>
       			<input type="hidden" name="user.userId" class="userId" value=""/>
       		</table>
      </div>
      <div class="modal-footer">
        <button type="button" class="btn btn-default" data-dismiss="modal">Cancel</button>
        <button type="button" class="btn btn-primary" id="modifyRoleButton">Modify</button>
      </div>
    </div>
  </div>
</div>

<div class="modal fade" id="modifyStatusModal" tabindex="-1" role="dialog" aria-labelledby="myModalLabel" aria-hidden="true">
	<div class="modal-dialog">
    <div class="modal-content">
      <div class="modal-header">
        <button type="button" class="close" data-dismiss="modal" aria-hidden="true">&times;</button>
        <h4 class="modal-title" id="myModalLabel">Modify User Status</h4>
      </div>
      <div class="modal-body">
       		<table border=1 align="center">
       			<tr>
       				<td>User Name: </td>
       				<td><input type="text" name="user.userName" id="user.userName" class="userName" value="" disabled/></td>
       				<td>&nbsp;&nbsp;&nbsp;<span class="label label-danger" id="errorMsgUser">*</span></td>
       			</tr>
       			<tr>
       				<td>Status: </td>
       				<td><s:select list="userStatuses" listKey="code" listValue="description" name="user.status" id="status22" theme="simple"/></td>
       				<td>&nbsp;&nbsp;&nbsp;<span class="label label-danger" id="errorMsgStatus">*</span></td>
       			</tr>
       			<input type="hidden" name="user.userId" class="userId" value=""/>
       		</table>
      </div>
      <div class="modal-footer">
        <button type="button" class="btn btn-default" data-dismiss="modal">Cancel</button>
        <button type="button" class="btn btn-primary" id="modifyStatusButton">Modify</button>
      </div>
    </div>
  </div>
</div>

<div class="modal fade" id="modifyPasswordModal" tabindex="-1" role="dialog" aria-labelledby="myModalLabel" aria-hidden="true">
	<div class="modal-dialog">
    <div class="modal-content">
      <div class="modal-header">
        <button type="button" class="close" data-dismiss="modal" aria-hidden="true">&times;</button>
        <h4 class="modal-title" id="myModalLabel">Modify User Password</h4>
      </div>
      <div class="modal-body">
		        	<table border=0 align="center">
		        		<tr>
		        			<td>Username: </td>
		        			<td><input type="text" name="user.userName" id="user.userName" class="userName" value="" disabled/></td>
		        			<td>&nbsp;&nbsp;&nbsp;<span class="label label-danger">*</span></td>
		        		</tr>
		        		<tr>
		        			<td>New Password: </td>
		        			<td><input type="password" name="user.password" id="password" placeholder="New Password"/></td>
		        			<td>&nbsp;&nbsp;&nbsp;<span class="label label-danger">*</span></td>
		        		</tr>
		        		<tr>
		        			<td>Confirm Password: </td>
		        			<td><input type="password" name="confirmpassword" id="confirmpassword1" placeholder="Confirm Password"/></td>
		        			<td>&nbsp;&nbsp;&nbsp;<span class="label label-danger">*</span></td>
		        		</tr>
		        		<input type="hidden" name="user.userId" class="userId" value=""/>
		        	</table>
      </div>
      <div class="modal-footer">
        <button type="button" class="btn btn-default" data-dismiss="modal">Cancel</button>
        <button type="button" class="btn btn-primary" id="modifyPasswordButton">Modify</button>
      </div>
    </div>
  </div>
</div>

<div class="col-sm-9 col-sm-offset-3 col-md-10 col-md-offset-2 main">

	<h2 class="page-header">Users</h2>
	<c:if test="${fn:contains(sessionScope.userSession.role.permission, 'A1') }">
	<button class="btn btn-primary" data-toggle="modal" data-target="#addUserModal">
	 	Add User
	</button>
	</c:if>
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
           		<c:if test="${fn:contains(sessionScope.userSession.role.permission, 'A2') }">
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
	           				<c:if test="${fn:contains(sessionScope.userSession.role.permission, 'A3') }">
	           					<a href="#" data-toggle="modal" data-target="#modifyRoleModal" class="mr" id="mr-${query.userId}-${query.userName}-${query.rank}">Role</a> |
	           				</c:if>
	           				<c:if test="${fn:contains(sessionScope.userSession.role.permission, 'A5') }">
	           					<a href="#" data-toggle="modal" data-target="#modifyStatusModal" class="ms" id="ms-${query.userId}-${query.userName}-${query.status}">Status</a> |
	           				</c:if>
	           				<c:if test="${fn:contains(sessionScope.userSession.role.permission, 'A4') }">
	           					<a href="#" data-toggle="modal" data-target="#modifyPasswordModal" class="mp" id="mp-${query.userId}-${query.userName}">Password</a>
	           				</c:if>
	           			</td>
	           		</tr>
           		</c:forEach>
           		<c:if test="${empty page.contents }">
					<tr>
						<td colspan="8">No records</td>
					</tr>
				</c:if>
           		</c:if>
           		<c:if test="${!(fn:contains(sessionScope.userSession.role.permission, 'B3')) }">
           			<tr>
						<th colspan="8">No access rights to proceed</th>
					</tr>
           		</c:if>
           		<tr>
           			<td colspan="8"></td>
           		</tr>
           </tbody>
		</table>
	</div>
					
</div>