<%@page language="java" contentType="text/html" %>
<%@include file="../common/taglib.jsp"%>
<script type="text/javascript">
$(document).ready(function(){
	
	$('.decimalInput').keypress(function(e){
		var keyCode = e.which;
		//190 is the key code of decimal if you dont want decimals remove this condition keyCode != 190
        if (keyCode != 8 && keyCode != 9 && keyCode != 13 && keyCode != 37 && keyCode != 38 && keyCode != 39 && 
        		keyCode != 40 && keyCode != 46 && keyCode != 110 && keyCode != 190) {
            if (keyCode < 48) {
                e.preventDefault();
            } else if (keyCode > 57 && keyCode < 96) {
                e.preventDefault();
            } else if (keyCode > 105) {
                e.preventDefault();
            }
        }
	});
	
	function onKeyDownNumbersDecimalOnly(e){
		alert(e);
		 /* var keyCode = e.which; // Capture the event
			alert(keyCode);
	        //190 is the key code of decimal if you dont want decimals remove this condition keyCode != 190
	        if (keyCode != 8 && keyCode != 9 && keyCode != 13 && keyCode != 37 && keyCode != 38 && keyCode != 39 && 
	        		keyCode != 40 && keyCode != 46 && keyCode != 110 && keyCode != 190) {
	            if (keyCode < 48) {
	                e.preventDefault();
	            } else if (keyCode > 57 && keyCode < 96) {
	                e.preventDefault();
	            } else if (keyCode > 105) {
	                e.preventDefault();
	            }
	        } */
	}
	
	$('#addProductButton').click(function(e){
		var prodName = $('#productName').val();
		var category = $('#category').val();
		var retailprice = $('#retailprice').val();
		var maxsellingprice = $('#maxsellingprice').val();
		var minsellingprice = $('#minsellingprice').val();
		
		if (prodName=='') {
			alert('Enter product name');
			document.getElementById('productName').focus();
			return false;
		} else if (category=='') {
			alert('Choose category for '+prodName);
			document.getElementById('category').focus();
			return false;
		} else if (retailprice=='') {
			alert('Enter retail price');
			document.getElementById('retailprice').focus();
			return false;
		} else if (maxsellingprice=='') {
			alert('Enter maximum retail price');
			document.getElementById('maxsellingprice').focus();
			return false;
		}
		
		if (minsellingprice=='') {
			minsellingprice = '0.00';
		}
		
		var dataString = 'productPrice.productName='+prodName+'&productPrice.category='+category+
							'&productPrice.retailPrice='+retailprice+'&productPrice.maxSellingPrice='+maxsellingprice+
							'&productPrice.minSellingPrice='+minsellingprice; 
		$.ajax({
			type: "POST",
			url: "addProductPriceAction.htm",
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
				alert("Error 500: "+errorThrown);
			}
		});
	});
	
	$('.ma').click(function(e){
		var productId = e.target.id.split("-")[1];
		var productName = e.target.id.split("-")[2];
		
		$('.productNameArchive').val(productName);
		$('.productIdArchive').val(productId);
	});
	
	$('.mp').click(function(e){
		var productId = e.target.id.split("-")[1];
		var productName = e.target.id.split("-")[2];
		var retailPrice = e.target.id.split("-")[3];
		var maxPrice = e.target.id.split("-")[4];
		var minPrice = e.target.id.split("-")[5];
		
		$('.productNameArchive').val(productName);
		$('.productIdArchive').val(productId);
		$('#retailpriceArchive').val(retailPrice);
		$('#maxsellingpriceArchive').val(maxPrice);
		$('#minsellingpriceArchive').val(minPrice);
	});
	
	$('#archiveProductButton').click(function(){
		var historystatus = $('#isHistoryArchive').val();
		var productId = $('.productIdArchive').val();
		if (historystatus=='') {
			alert('Archived status must not be empty.');
			document.getElementById('productIdArchive').focus();
			return false;
		}
		var dataString = "productPrice.productId="+productId+"&productPrice.isHistory="+historystatus;
		$.ajax({
			type: "POST",
			url: "archiveProductAction.htm",
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
				alert("Error 500: "+errorThrown);
			}
		});
	});
	
	$('#modifyPriceButton').click(function(){
		var productId = $('.productIdArchive').val();
		var retailprice = $('#retailpriceArchive').val();
		var maxsellingprice = $('#maxsellingpriceArchive').val();
		var minsellingprice = $('#minsellingpriceArchive').val();
		
		if (retailprice=='') {
			alert('Enter retail price');
			document.getElementById('retailpriceArchive').focus();
			return false;
		} else if (maxsellingprice=='') {
			alert('Enter maximum retail price');
			document.getElementById('maxsellingpriceArchive').focus();
			return false;
		}
		if (minsellingprice=='') {
			minsellingprice = '0.00';
		}
		
		var dataString = 'productPrice.productId='+productId+'&productPrice.retailPrice='+retailprice+'&productPrice.maxSellingPrice='+maxsellingprice+
							'&productPrice.minSellingPrice='+minsellingprice;
		$.ajax({
			type: "POST",
			url: "modifyPricesAction.htm",
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
				alert("Error 500: "+errorThrown);
			}
		});
	});
	
	$('#searchCriteriaForm').click(function(){
		
		document.getElementById('searchForm').submit();
	});
	
	function submitFormBasedOnPageNum(pageResult, pageNumber){
		alert("pageResult: "+pageResult+", pageNumber: "+pageNumber);
		$('#pageNumberForm').val(pageNumber);
		$('#pageResultForm').val(pageResult);
	}
	
	function displayPreviousPageNumbers(beginIndex){
		alert("beginIndex"+beginIndex);
		$('#page.beginIndex').val(beginIndex);
		$('#page.endIndex').val(pageResult);
	}
	
	function displayMorePafeNumbers(endIndex){
		alert("endIndex"+endIndex);
		$('#page.endIndex').val(endIndex);
	}
	
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
       				<td>Product Name: </td>
       				<td><input type="text" name="productName" id="productName" placeholder="Enter product name"/></td>
       				<td>&nbsp;&nbsp;&nbsp;<span class="label label-danger" id="errorMsgUser">*</span></td>
       			</tr>
       			<tr>
       				<td>Category: </td>
       				<td><s:select list="categories" emptyOption="true" listKey="categoryId" listValue="categoryName" name="category" id="category" theme="simple" style="width: 155px" /></td>
       				<td>&nbsp;&nbsp;&nbsp;<span class="label label-danger" id="errorMsgUser">*</span></td>
       			</tr> 
       			<tr>
       				<td>Retail Price: </td>
       				<td><input type="text" name="retailprice" id="retailprice" placeholder="Numbers/decimal only" class="decimalInput" /></td>
       				<td>&nbsp;&nbsp;&nbsp;<span class="label label-danger" id="errorMsgUser">*</span></td>
       			</tr>
       			<tr>
       				<td>Maximum Selling Price: </td>
       				<td><input type="text" name="maxsellingprice" id="maxsellingprice" placeholder="Numbers/decimal only" class="decimalInput" /></td>
       				<td>&nbsp;&nbsp;&nbsp;<span class="label label-danger" id="errorMsgUser">*</span></td>
       			</tr>
       			<tr>
       				<td>Minimum Selling Price: </td>
       				<td><input type="text" name="minsellingprice" id="minsellingprice" placeholder="Numbers/decimal only" class="decimalInput"  /></td>
       				<td>&nbsp;&nbsp;&nbsp;</td>
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

<div class="modal fade" id="archiveProductModal" tabindex="-1" role="dialog" aria-labelledby="myModalLabel" aria-hidden="true">
	<div class="modal-dialog">
    <div class="modal-content">
      <div class="modal-header">
        <button type="button" class="close" data-dismiss="modal" aria-hidden="true">&times;</button>
        <h4 class="modal-title" id="myModalLabel">Archive Product</h4>
      </div>
      <div class="modal-body">
       		<table border=0 align="center">
       			<tr>
       				<td>Product Name: </td>
       				<td><input type="text" name="productName" id="productNameArchive" class="productNameArchive" disabled="disabled"/></td>
       				<td>&nbsp;&nbsp;&nbsp;<span class="label label-danger" id="errorMsgUser">*</span></td>
       			</tr>
       			<tr>
       				<td>Archive Status: </td>
       				<td><s:select list="products" emptyOption="true" listKey="code" listValue="description" name="isHistory" id="isHistoryArchive" theme="simple" style="width: 155px"/></td>
       				<td>&nbsp;&nbsp;&nbsp;<span class="label label-danger" id="errorMsgUser">*</span></td>
       			</tr>
       		</table>
       		<input type="hidden" id="productIdArchive" class="productIdArchive" value="" />
      </div>
      <div class="modal-footer">
        <button type="button" class="btn btn-default" data-dismiss="modal">Close</button>
        <button type="button" class="btn btn-primary" id="archiveProductButton">Update</button>
      </div>
    </div>
  </div>
</div>

<div class="modal fade" id="modifyPriceModal" tabindex="-1" role="dialog" aria-labelledby="myModalLabel" aria-hidden="true">
	<div class="modal-dialog">
    <div class="modal-content">
      <div class="modal-header">
        <button type="button" class="close" data-dismiss="modal" aria-hidden="true">&times;</button>
        <h4 class="modal-title" id="myModalLabel">Update Prices</h4>
      </div>
      <div class="modal-body">
       		<table border=0 align="center">
       			<tr>
       				<td>Product Name: </td>
       				<td><input type="text" name="productName" id="productNameArchive" class="productNameArchive" disabled="disabled"/></td>
       				<td>&nbsp;&nbsp;&nbsp;<span class="label label-danger" id="errorMsgUser">*</span></td>
       			</tr>
       			<tr>
       				<td>Retail Price: </td>
       				<td><input type="text" name="retailprice" id="retailpriceArchive" placeholder="Numbers/decimal only" class="decimalInput" /></td>
       				<td>&nbsp;&nbsp;&nbsp;<span class="label label-danger" id="errorMsgUser">*</span></td>
       			</tr>
       			<tr>
       				<td>Maximum Selling Price: </td>
       				<td><input type="text" name="maxsellingprice" id="maxsellingpriceArchive" placeholder="Numbers/decimal only" class="decimalInput" /></td>
       				<td>&nbsp;&nbsp;&nbsp;<span class="label label-danger" id="errorMsgUser">*</span></td>
       			</tr>
       			<tr>
       				<td>Minimum Selling Price: </td>
       				<td><input type="text" name="minsellingprice" id="minsellingpriceArchive" placeholder="Numbers/decimal only" class="decimalInput"  /></td>
       				<td>&nbsp;&nbsp;&nbsp;</td>
       			</tr>
       		</table>
       		<input type="hidden" id="productIdArchive" class="productIdArchive" value="" />
      </div>
      <div class="modal-footer">
        <button type="button" class="btn btn-default" data-dismiss="modal">Close</button>
        <button type="button" class="btn btn-primary" id="modifyPriceButton">Update</button>
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
		<s:form action="/product.htm" name="searchForm" id="searchForm" method="post" >
		<table border="0" >
			<tr>
				<td style="width:300px;">Product Name: <input type="text" name="productPrice.productName" id="productPrice.productName" /></td>
				<td>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;</td>
				<td>Category: <s:select list="categories" emptyOption="true" listKey="categoryId" listValue="categoryName" name="productPrice.category" id="productPrice.category" theme="simple" /></td>
				<td>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;</td>
				<td>Archived: <s:select list="products" emptyOption="true" listKey="code" listValue="description" name="isHistory" id="productPrice.isHistory" theme="simple" /></td>
			</tr>
			<tr>
				<td>Retail Price: <s:select list="operatorsRetailPrice" emptyOption="true" listKey="operator" listValue="operator" name="retailPriceOperator" id="retailPriceOperator" theme="simple" />
					<input type="text" name="productPrice.retailPrice" id="productPrice.retailPrice" class="decimalInput"/>
				</td>
				<td>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;</td>
				<td>Maximum Selling Price <s:select list="operatorsMaxSellingPrice" emptyOption="true" listKey="operator" listValue="operator" name="maxSellingPriceOperator" id="maxSellingPriceOperator" theme="simple" />
					<input type="text" name="productPrice.maxSellingPrice" id="productPrice.maxSellingPrice" class="decimalInput" />
				</td>
				<td>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;</td>
				<td>Minimum Selling Price: <s:select list="operatorsMinSellingPrice" emptyOption="true" listKey="operator" listValue="operator" name="minSellingPriceOperator" id="minSellingPriceOperator" theme="simple" />
					<input type="text" name="productPrice.minSellingPrice" id="productPrice.minSellingPrice" class="decimalInput"/>
				</td>
			</tr>
			<tr>
				<td>Page Size: <input type="text" name="pageSize" id="pageSize" class="decimalInput"/>
				</td>
				<td>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;</td>
				<td><button class="btn btn-primary" id="searchCriteriaForm">Search</button></td>
				<td></td>
				<td></td>
			</tr>
		</table>
			<%-- <input type="hidden" name="pageNum" id="pageNumberForm" value="" />
			<input type="hidden" name="page.pageResult" id="pageResultForm" value="" />
			<input type="hidden" name="page.beginIndex" id="page.beginIndex" value="" />
			<input type="hidden" name="page.endIndex" id="page.endIndex" value="" />
			<c:if test="${not empty page.pages }">
				<input type="hidden" name="page.pages" value="${page.pages }" />
			</c:if> --%>
		</s:form>
		<br/>
	</div>
	<c:if test="${fn:contains(sessionScope.userSession.role.permission, 'D1') }">
	<div class="table-responsive" style="width:1100px; overflow: auto;">
		<table border=1 class="table table-striped" style="width:1300px;">
			<thead>
				<tr>
					<th style="width:10%;">Product</th>
					<th>Category</th>
					<th>Status</th>
					<th style="width:9%;">Updated Date</th>
					<th style="width:9%;">Updated By</th>
					<th style="width:9%;">Retail Price</th>
					<th style="width:11%;">Maximum Selling Price</th>
					<th style="width:11%;">Minimum Selling Price</th>
					<th style="width:11%;">Price Updated Date</th>
					<th style="width:11%;">Price Updated By</th>
					<th>Action</th>
				</tr>
			</thead>
			<tbody>
				<c:if test="${fn:contains(sessionScope.userSession.role.permission, 'D1') }">
				<c:forEach items="${page.contents }" var="query">
					<tr>
						<td >${query.productName }</td>
						<td>${query.category }</td>
						<td style="width:8%;">
							<c:if test="${query.isHistory eq 0}">
								Not Archived
							</c:if>
							<c:if test="${query.isHistory eq 1}">
								<span style="color:red">Archived</span>
							</c:if>
						</td>
						<td><fmt:formatDate type="both" value="${query.productCreatedDate}" /></td>
						<td>${query.productCreatedBy }</td>
						<td><fmt:formatNumber type="number" pattern="#,##0.00" value="${query.retailPrice}" /></td>
						<td><fmt:formatNumber type="number" pattern="#,##0.00" value="${query.maxSellingPrice}" /></td>
						<td><fmt:formatNumber type="number" pattern="#,##0.00" value="${query.minSellingPrice}" /></td>
						<td><fmt:formatDate type="both" value="${query.priceCreatedDate}" /></td>
						<td>${query.priceCreatedBy }</td>
						<td style="width:55%;">
							<c:if test="${fn:contains(sessionScope.userSession.role.permission, 'D3') }">
	           					<a href="#" data-toggle="modal" data-target="#modifyPriceModal" class="mp" id="mp-${query.productId}-${query.productName}-${query.retailPrice}-${query.maxSellingPrice}-${query.minSellingPrice}">Price</a> |
	           				</c:if>
	           				<c:if test="${fn:contains(sessionScope.userSession.role.permission, 'D4') }">
	           					<a href="#" data-toggle="modal" data-target="#archiveProductModal" class="ma" id="mp-${query.productId}-${query.productName}-${query.isHistory}">Archive</a>
	           				</c:if>
						</td>
					</tr>
				</c:forEach>
				<c:if test="${empty page.contents }">
					<tr>
						<td colspan="11" align="center">No records</td>
					</tr>
				</c:if>
					<c:set var="pageNumber" value="${page.pageNumber }" />
					<tr>
						<td colspan="11" align="center">&nbsp;<c:out value="${page.pageNumber }" /></td>
					</tr>
					<tr>
						<td class="pagination" colspan="1" >Total: <c:out value="${page.totalRecords }" /></td>
						<td colspan="10" align="left" >  
							<ul class="pagination">
								<c:if test="${page.beginIndex >= 5}">
									<li><a href="displayPreviousPageNumbers('${page.beginIndex }')"><span>&laquo;</span></a></li>
								</c:if>
								<c:forEach items="${page.pages }" var="pageResult" begin="${page.beginIndex }" end="${page.endIndex }">
									<li <c:if test="${pageNumber==page.pageNumber }" >class="active" </c:if> ><a href="#" onclick="submitFormBasedOnPageNum('${pageResult}','${pageNumber }')"><c:out value="${pageNumber }" /> <c:if test="${pageNumber==page.pageNumber }" ><span class="sr-only">(current)</span></c:if></a></li>
									<c:set var="pageNumber" value="${pageNumber+1 }" />
								</c:forEach>
								<c:if test="${(page.pagesLength-1)==page.endIndex && page.endIndex <= 5 }">
									<li><a href="displayMorePafeNumbers('${page.endIndex }')"><span>&raquo;</span></a></li>
								</c:if>
							</ul>
						</td>
					</tr>
				</c:if>
				<c:if test="${!(fn:contains(sessionScope.userSession.role.permission, 'D1')) }">
					<tr>
						<td colspan="11" align="center">No access rights to proceed</td>
					</tr>
				</c:if>
			</tbody>
		</table>
	</div>
	</c:if>
	<c:if test="${!(fn:contains(sessionScope.userSession.role.permission, 'D1')) }">
	<div class="row placeholders">
		<div class="col-xs-6 col-sm-3 placeholder">
			No access rights to proceed
		</div>
	</div>
	</c:if>
</div>
