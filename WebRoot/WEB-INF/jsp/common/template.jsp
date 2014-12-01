<%@page language="java" contentType="text/html" %>
<%@include file="../common/taglib.jsp"%>
<!DOCTYPE html>
<html lang="en">
	<head>
		<title>JFI Inventory System</title>
		<script src="<c:url value='/js/jquery-2.1.1.min.js' />"></script>
		<script src="<c:url value='/js/jquery-2.1.1.js' />"></script>
		<script src="<c:url value='/js/bootstrap-3.1.1-dist/js/bootstrap.min.js'/>"></script>
		<script src="<c:url value='/js/bootstrap-3.1.1-dist/js/docs.min.js' />"></script>
		<script src="<c:url value='/js/jquery-ui.js' />"></script>
		<script src="<c:url value='/js/confirm-bootstrap.js' />"></script>
		<!-- Bootstrap core CSS -->
		<link href="<c:url value='/js/bootstrap-3.1.1-dist/css/bootstrap.min.css'/>" rel="stylesheet"/>
		<link href="<c:url value='/css/jquery-ui.css'/>" rel="stylesheet" />
		<!-- Custom styles for this template -->
		<link href="<c:url value='/css/dashboard.css' />" rel="stylesheet"/>
		<script type="text/javascript">			
			function promptMessage(){
				<c:if test="${not empty message}" >
					<c:if test="${message eq 'Success'}" >
						displayAlertSuccess();
					</c:if>
					<c:if test="${message ne 'Success'}" >
						displayAlert("<c:out value='${message}' />");
					</c:if>
				</c:if>
			}
			
			function displayAlert(message){
				$('#systemMessage').html(message);
				$('.alert-autocloseable-danger').show();
				$('.alert-autocloseable-danger').delay(5000).fadeOut( "slow", function() {
					// Animation complete.
					//$('#autoclosable-btn-danger').prop("disabled", false);
				});
			}
			
			function displayAlertSuccess(){
				$('.alert-autocloseable-success').show();
				$('.alert-autocloseable-success').delay(5000).fadeOut( "slow", function() {
					// Animation complete.
					//$('#autoclosable-btn-danger').prop("disabled", false);
				});
			}
			
			function displayModalAlert(id, message){
				$(id).html(message);
				$('.modalsOnly').show();
				$('.modalsOnly').delay(5000).fadeOut( "slow", function() {
				});
			}

			function modifyPassword(){
				var oldPassword = document.getElementById('oldPassword').value;
				var password = document.getElementById('password').value;
				var confirmpassword = document.getElementById('confirmpassword').value;
				var userid = document.getElementById('user.userId').value;
				
				if (oldPassword=='') {
					alert('<s:text name="enter.old.password" />');
					document.getElementById('oldPassword').focus();
					return false;
				}
				if (password=='') {
					alert('<s:text name="enter.new.password" />');
					document.getElementById('password').focus();
					return false;
				}
				if (confirmpassword=='') {
					alert('<s:text name="confirm.password" />');
					document.getElementById('confirmpassword').focus();
					return false;
				}
				if (confirmpassword!=password) {
					alert('<s:text name="confirmed.password.must.be.equal" />');
					document.getElementById('confirmpassword').focus();
					return false;
				}
				
				var dataString = 'user.userId='+userid+'&oldPassword='+oldPassword+'&user.password='+password;
				$.ajax({
					type: "POST",
					url: "modifyOwnPasswordAction.htm",
					data: dataString,
					dataType: "json",
					success: function(data){
						if (data.success) {
							alert('success');
			           		location.reload();
						} else {
							alert(data.message);
						}
					},
					error: function(errorThrown){
						alert("ERROR 500: "+errorThrown);
					}
				});	
			}
			
			function testing(){
				document.getElement('oldPassword').focus();
			}
			
			function onKeyEnter(e){
				if (window.event) {
					e = window.event;
				}
				if (e.keyCode==13) {
					document.getElementById('searchForm').submit();
				}
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
					<a class="navbar-brand" href="home.htm">JFI Inventory System</a>
				</div>
				<div class="navbar-collapse collapse">
					<ul class="nav navbar-nav navbar-right">
						<c:set var="now" value="<%=new java.util.Date()%>" />
						<li><a><fmt:formatDate type="date" value="${now}" /></a></li>
						<li><a href="#" data-toggle="modal" data-target="#myModal" onclick="testing()">${sessionScope.userSession.user.userName } (${sessionScope.userSession.role.rank })</a></li>
						<li><a href="logout.htm">Logout</a></li>
					</ul>
				</div>
			</div>
		</div>

		<div class="container-fluid">
			<div class="row">
				<div class="panel-body" align="center" style="padding: 0px !important;">
					<div class="alert alert-danger alert-autocloseable-danger" style="display:none">
						<span id="systemMessage"></span>
					</div>
				</div>
				<div class="panel-body" align="center" style="padding: 0px !important;">
					<div class="alert alert-success alert-autocloseable-success" style="display:none">
						Success!
					</div>
				</div>
				
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
		      		<%-- <s:form action="modifyOwnPasswordAction" method="post" theme="simple" id="submitForm"> --%>
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
		        		<input type="hidden" name="user.userId" id="user.userId" value="${sessionScope.userSession.user.userId }"/>
		        	</table>
		        	<%-- </s:form> --%>
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
	</body>
</html>
