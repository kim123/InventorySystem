<%@page language="java" contentType="text/html" %>
<%@include file="../common/taglib.jsp"%>
<script type="text/javascript">
$(document).ready(function(){
	$("select").change(function(){
		var rankid = document.getElementById('name.rankId').value;
		var dataString = "roleId="+rankid;
		$.ajax({
			type: "POST",
			url: "getRolePermissionById.htm",
			data: dataString,
			dataType: "json",
			success: function(data){
				if (data.success) {
					var permission = data.permission; alert(permission);
				}
			},
			error: function(errorThrown){
				alert("Error occurred in server: "+errorThrown);
			}
		});
	});
	
	$('#submitButton').click(function(e){
		var permission = "";
		
		for (var i=1; i < 9; i++) {
			if (document.getElementById(i).checked) {
				permission = permission+document.getElementById(i).value;
			}
		}
		alert(permission);
		var rankid = document.getElementById('name.rankId').value;
		
		
	});
	
	$('#addRoleButton').click(function(e){
		if (document.getElementById('role.rank').value=='') {
			alert('Enter role name');
			document.getElementById('role.rank').focus();
			return false;
		}
		
		var dataString = $('#submitFormRole').serialize();
		dataString = "role.rank="+document.getElementById('role.rank').value;
		$.ajax({
			type: "POST",
			url: "addRoleAction.htm",
			data: dataString,
			dataType: "json",
			success: function(data){
				if (data.success) {
	           		 alert(data.message);
	           		 $("#addRoleModal").hide();
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
	
	

});
</script>

<div class="modal fade" id="addRoleModal" tabindex="-1" role="dialog" aria-labelledby="myModalLabel" aria-hidden="true">
	<div class="modal-dialog">
    <div class="modal-content">
      <div class="modal-header">
        <button type="button" class="close" data-dismiss="modal" aria-hidden="true">&times;</button>
        <h4 class="modal-title" id="myModalLabel">Add Role</h4>
      </div>
      <div class="modal-body">
      		<s:form action="addRoleAction" method="post" theme="simple" id="submitFormRole">
       		<table border=0 align="center">
       			<tr>
       				<td>Role: </td>
       				<td><input type="text" name="role.rank" id="role.rank"/></td>
       				<td>&nbsp;&nbsp;&nbsp;<span class="label label-danger" id="errorMsgUser">*</span></td>
       			</tr>
       			<input type="hidden" name="role.createdBy" value="${sessionScope.userSession.user.userName }"/>
       		</table>
       		</s:form>
      </div>
      <div class="modal-footer">
        <button type="button" class="btn btn-default" data-dismiss="modal">Close</button>
        <button type="button" class="btn btn-primary" id="addRoleButton">Add</button>
      </div>
    </div>
  </div>
</div>

<div class="col-sm-9 col-sm-offset-3 col-md-10 col-md-offset-2 main">
	<h2 class="page-header">Access Rights</h2>
	<button class="btn btn-primary" data-toggle="modal" data-target="#addRoleModal">
	 	Add Role
	</button>
	<br/><br/>
	<h4 class="sub-header">Roles</h4>
	<div class="row placeholders">
		<div class="col-xs-6 col-sm-3 placeholder">
			<s:form action="modifyAccessRights" name="submitForm" id="submitForm" method="post" theme="simple">
			<h5>Role: <s:select list="roles" emptyOption="true" listKey="rankId" listValue="rank" name="name.rankId" id="name.rankId" style="width: 155px"/></h5>
			<br/>
			<table border="0" style="width:450px">
				<tr>
					<td align="left">USER</td>
					<td align="left">ROLE</td>
				</tr>
				<tr>
					<td align="left"><input type="checkbox" name="1" id="1" value="a" />Add User</td>
					<td align="left"><input type="checkbox" name="6" id="2" value="f" />View Roles</td>
				</tr>
				<tr>
					<td align="left"><input type="checkbox" name="2" id="3" value="b" />View User List</td>
					<td align="left"><input type="checkbox" name="7" id="4" value="g" />Set Access Rights</td>
				</tr>
				<tr>
					<td align="left"><input type="checkbox" name="3" id="5" value="c" />Modify Role</td>
					<td align="left"><input type="checkbox" name="8" id="6" value="h" />Add Role</td>
				</tr>
				<tr>
					<td align="left"><input type="checkbox" name="4" id="7" value="d" />Modify Password</td>
					<td align="left"></td>
				</tr>
				<tr>
					<td align="left"><input type="checkbox" name="5" id="8" value="e" />Modify Status</td>
					<td align="left"></td>
				</tr>
			</table>
			<br/>
				<button type="button" class="btn btn-default" id="cancelButton">Cancel</button>
        		<button type="button" class="btn btn-primary" id="submitButton">Submit</button>
			</s:form>
		</div>
	</div>
</div>