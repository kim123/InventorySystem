<%@page language="java" contentType="text/html" %>
<%@include file="../common/taglib.jsp"%>
<script type="text/javascript">
$(document).ready(function(){
	$('#addProductButton').click(function(e){
		
		
	});
});
</script>

<div class="modal fade" id="addProductModal" tabindex="-1" role="dialog" aria-labelledby="myModalLabel" aria-hidden="true">
	<div class="modal-dialog">
    <div class="modal-content">
      <div class="modal-header">
        <button type="button" class="close" data-dismiss="modal" aria-hidden="true">&times;</button>
        <h4 class="modal-title" id="myModalLabel">Add Product (Prices)</h4>
      </div>
      <div class="modal-body">
       		<table border=0 align="center">
       			<tr>
       				<td>: </td>
       				<td><input type="text" name="category.name" id="category.name"/></td>
       				<td>&nbsp;&nbsp;&nbsp;<span class="label label-danger" id="errorMsgUser">*</span></td>
       			</tr>
       		</table>
      </div>
      <div class="modal-footer">
        <button type="button" class="btn btn-default" data-dismiss="modal">Close</button>
        <button type="button" class="btn btn-primary" id="addProductButton">Add</button>
      </div>
    </div>
  </div>
</div>

<div class="col-sm-9 col-sm-offset-3 col-md-10 col-md-offset-2 main">	
	<h2 class="page-header">Products</h2>
	<c:if test="${fn:contains(sessionScope.userSession.role.permission, 'D2') }">
	<button class="btn btn-primary" data-toggle="modal" data-target="#addProductModal">
	 	Add Product
	</button>
	</c:if>
	<br/><br/>
	<h4 class="sub-header">Product List</h4>
	<div class="table-responsive">
		<table class="table table-striped">
			<thead>
				<tr>
					<th>Product Name</th>
					<th>Category</th>
					<th>Status</th>
					<th>Updated Date</th>
					<th>Updated By</th>
					<th>Retail Price</th>
					<th>Maximum Selling Price</th>
					<th>Minimum Selling Price</th>
					<th>Price Updated Date</th>
					<th>Price Updated By</th>
				</tr>
			</thead>
			<tbody>
				<c:if test="${fn:contains(sessionScope.userSession.role.permission, 'D1') }">
				<c:forEach items="${page.contents }" var="query">
					<tr>
						<td>${query.productName }</td>
						<td>${query.category }</td>
						<td>
							<c:if test="${query.isHistory eq 0}">
								Not Archived
							</c:if>
							<c:if test="${query.isHistory eq 1}">
								<span style="color:red">Archived</span>
							</c:if>
						</td>
						<td><fmt:formatDate type="both" value="${query.productCreatedDate}" /></td>
						<td>${query.productCreatedBy }</td>
						<td><fmt:formatNumber type="number" pattern="###.###E0" value="${query.retailPrice}" /></td>
						<td><fmt:formatNumber type="number" pattern="###.###E0" value="${query.maxSellingPrice}" /></td>
						<td><fmt:formatNumber type="number" pattern="###.###E0" value="${query.minSellingPrice}" /></td>
						<td><fmt:formatDate type="both" value="${query.priceCreatedDate}" /></td>
						<td>${query.priceCreatedBy }</td>
					</tr>
				</c:forEach>
				</c:if>
				<c:if test="${!(fn:contains(sessionScope.userSession.role.permission, 'D1')) }">
					<tr>
						<td colspan="10">No access rights to proceed</td>
					</tr>
				</c:if>
			</tbody>
		</table>
	</div>
</div>
