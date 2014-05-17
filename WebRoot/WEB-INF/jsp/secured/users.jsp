<%@page language="java" contentType="text/html" %>
<%@include file="../common/taglib.jsp"%>

<div class="col-sm-9 col-sm-offset-3 col-md-10 col-md-offset-2 main">

	<h2 class="page-header">Users</h2>
	<div class="row placeholders">
		<div class="col-xs-6 col-sm-2 placeholder">
           <h4><a href="#">Add User</a></h4>
         </div>
	</div>
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
                  <th>Created Date</th>
                  <th>Created By</th>
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
	           				<a href="#">Role</a>
	           				<a href="#">Status</a>
	           				<a href="#">Password</a>
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