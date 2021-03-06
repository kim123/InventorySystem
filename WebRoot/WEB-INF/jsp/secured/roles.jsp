<%@page language="java" contentType="text/html" %>
<%@include file="../common/taglib.jsp"%>
<script type="text/javascript">
$(document).ready(function(){
	var roleCheckBoxesLength = 40;
	$("select").change(function(){
		var rankid = document.getElementById('name.rankId').value;
		for (var i = 1; i < roleCheckBoxesLength; i++) {
			document.getElementById(i).checked=false;
		}
		if (rankid!='') {
			var dataString = "roleId="+rankid;
			$.ajax({
				type: "POST",
				url: "getRolePermissionById.htm",
				data: dataString,
				dataType: "json",
				success: function(data){
					if (data.success) {
						var permission = data.permission; 
						for (var i = 1; i < roleCheckBoxesLength; i++) {
							var checkBox = document.getElementById(i).value; 
							var splitPermission = permission.split(",");
							for (var s = 0; s < splitPermission.length; s++) {
								var strChar = splitPermission[s];
								if (checkBox==strChar) {
									document.getElementById(i).checked=true;
								}
							}
						}
					}
				},
				error: function(errorThrown){
					alert("Error occurred in server: "+errorThrown);
				}
			});
		}
	});
	
	$('#cancelButton').click(function(e){
		window.location.href='users.htm';
	});
	
	$('#submitButton').click(function(e){
		var permission = "";
		
		for (var i=1; i < roleCheckBoxesLength; i++) {
			if (document.getElementById(i).checked) {
				permission = permission+document.getElementById(i).value+",";
			}
		}
		var rankid = document.getElementById('name.rankId').value;
		var dataString = "role.rankId="+rankid+"&role.permission="+permission;
		$.ajax({
			type: "POST",
			url: "modifyRankPermission.htm",
			data: dataString,
			dataType: "json",
			success: function(data){
				if (data.success) {
					alert(data.message);
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
	
	$('#addRoleButton').click(function(e){
		if (document.getElementById('role.rank').value=='') {
			displayModalAlert('#modalMessage','Enter role name');
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
	           		 /* alert(data.message);
	           		 $("#addRoleModal").hide(); */
	           		 location.reload();
	           	 } else {
	           		displayModalAlert('#modalMessage',data.message);
	           	 }
			},
			error: function(errorThrown){
				displayModalAlert('#modalMessage',"Error occurred in server: "+errorThrown);
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
      			<div class="panel-body" align="center" style="padding: 0px !important;">
					<div class="alert alert-danger alert-autocloseable-danger modalsOnly" style="display:none;">
						<span id="modalMessage"></span>
					</div>
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
	<c:if test="${fn:contains(sessionScope.userSession.role.permission, 'B3') }">
	<button class="btn btn-primary" data-toggle="modal" data-target="#addRoleModal">
	 	Add Role
	</button>
	</c:if>
	<br/><br/>
	<h4 class="sub-header">Roles</h4>
	<div class="row placeholders">
		<div class="col-xs-6 col-sm-3 placeholder">
			<%-- <s:form action="modifyAccessRights" name="submitForm" id="submitForm" method="post" theme="simple"> --%>
			<h5>Role: <s:select list="roles" emptyOption="true" listKey="rankId" listValue="rank" name="name.rankId" id="name.rankId" style="width: 155px"/></h5>
			<br/>
			<c:if test="${fn:contains(sessionScope.userSession.role.permission, 'B1') }">
			<table border="0" style="width:1000px">
				<tr>
					<td align="left">USER</td>
					<td align="left">ROLE</td>
					<td align="left">CATEGORY</td>
					<td align="left">PRODUCT</td>
					<td align="left">EMPLOYEE</td>
				</tr>
				<tr>
					<td align="left"><input type="checkbox" name="1" id="1" value="A1" />Add User</td>
					<td align="left"><input type="checkbox" name="6" id="2" value="B1" />View Roles</td>
					<td align="left"><input type="checkbox" name="6" id="3" value="C1" />View Category</td>
					<td align="left"><input type="checkbox" name="6" id="4" value="D1" />View Products</td>
					<td align="left"><input type="checkbox" name="6" id="5" value="E1" />Duty Check In</td>
				</tr>
				<tr>
					<td align="left"><input type="checkbox" name="2" id="6" value="A2" />View User List</td>
					<td align="left"><input type="checkbox" name="7" id="7" value="B2" />Set Access Rights</td>
					<td align="left"><input type="checkbox" name="6" id="8" value="C2" />Add Category</td>
					<td align="left"><input type="checkbox" name="6" id="9" value="D2" />Add Products (Prices)</td>
					<td align="left"><input type="checkbox" name="6" id="10" value="E2" />Provide Daily Journal</td>
				</tr>
				<tr>
					<td align="left"><input type="checkbox" name="3" id="11" value="A3" />Modify Role</td>
					<td align="left"><input type="checkbox" name="8" id="12" value="B3" />Add Role</td>
					<td align="left"></td>
					<td align="left"><input type="checkbox" name="6" id="13" value="D3" />Modify Price</td>
					<td align="left"><input type="checkbox" name="6" id="14" value="E3" />Duty Check Out</td>
				</tr>
				<tr>
					<td align="left"><input type="checkbox" name="4" id="15" value="A4" />Modify Password</td>
					<td align="left"></td>
					<td align="left"></td>
					<td align="left"><input type="checkbox" name="6" id="16" value="D4" />Archive Product</td>
					<td align="left"></td>
				</tr>
				<tr>
					<td align="left"><input type="checkbox" name="5" id="17" value="A5" />Modify Status</td>
					<td align="left"></td>
					<td align="left"></td>
					<td align="left"></td>
					<td align="left"></td>
				</tr>
				<tr>
					<td colspan="5">&nbsp;</td>
				</tr>
				<tr>
					<td align="left">INVENTORY</td>
					<td align="left">E-LOAD</td>
					<td align="left">STOCKS ON HAND</td>
					<td align="left">DAILY SALES & EXPENSES</td>
					<td align="left">REPORTS</td>
				</tr>
				<tr>
					<td align="left"><input type="checkbox" name="4" id="18" value="F1" />View Inventory</td>
					<td align="left"><input type="checkbox" name="4" id="19" value="G1" />Add E-Load Daily Sales</td>
					<td align="left"><input type="checkbox" name="4" id="20" value="H1" />Update On-Hand Products</td>
					<td align="left"><input type="checkbox" name="4" id="21" value="I1" />Add Daily Product Sales</td>
					<td align="left"><input type="checkbox" name="4" id="22" value="J1" />Daily Sales & Expenses</td>
				</tr>
				<tr>
					<td align="left"><input type="checkbox" name="4" id="23" value="F2" />Add Stocks</td>
					<td align="left"><input type="checkbox" name="4" id="24" value="G2" />View E-Load Daily Sales Logs</td>
					<td align="left"><input type="checkbox" name="4" id="33" value="H2" />View Stocks On Hand</td>
					<td align="left"><input type="checkbox" name="4" id="25" value="I2" />Add Other Expenses</td>
					<td align="left"><input type="checkbox" name="4" id="26" value="J2" />Weekly Sales & Expenses</td>
				</tr>
				<tr>
					<td align="left"></td>
					<td align="left"><input type="checkbox" name="35" id="35" value="G3" />Update E-Load Daily Balances</td>
					<td align="left"></td>
					<td align="left"><input type="checkbox" name="4" id="34" value="I3" />View Daily Sales & Expenses</td>
					<td align="left"><input type="checkbox" name="4" id="27" value="J3" />Monthly Sales & Expenses</td>
				</tr>
				<tr>
					<td align="left"></td>
					<td align="left"><input type="checkbox" name="36" id="36" value="G4" />View E-Load Daily Balances Logs</td>
					<td align="left"></td>
					<td align="left"></td>
					<td align="left"><input type="checkbox" name="4" id="28" value="J4" />Yearly Sales & Expenses</td>
				</tr>
				<tr>
					<td align="left"></td>
					<td align="left"><input type="checkbox" name="37" id="37" value="G5" />Configure E-LOAD Prices</td>
					<td align="left"></td>
					<td align="left"></td>
					<td align="left"><input type="checkbox" name="4" id="29" value="J5" />Inventory</td>
				</tr>
				<tr>
					<td align="left"></td>
					<td align="left"><input type="checkbox" name="38" id="38" value="G6" />View E-Load Prices</td>
					<td align="left"></td>
					<td align="left"></td>
					<td align="left"><input type="checkbox" name="4" id="30" value="J6" />E-LOAD Revenue</td>
				</tr>
				<tr>
					<td align="left"></td>
					<td align="left"><input type="checkbox" name="39" id="39" value="G7" />Update E-Load Price Status</td>
					<td align="left"></td>
					<td align="left"></td>
					<td align="left"><input type="checkbox" name="4" id="31" value="J7" />Sales Revenue (Top High Sales)</td>
				</tr>
				<tr>
					<td align="left"></td>
					<td align="left"></td>
					<td align="left"></td>
					<td align="left"></td>
					<td align="left"><input type="checkbox" name="4" id="32" value="J8" />Sales Revenue (Top Low Sales)</td>
				</tr>
			</table>
			<br/>
				<button type="button" class="btn btn-default" id="cancelButton">Cancel</button>
			</c:if>
			<c:if test="${fn:contains(sessionScope.userSession.role.permission, 'B2') }">	
        		<button type="button" class="btn btn-primary" id="submitButton">Submit</button>
        	</c:if>
			<%-- </s:form> --%>
		</div>
	</div>
</div>
