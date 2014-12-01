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
			function submitForm(){
				var username = document.getElementById('user.userName').value;
				var password = document.getElementById('user.password').value;
				if (username=='') {
					displayAlert('Enter username');
					document.getElementById('user.userName').focus();
					return false;
				}
				if (password=='') {
					displayAlert('Enter password');
					document.getElementById('user.password').focus();
					return false;
				}
				document.getElementById('loginForm').submit();
			}
			
			function reset(){
				document.getElementById('alertUsername').style.display="none";
				document.getElementById('alertPassword').style.display="none";
				document.getElementById('user.password').value='';
				document.getElementById('user.userName').value='';
			}
			
			function promptMessage(){
				document.getElementById('user.userName').focus();
				<c:if test="${not empty message}" >
					displayAlert("<s:text name='%{getText(message)}' />");
					//alert("<s:text name='%{getText(message)}' />");
				</c:if>
			}
			
			function displayAlert(message){
				$('#systemMessage').html(message);
				$('.alert-autocloseable-danger').show();
				$('.alert-autocloseable-danger').delay(4000).fadeOut( "slow", function() {
					// Animation complete.
					//$('#autoclosable-btn-danger').prop("disabled", false);
				});
			}
						
			function onKeyEnter(e){
				if (window.event) {
					e = window.event;
				}
				if (e.keyCode==13) {
					submitForm();
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
					<a class="navbar-brand" href="home.htm"><s:text name="title" /></a>
				</div>
			</div>
		</div>

		<div class="container-fluid">
			<div class="row">
				<!-- START Divider -->
				<div class="main">
					<div class="panel panel-primary" style="width: 40%; margin:0;">
						<div class="panel-heading">
							<h4 class="panel-title"><s:text name="login.title" /></h4>
						</div>
						<div class="panel-body" align="center">
						<s:form action="loginAction" method="post" id="loginForm" theme="simple">
							<div class="alert alert-danger alert-autocloseable-danger" style="display:none">
								<span id="systemMessage"></span>
							</div>
						<table border="0">
							<tr>
								<td colspan="2">
									&nbsp;
								</td>
							</tr>
							<tr>
								<td>
									<b><s:text name="user.name" />:&nbsp;&nbsp;</b>
								</td>
								<td>
									<input type="text" id="user.userName" name="user.userName" maxlength="20" placeholder="Enter user name" onkeypress="onKeyEnter(event);"/>
								</td>
							</tr>
							<tr><td colspan="2">&nbsp;</td></tr>
							<tr>
								<td>
									<b><s:text name="password" />:&nbsp;&nbsp;</b>
								</td>
								<td>
									<input type="password" id="user.password" name="user.password" maxlength="20" placeholder="Enter password" onkeypress="onKeyEnter(event);"/>
								</td>
							</tr>
							<tr><td colspan="2">&nbsp;</td></tr>
							<tr><td colspan="2">&nbsp;</td></tr>
							<tr>
								<td align="center" colspan="2">
									<input type="button" class="btn btn-primary" value="Login" onclick="submitForm()"/>&nbsp;&nbsp;&nbsp;
									<input type="button" class="btn btn-primary" value="Reset" onclick="reset()"/>
								</td>
							</tr>
						</table>
						</s:form>
						</div>
					</div>
				</div>
				<!-- END Divider -->
				
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
