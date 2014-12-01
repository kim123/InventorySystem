<%@page language="java" contentType="text/html" %>
<%@include file="../common/taglib.jsp"%>

<script type="text/javascript">
$(document).ready(function(){
	$('#categoryIdAdd').change(function(){
		var categoryId = $('#categoryIdAdd').val();
		/* var productId = $('#productIdAdd').val();
		var quantity = $('#quantityAdd').val(); */
		var select = document.getElementById('productIdAdd');
		select.options.length = 0;
		$.ajax({
			type: "POST",
			url: "getProductsBasedOnCategory.htm",
			data: "categoryId="+categoryId,
			dataType: "json",
			success: function(data){
				if (data.success) {
					var options = data.options;
					var records = options.split(";");
					for (var i = 0; i < records.length; i++) {
						var opt = records[i].split("/");
						if (opt.length==2) {
							var prodId = opt[0];
							var prodName = opt[1];
							select.options[select.options.length] = new Option(prodName, prodId);
						} else {
							select.options[select.options.length] = new Option('', '');
						}
						
					}
				}
			},
			error: function(errorThrown){
				alert("ERROR 500: "+errorThrown);
			}
		});
	});
	
	$('#addStocksButton').click(function(){
		var categoryId = $('#categoryIdAdd').val();
		var productId = $('#productIdAdd').val();
		var quantity = $('#quantityAdd').val();

		if (categoryId==null || categoryId=='') {
			document.getElementById('categoryIdAdd').focus();
			alert('Category must not be empty');
			return false;
		} else if (productId==null || productId=='') {
			document.getElementById('productIdAdd').focus();
			alert('Product must not be empty');
			return false;
		} else if (quantity==null || quantity=='') {
			document.getElementById('quantityAdd').focus();
			alert('Quantity must not be empty');
			return false;
		}
		
		var dataString = "inventory.productId="+productId+"&inventory.quantity="+quantity;
		//alert(dataString);
		$.ajax({
			type: "POST",
			url: "addStocksAction.htm",
			data: dataString,
			dataType: "json",
			success: function(data){
				if (data.success) {
					alert("<s:text name='message' />");
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
	
	$('.decimalInput').keypress(function(e){
		var charCode = (e.which) ? e.which : event.keyCode;
        if (charCode != 45 && (charCode != 46 || $(this).val().indexOf('.') != -1) && 
                (charCode < 48 || charCode > 57))
            return false;

        return true;
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
	
});

</script>

<div class="modal fade" id="addStocksModal" tabindex="-1" role="dialog" aria-labelledby="myModalLabel" aria-hidden="true">
	<div class="modal-dialog">
    <div class="modal-content">
      <div class="modal-header">
        <button type="button" class="close" data-dismiss="modal" aria-hidden="true">&times;</button>
        <h4 class="modal-title" id="myModalLabel">Add Inventory Stocks</h4>
      </div>
      <div class="modal-body">
       		<table border=0 align="center">
       			<tr>
       				<td>Category: </td>
       				<td><s:select list="categories" emptyOption="true" listKey="categoryId" listValue="categoryName" name="categoryId" id="categoryIdAdd" theme="simple" /></td>
       				<td>&nbsp;&nbsp;&nbsp;<span class="label label-danger" id="errorMsgUser">*</span></td>
       			</tr>
       			<tr>
       				<td>Product/s: </td>
       				<td><select id="productIdAdd"></select></td>
       				<td>&nbsp;&nbsp;&nbsp;<span class="label label-danger" id="errorMsgUser">*</span></td>
       			</tr>
       			<tr>
       				<td>Quantity: </td>
       				<td><input type="text" name="quantityAdd" id="quantityAdd" class="decimalInput" placeholder="Numbers only"/></td>
       				<td>&nbsp;&nbsp;&nbsp;<span class="label label-danger" id="errorMsgUser">*</span></td>
       			</tr>
       		</table>
      </div>
      <div class="modal-footer">
        <button type="button" class="btn btn-default" data-dismiss="modal">Close</button>
        <button type="button" class="btn btn-primary" id="addStocksButton">Add</button>
      </div>
    </div>
  </div>
</div>

<div class="col-sm-9 col-sm-offset-3 col-md-10 col-md-offset-2 main">	
	<h2 class="page-header">INVENTORY</h2>
	<c:if test="${fn:contains(sessionScope.userSession.role.permission, 'F2') }">
		<button class="btn btn-primary" data-toggle="modal" data-target="#addStocksModal">
		 	Add Stocks
		</button>
	</c:if>
	<br/><br/>
	<h4 class="sub-header">Inventory Logs</h4>
	<div class="table-responsive">
		<form action="inventory.htm" name="searchForm" id="searchForm" method="post" >
			<table border="0" >
				<tr>
					<td>Product Name: <input type="text" name="inventory.productName" id="inventory.productName"/></td>
					<td>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;</td>
					<td>Category: <s:select list="categories" emptyOption="true" listKey="categoryId" listValue="categoryName" name="category" id="category" theme="simple" /></td>
					<td>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;</td>
					<td>Total Stocks: <s:select list="operatorsTotal" emptyOption="true" listKey="operator" listValue="operator" name="operatorTotal" id="operatorTotal" theme="simple" />
						<input type="text" name="total" id="total" class="decimalInput" />
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
	<c:if test="${fn:contains(sessionScope.userSession.role.permission, 'F1') }">
		<div class="table-responsive" style="width:1100px; overflow: auto;">
			<br/>
			<table border=0 class="table table-striped" style="width:1100px;">
				<thead>
					<tr>
						<th style="width:10%;">Product</th>
						<th style="width:8%;">Category</th>
						<th style="width:9%;">Total</th>
						<th style="width:11%;">Created Date</th>
						<th style="width:11%;">Created By</th>
					</tr>
				</thead>
				<tbody>
					<c:forEach items="${page.contents }" var="query">
						<tr>
							<td>${query.productName }</td>
							<td>${query.categoryName }</td>
							<td>${query.total }</td>
							<td><fmt:formatDate type="both" value="${query.createdDate}" /></td>
							<td>${query.createdBy }</td>
						</tr>
					</c:forEach>
					<c:if test="${empty page.contents }">
						<tr>
							<td colspan="5" align="center">No records</td>
						</tr>
					</c:if>
					<c:if test="${not empty page.contents }">
						<tr>
							<td colspan="5" >
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
	<c:if test="${!(fn:contains(sessionScope.userSession.role.permission, 'F1')) }">
	<div class="row placeholders">
		<div class="col-xs-6 col-sm-3 placeholder">
			No access rights to proceed
		</div>
	</div>
	</c:if>
</div>