<%@page language="java" contentType="text/html" %>
<%@include file="../common/taglib.jsp"%>

<script type="text/javascript">
$(document).ready(function(){
	$('.ash').click(function(e){ //id="mr-${query.productId}-${query.productName}-${query.inventoryId}-${query.availableQuantity}"
		var productId = e.target.id.split("-")[1]; 
		var productName = e.target.id.split("-")[2];
		var inventoryId = e.target.id.split("-")[3];
		var availableQuantity = e.target.id.split("-")[4];
		$('#productid').val(productId);
		$('#productname').val(productName);
		$('#inventoryid').val(inventoryId);
		$('#availablequantity').val(availableQuantity);
	});	
	
	$('#addStocksOnHandButton').click(function(){
		var quantity = $('#quantityAdd').val();
		var inventoryid = $('#inventoryid').val();
		var productid = $('#productid').val();
		var availablequantity = $('#availablequantity').val();
		
		 if (quantity==null || quantity=='') {
			document.getElementById('quantityAdd').focus();
			alert('Quantity must not be empty');
			return false;
		} else if (quantity > availablequantity) {
			document.getElementById('quantityAdd').focus();
			alert('Quantity must not be more than the Available Quantity');
			return false;
		}
		 
		 var dataString = "stocksOnHand.productId="+productid+"&stocksOnHand.quantity="+quantity+"&stocksOnHand.inventoryId="+inventoryid;
		 $.ajax({
			type: "POST",
			url: "addStocksOnHandAction.htm",
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
		
	});	
	
	$('#searchCriteriaForm').click(function(){
		document.getElementById('searchForm').submit();
	});
	
	$('.paginateForm').click(function(e){
		var pageResult = e.target.id.split("-")[1];
		var pageSize = e.target.id.split("-")[2];
		var pageType = e.target.id.split("-")[3];
		$('#pageResultForm').val(pageResult);
		$('#pageSize').val(pageSize);
		$('#pageType').val(pageType);
		document.getElementById('searchForm').submit();
		
	});
	
	$('.decimalInput').keypress(function(e){
		var charCode = (e.which) ? e.which : event.keyCode;
        if (charCode != 45 && (charCode != 46 || $(this).val().indexOf('.') != -1) && 
                (charCode < 48 || charCode > 57))
            return false;

        return true;
	});	
});
</script>

<div class="modal fade" id="addStocksOnHandModal" tabindex="-1" role="dialog" aria-labelledby="myModalLabel" aria-hidden="true">
	<div class="modal-dialog">
    <div class="modal-content">
      <div class="modal-header">
        <button type="button" class="close" data-dismiss="modal" aria-hidden="true">&times;</button>
        <h4 class="modal-title" id="myModalLabel">Add Inventory Stocks</h4>
      </div>
      <div class="modal-body">
       		<table border=0 align="center">
       			<tr>
       				<td>Available Quantity: </td>
       				<td><input type="text" name="availablequantity" id="availablequantity" disabled="disabled"/></td>
       				<td></td>
       			</tr>
       			<tr>
       				<td>Product: </td>
       				<td><input type="text" name="productname" id="productname" disabled="disabled"/></td>
       				<td></td>
       			</tr>
       			<tr>
       				<td>Quantity: </td>
       				<td><input type="text" name="quantityAdd" id="quantityAdd" class="decimalInput" placeholder="Numbers only"/></td>
       				<td>&nbsp;&nbsp;&nbsp;<span class="label label-danger" id="errorMsgUser">*</span></td>
       			</tr>
       		</table>
       		<input type="hidden" name="inventoryid" id="inventoryid" value=""/>
       		<input type="hidden" name="productid" id="productid" value=""/>
      </div>
      <div class="modal-footer">
        <button type="button" class="btn btn-default" data-dismiss="modal">Close</button>
        <button type="button" class="btn btn-primary" id="addStocksOnHandButton">Add</button>
      </div>
    </div>
  </div>
</div>

<div class="col-sm-9 col-sm-offset-3 col-md-10 col-md-offset-2 main">	
	<h2 class="page-header">STOCKS ON HAND</h2>
	<h4 class="sub-header">Stocks On Hand Logs</h4>
	<div class="table-responsive">
		<form action="stocksonhand.htm" name="searchForm" id="searchForm" method="post" >
			<table border="0" >
				<tr>
					<td>Category: <s:select list="categories" emptyOption="true" listKey="categoryId" listValue="categoryName" name="stocksOnHand.category" id="category" theme="simple" /></td>
					<td>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;</td>
					<td>Product Name: <input type="text" name="stocksOnHand.productName" id="productName" /></td>
					<td>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;</td>
					<td>Quantity: <s:select list="operatorsTotal" emptyOption="true" listKey="operator" listValue="operator" name="operatorTotal" id="operatorTotal" theme="simple" />
						<input type="text" name="quantity" id="total" class="decimalInput" />
					</td>
					<td>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;</td>
					<td>Page Size: <input type="text" name="pageSize" id="pageSize" class="decimalInput" style="width:40px;"/></td>
					<td>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;</td>
					<td><button class="btn btn-primary" id="searchCriteriaForm">Search</button></td>
				</tr>
			</table>
			<input type="hidden" name="page.pageResult" id="pageResultForm" />
			<input type="hidden" name="pageType" id="pageType" />
		</form>
	</div>
	<c:if test="${fn:contains(sessionScope.userSession.role.permission, 'H2') }">
		<div class="table-responsive" style="width:1100px; overflow: auto;">
			<br/>
			<table border=0 class="table table-striped" style="width:1100px;">
				<thead>
					<tr>
						<th style="width:10%;">Product</th>
						<th style="width:8%;">Category</th>
						<th style="width:9%;">Quantity</th>
						<th style="width:9%;">Unit Sold</th>
						<!-- <th style="width:9%;">Unit Price</th> -->
						<th style="width:11%;">Total Amount</th>
						<th style="width:11%;">Updated Date</th>
						<th style="width:11%;">Updated By</th>
						<th style="width:9%;">Action</th>
					</tr>
				</thead>
				<tbody>
					<c:forEach items="${page.contents }" var="query">
						<tr>
							<td>${query.productName }</td>
							<td>${query.category }</td>
							<td>${query.quantity }</td>
							<td>${query.unitSold }</td>
							<td>
								<c:if test="${empty query.unitPrice }">
									-
								</c:if>
								<c:if test="${not empty query.unitPrice }">
									<c:out value="${query.unitPrice}" />
								</c:if>
							</td>
							<!-- <td></td> -->
							<td>
								<c:if test="${empty query.createdDate}">
									-
								</c:if>
								<c:if test="${not empty query.createdDate}">
									<fmt:formatDate type="both" value="${query.createdDate}" />
								</c:if>
							</td>
							<td>
								<c:if test="${empty query.createdDate}">
									-
								</c:if>
								<c:if test="${not empty query.createdBy}">
									${query.createdBy }
								</c:if>
							</td>
							<td>
								<c:if test="${fn:contains(sessionScope.userSession.role.permission, 'H1') }">
									<a href="#" class="ash" data-toggle="modal" data-target="#addStocksOnHandModal" id="mr-${query.productId}-${query.productName}-${query.inventoryId}-${query.availableQuantity}">
									 	Update
									</a>
								</c:if>
							</td>
						</tr>
					</c:forEach>
					<c:if test="${empty page.contents }">
						<tr>
							<td colspan="9" align="center">No records</td>
						</tr>
					</c:if>
					<c:if test="${not empty page.contents }">
						<tr>
							<td colspan="9" >
								<b>Total Records:</b> <c:out value="${page.totalSizeOfContents }" /> of <c:out value="${page.totalRecords }" />&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
								<c:if test="${page.pageResult!=0 }">
									<a href="#" class="paginateForm" id="prev-${page.pageResult }-${page.pageSize }-previous" >&laquo;</a>
								</c:if>
								<c:set var="ctrTotal" value="${page.pageResult+page.pageSize }" />
								<c:if test="${ctrTotal < page.totalRecords }">
									<a href="#" class="paginateForm" id="next-${page.pageResult }-${page.pageSize }-next" >&raquo;</a>
								</c:if>
							</td>
						</tr>
					</c:if>
				</tbody>
			</table>
		</div>
	</c:if>
	<c:if test="${!(fn:contains(sessionScope.userSession.role.permission, 'H2')) }">
	<div class="row placeholders">
		<div class="col-xs-6 col-sm-3 placeholder">
			No access rights to proceed
		</div>
	</div>
	</c:if>
</div>