<%@page language="java" contentType="text/html" %>
<%@include file="../common/taglib.jsp"%>

<script type="text/javascript">
$(document).ready(function(){
	$("#datepicker").datepicker({
    	dateFormat: "yy-mm-dd"
    });
	
	$('#categoryIdAdd').change(function(){
		var categoryId = $('#categoryIdAdd').val();
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
	
	$('#productIdAdd').change(function(){
		var prodId = $('#productIdAdd').val(); //alert(prodId);
		//var prodName = $("#productIdAdd option[value="+prodId+"]").text(); 
		if (prodId!='') {
			//get available stocks of the product
			$.ajax({
				type: "POST",
				url: "getAvailableStocksBasedOnProductId.htm",
				data: "productId="+prodId,
				dataType: "json",
				success: function(data){
					if (data.success) {
						var options = data.stocks;
						var records = options.split("/");
						var onhandid = records[0].trim(); 
						var quantity = records[1].trim();
						$('#available').val(quantity);
						$('#dailyOnHandId').val(onhandid);
					}
				},
				error: function(errorThrown){
					alert("ERROR 500: "+errorThrown);
				}
			});
			
			// get prices pf the product
			var select = document.getElementById('unitPriceChoose');
			select.options.length = 0;
			select.options[select.options.length] = new Option('', '');
			$.ajax({
				type: "POST",
				url: "getPricesBasedOnProductName.htm",
				data: "productId="+prodId,
				dataType: "json",
				success: function(data){
					if (data.success) {
						var options = data.options;
						var records = options.split("/");
						var maxprice = records[0].trim();
						var minprice = records[1].trim();
						select.options[select.options.length] = new Option(maxprice, maxprice);
						select.options[select.options.length] = new Option(minprice, minprice);
					}
				},
				error: function(errorThrown){
					alert("ERROR 500: "+errorThrown);
				}
			});
		} 
	});

	
	$('#unitSold').keyup(function(e){
		var unitSold = $('#unitSold').val();
		if (unitSold=='') {
			document.getElementById('unitSold').focus();
			alert('Unit Sold must not be empty.');
			return false;
		}
		
		var available = $('#available').val();
		if (unitSold > available) {
			document.getElementById('unitSold').focus();
			alert('Unit Sold must not be greater than the Available Stocks.');
			return false;
		}
	});

	$('#addSalesButton').click(function(){
		var categoryId = $('#categoryIdAdd').val();
		var productId = $('#productIdAdd').val();
		var dailyOnHandId = $('#dailyOnHandId').val();
		var unitSold = $('#unitSold').val();
		var unitPriceChoose = $('#unitPriceChoose').val();
		var available = $('#available').val();
		
		if (categoryId=='') {
			document.getElementById('categoryIdAdd').focus();
			alert('Category must not be empty');
			return false;
		} else if (productId=='') {
			document.getElementById('productIdAdd').focus();
			alert('Product must not be empty');
			return false;
		} else if (unitSold=='') {
			document.getElementById('unitSold').focus();
			alert('Unit Sold must not be empty');
			return false;
		} else if (unitSold > available) {
			document.getElementById('unitSold').focus();
			alert('Unit Sold must not be greater than the Available Stocks.');
			return false;
		} else if (unitPriceChoose=='') {
			document.getElementById('unitPriceChoose').focus();
			alert('Unit Price must not be empty');
			return false;
		}

		var dataString = "sales.dailyOnHandId="+dailyOnHandId+"&sales.productId="+productId+"&sales.unitSold="+unitSold+"&sales.unitPrice="+unitPriceChoose;
		//alert(dataString);
		$.ajax({
			type: "POST",
			url: "addDailySalesAction.htm",
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
	
	$('#addExpenseButton').click(function(){
		var expensename = $('#expensename').val();
		var amountexpense = $('#amountexpense').val();
		
		if (expensename=='') {
			document.getElementById('expensename').focus();
			alert('Expense must not be empty');
			return false;
		} else if (amountexpense=='') {
			document.getElementById('amountexpense').focus();
			alert('Amount must not be empty');
			return false;
		}
		
		var dataString = 'expense.name='+expensename+'&expense.amount='+amountexpense;
		$.ajax({
			type: "POST",
			url: "addExpensesAction.htm",
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

<div class="modal fade" id="addExpensesModal" tabindex="-1" role="dialog" aria-labelledby="myModalLabel" aria-hidden="true">
	<div class="modal-dialog">
    <div class="modal-content">
      <div class="modal-header">
        <button type="button" class="close" data-dismiss="modal" aria-hidden="true">&times;</button>
        <h4 class="modal-title" id="myModalLabel">Add Expense</h4>
      </div>
      <div class="modal-body">
       		<table border=0 align="center">
       			<tr>
       				<td>Expense: </td>
       				<td><input type="text" name="expensename" id="expensename" /></td>
       				<td>&nbsp;&nbsp;&nbsp;<span class="label label-danger" id="errorMsgUser">*</span></td>
       			</tr>
       			<tr>
       				<td>Amount: </td>
       				<td><input type="text" name="amountexpense" id="amountexpense" class="decimalInput" placeholder="Numbers/Decimal only" style="width:150px" maxlength="5" /></td>
       				<td>&nbsp;&nbsp;&nbsp;<span class="label label-danger" id="errorMsgUser">*</span></td>
       			</tr>
       		</table>
       		
      </div>
      <div class="modal-footer">
        <button type="button" class="btn btn-default" data-dismiss="modal">Close</button>
        <button type="button" class="btn btn-primary" id="addExpenseButton">Add</button>
      </div>
    </div>
  </div>
</div>

<div class="modal fade" id="addDailySalesModal" tabindex="-1" role="dialog" aria-labelledby="myModalLabel" aria-hidden="true">
	<div class="modal-dialog">
    <div class="modal-content">
      <div class="modal-header">
        <button type="button" class="close" data-dismiss="modal" aria-hidden="true">&times;</button>
        <h4 class="modal-title" id="myModalLabel">Add Daily Sales</h4>
      </div>
      <div class="modal-body">
       		<table border=0 align="center">
       			<tr>
       				<td>Category: </td>
       				<td><s:select list="categories" emptyOption="true" listKey="categoryId" listValue="categoryName" name="categoryId" id="categoryIdAdd" theme="simple" style="width:150px"/></td>
       				<td>&nbsp;&nbsp;&nbsp;<span class="label label-danger" id="errorMsgUser">*</span></td>
       			</tr>
       			<tr>
       				<td>Product: </td>
       				<td><select id="productIdAdd" style="width:150px"></select></td>
       				<td>&nbsp;&nbsp;&nbsp;<span class="label label-danger" id="errorMsgUser">*</span></td>
       			</tr>
       			<tr>
       				<td>Available Stocks: </td>
       				<td><input type="text" name="available" id="available" value="" disabled="disabled" style="width:150px"/></td>
       				<td></td>
       			</tr>
       			<tr>
       				<td>Unit Sold: </td>
       				<td><input type="text" name="unitSold" id="unitSold" class="decimalInput" placeholder="Numbers only" style="width:150px" maxlength="5" /></td>
       				<td>&nbsp;&nbsp;&nbsp;<span class="label label-danger" id="errorMsgUser">*</span></td>
       			</tr>
       			<tr>
       				<td>Unit Price: </td>
       				<td><select id="unitPriceChoose" style="width:150px"></select></td>
       				<td>&nbsp;&nbsp;&nbsp;<span class="label label-danger" id="errorMsgUser">*</span></td>
       			</tr>
       		</table>
       		<input type="hidden" name="dailyOnHandId" id="dailyOnHandId" value=""/>
      </div>
      <div class="modal-footer">
        <button type="button" class="btn btn-default" data-dismiss="modal">Close</button>
        <button type="button" class="btn btn-primary" id="addSalesButton">Add</button>
      </div>
    </div>
  </div>
</div>

<div class="col-sm-9 col-sm-offset-3 col-md-10 col-md-offset-2 main">	
	<h2 class="page-header">DAILY SALES AND EXPENSES</h2>
	<c:if test="${fn:contains(sessionScope.userSession.role.permission, 'I1') }">
		<button class="btn btn-primary" data-toggle="modal" data-target="#addDailySalesModal">
		 	Add Daily Sales
		</button>
	</c:if>
	<c:if test="${fn:contains(sessionScope.userSession.role.permission, 'I2') }">
		<button class="btn btn-primary" data-toggle="modal" data-target="#addExpensesModal">
		 	Add Expenses
		</button>
	</c:if>
	<br/><br/>
	
	<div class="table-responsive">
		<form action="dailySalesExpenses.htm" name="searchForm" id="searchForm" method="post" >
			Date: <input type="text" name="searchDate" id="datepicker" value="${searchDate }">  &nbsp;&nbsp;&nbsp;
			Page Size: <input type="text" name="pageSize" id="pageSize" class="decimalInput" style="width:40px;"/>
					&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
			<button class="btn btn-primary" id="searchCriteriaForm">Search</button>
		</form>
	</div>
	<br/>
	<div class="table-responsive" style="width:1100px; overflow: auto;">
		<c:if test="${fn:contains(sessionScope.userSession.role.permission, 'I3') }">
			<ul id="myTab" class="nav nav-tabs" role="tablist">
		      <li class="active"><a href="#sales" role="tab" data-toggle="tab">SALES</a></li>
		      <li class=""><a href="#expenses" role="tab" data-toggle="tab">EXPENSES</a></li>
		    </ul>
	    </c:if>
	    <c:if test="${!(fn:contains(sessionScope.userSession.role.permission, 'I3')) }">
	    	<div class="row placeholders">
				<div class="col-xs-6 col-sm-3 placeholder">
					No access rights to proceed
				</div>
			</div>
	    </c:if>
	    <div id="myTabContent" class="tab-content">
	    	<!-- tab for sales -->
	    	<div class="tab-pane fade active in" id="sales">
	    		<table border=0 class="table table-striped" style="width:1100px;">
	    			<thead>
						<tr>
							<th style="width:10%;">Product</th>
							<th style="width:8%;">Category</th>
							<th style="width:9%;">Unit Sold</th>
							<th style="width:9%;">Unit Price</th>
							<th style="width:9%;">Total Amount</th>
							<th style="width:11%;">Created Date</th>
							<th style="width:11%;">Created By</th>
						</tr>
					</thead>
					<tbody>
						<c:forEach items="${page.contents }" var="query">
							<tr>
								<td>${query.productName }</td>
								<td>${query.category }</td>
								<td>${query.unitSold }</td>
								<td>&nbsp;&nbsp;Php&nbsp;<fmt:formatNumber type="number" pattern="#,##0.00" value="${query.unitPrice}" /></td>
								<td>&nbsp;&nbsp;Php&nbsp;<fmt:formatNumber type="number" pattern="#,##0.00" value="${query.totalAmount}" /></td>
								<td><fmt:formatDate type="both" value="${query.createdDate}" /></td>
								<td>${query.createdBy }</td>
							</tr>
						</c:forEach>
						<c:if test="${empty page.contents }">
							<tr>
								<td colspan="7" align="center">No records</td>
							</tr>
						</c:if>
						<c:if test="${not empty page.contents }">
							<tr>
								<td colspan="7" >
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
	    	<!-- tab for expenses -->
	    	<div class="tab-pane fade" id="expenses">
	    		<table border=0 class="table table-striped" style="width:1100px;">
	    			<thead>
						<tr>
							<th style="width:10%;">Expense</th>
							<th style="width:8%;">Amount</th>
							<th style="width:11%;">Created Date</th>
							<th style="width:11%;">Created By</th>
						</tr>
					</thead>
					<tbody>
						<c:forEach items="${pageExpense.contents }" var="query">
							<tr>
								<td>${query.name }</td>
								<td>${query.amount }</td>
								<td><fmt:formatDate type="both" value="${query.createdDate}" /></td>
								<td>${query.createdBy }</td>
							</tr>
						</c:forEach>
						<c:if test="${empty pageExpense.contents }">
							<tr>
								<td colspan="4" align="center">No records</td>
							</tr>
						</c:if>
						<c:if test="${not empty pageExpense.contents }">
							<tr>
								<td colspan="4" >
									<b>Total Records:</b> <c:out value="${pageExpense.totalSizeOfContents }" /> of <c:out value="${pageExpense.totalRecords }" />&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
									<c:if test="${pageExpense.pageResult!=0 }">
										<a href="#" class="paginateForm" id="prev-${pageExpense.pageResult }-${pageExpense.pageSize }-previous" >&laquo;</a>
									</c:if>
									<c:set var="ctrTotal" value="${pageExpense.pageResult+pageExpense.pageSize }" />
									<c:if test="${ctrTotal < pageExpense.totalRecords }">
										<a href="#" class="paginateForm" id="next-${pageExpense.pageResult }-${pageExpense.pageSize }-next" >&raquo;</a>
									</c:if>
								</td>
							</tr>
						</c:if>
					</tbody>
	    		</table>
	    	</div>
	    </div>
	</div>
</div>