<%@page language="java" contentType="text/html" %>
<%@include file="../common/taglib.jsp"%>
<script type="text/javascript">
$(document).ready(function(){
	$('#addCategoryButton').click(function(e){
		var category = document.getElementById('category.name').value;
		if (category=='') {
			alert('category.name.must.not.empty');
			document.getElementById('category.name').focus();
			return false;
		}
		var dataString = "category.categoryName="+category;
		$.ajax({
			type: "POST",
			url: "addCategoryAction.htm",
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
});
</script>

<div class="modal fade" id="addCategoryModal" tabindex="-1" role="dialog" aria-labelledby="myModalLabel" aria-hidden="true">
	<div class="modal-dialog">
    <div class="modal-content">
      <div class="modal-header">
        <button type="button" class="close" data-dismiss="modal" aria-hidden="true">&times;</button>
        <h4 class="modal-title" id="myModalLabel">Add Category</h4>
      </div>
      <div class="modal-body">
       		<table border=0 align="center">
       			<tr>
       				<td>Category: </td>
       				<td><input type="text" name="category.name" id="category.name"/></td>
       				<td>&nbsp;&nbsp;&nbsp;<span class="label label-danger" id="errorMsgUser">*</span></td>
       			</tr>
       		</table>
      </div>
      <div class="modal-footer">
        <button type="button" class="btn btn-default" data-dismiss="modal">Close</button>
        <button type="button" class="btn btn-primary" id="addCategoryButton">Add</button>
      </div>
    </div>
  </div>
</div>

<div class="col-sm-9 col-sm-offset-3 col-md-10 col-md-offset-2 main">	
	<h2 class="page-header">Categories</h2>
	<c:if test="${fn:contains(sessionScope.userSession.role.permission, 'C2') }">
	<button class="btn btn-primary" data-toggle="modal" data-target="#addCategoryModal">
	 	Add Category
	</button>
	</c:if>
	<br/><br/>
	<h4 class="sub-header">Category List</h4>
	<div class="table-responsive">
		<table class="table table-striped">
			<thead>
				<tr>
					<th>ID</th>
					<th>Category</th>
					<th>Created Date</th>
					<th>Created By</th>
				</tr>
			</thead>
			<tbody>
				<c:if test="${fn:contains(sessionScope.userSession.role.permission, 'C1') }">
				<c:forEach items="${page.contents }" var="query">
					<tr>
						<td>${query.categoryId }</td>
						<td>${query.categoryName }</td>
						<td><fmt:formatDate type="both" value="${query.createdDate}" /></td>
						<td>${query.createdBy }</td>
					</tr>
				</c:forEach>
				</c:if>
				<c:if test="${!(fn:contains(sessionScope.userSession.role.permission, 'C1')) }">
					<tr>
						<th colspan="4">No access rights to proceed</th>
					</tr>
				</c:if>
			</tbody>
		</table>
	</div>
</div>