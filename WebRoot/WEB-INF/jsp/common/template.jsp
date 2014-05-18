<%@page language="java" contentType="text/html" %>
<%@include file="../common/taglib.jsp"%>
<!DOCTYPE html>
<html lang="en">
	<head>
		<title>JFI Inventory System</title>
		<!-- Bootstrap core CSS -->
		<link href="<c:url value='/js/bootstrap-3.1.1-dist/css/bootstrap.min.css'/>" rel="stylesheet"/>
		<!-- Custom styles for this template -->
		<link href="<c:url value='/css/dashboard.css' />" rel="stylesheet"/>
		<script type="text/javascript">
			function promptMessage(){
				<c:if test="${not empty message}" >
					alert("<s:text name='%{getText(message)}' />");
				</c:if>
			}
			
			function modifyPassword(){
				if (document.getElementById('oldPassword').value=='') {
					alert('<s:text name="enter.old.password" />');
					document.getElementById('oldPassword').focus();
					return false;
				}
				if (document.getElementById('password').value=='') {
					alert('<s:text name="enter.new.password" />');
					document.getElementById('password').focus();
					return false;
				}
				if (document.getElementById('confirmpassword').value=='') {
					alert('<s:text name="confirm.password" />');
					document.getElementById('confirmpassword').focus();
					return false;
				}
				if (document.getElementById('confirmpassword').value!=document.getElementById('password').value) {
					alert('<s:text name="confirmed.password.must.be.equal" />');
					document.getElementById('confirmpassword').focus();
					return false;
				}
				document.getElementById('submitForm').submit();
			}
		</script>
	</head>
	<body onLoad="promptMessage();">
		<div class="navbar navbar-inverse navbar-fixed-top" role="navigation">
			<div class="container-fluid">
				<div class="navbar-header">
					<button type="button" class="navbar-toggle" data-toggle="collapse" data-target=".navbar-collapse">
						<span class="sr-only">Toggle navigation</span>
						<span class="icon-bar"></span>
						<span class="icon-bar"></span>
						<span class="icon-bar"></span>
					  </button>
					<a class="navbar-brand" href="#">JFI Inventory System</a>
				</div>
				<div class="navbar-collapse collapse">
					<ul class="nav navbar-nav navbar-right">
						<li><a href="#" data-toggle="modal" data-target="#myModal">${sessionScope.userSession.user.userName } (${sessionScope.userSession.role.rank })</a></li>
						<li><a href="logout.htm">Logout</a></li>
					</ul>
				</div>
			</div>
		</div>

		<div class="container-fluid">
			<div class="row">
				<tiles:insertAttribute name="menu" />
				
				<!-- START Divider -->
				<tiles:insertAttribute name="content" />
				<!-- END Divider -->
				
			</div>
		</div>
		
		<div class="modal fade" id="myModal" tabindex="-1" role="dialog" aria-labelledby="myModalLabel" aria-hidden="true">
		  <div class="modal-dialog">
		    <div class="modal-content">
		      <div class="modal-header">
		        <button type="button" class="close" data-dismiss="modal" aria-hidden="true">&times;</button>
		        <h4 class="modal-title" id="myModalLabel">Change Password</h4>
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
		        <button type="button" class="btn btn-primary" onclick="modifyPassword()">Modify Password</button>
		      </div>
		    </div>
		  </div>
		</div>

		<!-- Bootstrap core JavaScript
		================================================== -->
		<!-- Placed at the end of the document so the pages load faster -->
		<script src="<c:url value='/js/jquery-2.1.1.min.js' />"></script>
		<script src="<c:url value='/js/bootstrap-3.1.1-dist/js/bootstrap.min.js'/>"></script>
		<script src="<c:url value='/js/bootstrap-3.1.1-dist/js/docs.min.js' />"></script>
	</body>
</html>
