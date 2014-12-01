<%@page language="java" contentType="text/html" %>
<%@include file="../common/taglib.jsp"%>

<script type="text/javascript">
$(document).ready(function(){
	$("#datepicker").datepicker({
		dateFormat: "yy-mm-dd"
	});
	
	$('.decimalInput').keypress(function(e){
		var charCode = (e.which) ? e.which : event.keyCode;
        if (charCode != 45 && (charCode != 46 || $(this).val().indexOf('.') != -1) && 
                (charCode < 48 || charCode > 57))
            return false;

        return true;
	});	

	$('#addEloadPriceButton').click(function(){
		var productId = $('#productId').val();
		var eloadPrice = $('#eloadPrice').val();
		var retailPrice = $('#retailPrice').val();
		var markupPrice = $('#markupPrice').val();
		
		if (productId=='') {
			document.getElementById('productId').focus();
			displayModalAlert('#modalMessage','E-LOAD Product must not be empty');
			return false;
		} else if (eloadPrice=='') {
			document.getElementById('eloadPrice').focus();
			displayModalAlert('#modalMessage','E-LOAD Price must not be empty');
			return false;
		} else if (retailPrice=='') {
			document.getElementById('retailPrice').focus();
			displayModalAlert('#modalMessage','Retail Price must not be empty');
			return false;
		} else if (markupPrice=='') {
			document.getElementById('markupPrice').focus();
			displayModalAlert('#modalMessage','Mark-Up Price must not be empty');
			return false;
		}
		
		var dataString = 'eloadPrice.eloadProductId='+productId+'&eloadPrice.price='+eloadPrice+'&eloadPrice.retailPrice='+retailPrice+'&eloadPrice.markupPrice='+markupPrice;
		$.ajax({
			type: "POST",
			url: "addEloadPrice.htm",
			data: dataString,
			dataType: "json",
			success: function(data){
				if (data.success) {
					//alert('success');
	           		location.reload();
				} else {
					displayModalAlert('#modalMessage',data.message);
				}
			},
			error: function(errorThrown){
				displayModalAlert('#modalMessage',"ERROR 500: "+errorThrown);
			}
		});	
		
	});
	
});

function toggleStatus(status, priceid) {
	var dataString = 'eloadPrice.enableStatus='+status+'&eloadPrice.priceId='+priceid;
	$.ajax({
		type: "POST",
		url: "updateEloadPrice.htm",
		data: dataString,
		dataType: "json",
		success: function(data){
			if (data.success) {
				//alert('success');
           		location.reload();
			} else {
				displayAlert(data.message);
			}
		},
		error: function(errorThrown){
			displayAlert("ERROR 500: "+errorThrown);
		}
	});	
}

</script>

<div class="modal fade" id="addEloadPriceModal" tabindex="-1" role="dialog" aria-labelledby="myModalLabel" aria-hidden="true">
	<div class="modal-dialog">
    <div class="modal-content">
      <div class="modal-header">
        <button type="button" class="close" data-dismiss="modal" aria-hidden="true">&times;</button>
        <h4 class="modal-title" id="myModalLabel">Add E-LOAD Price</h4>
      </div>
      			<div class="panel-body" align="center" style="padding: 0px !important;">
					<div class="alert alert-danger alert-autocloseable-danger modalsOnly" style="display:none;">
						<span id="modalMessage"></span>
					</div>
				</div>
      <div class="modal-body">
       		<table border=0 align="center">
       			<tr>
       				<td>E-LOAD: </td>
       				<td><s:select list="eloadProductIds" emptyOption="true" listKey="eloadProductId" listValue="eloadName" name="productId" id="productId" theme="simple" style="width: 155px" /></td>
       				<td>&nbsp;&nbsp;&nbsp;<span class="label label-danger" id="errorMsgUser">*</span></td>
       			</tr>
       			<tr>
       				<td>E-LOAD Price: </td>
       				<td><input type="text" name="eloadPrice" id="eloadPrice" placeholder="Numbers/decimal only" class="decimalInput" /></td>
       				<td>&nbsp;&nbsp;&nbsp;<span class="label label-danger" id="errorMsgUser">*</span></td>
       			</tr>
       			<tr>
       				<td>Retail Price: </td>
       				<td><input type="text" name="retailPrice" id="retailPrice" placeholder="Numbers/decimal only" class="decimalInput" /></td>
       				<td>&nbsp;&nbsp;&nbsp;<span class="label label-danger" id="errorMsgUser">*</span></td>
       			</tr>
       			<tr>
       				<td>Mark-Up Price: </td>
       				<td><input type="text" name="markupPrice" id="markupPrice" placeholder="Numbers/decimal only" class="decimalInput" /></td>
       				<td>&nbsp;&nbsp;&nbsp;<span class="label label-danger" id="errorMsgUser">*</span></td>
       			</tr>
       		</table>
      </div>
      <div class="modal-footer">
        <button type="button" class="btn btn-default" data-dismiss="modal">Close</button>
        <button type="button" class="btn btn-primary" id="addEloadPriceButton">Add</button>
      </div>
    </div>
  </div>
</div>
<div class="col-sm-9 col-sm-offset-3 col-md-10 col-md-offset-2 main">	
	<h2 class="page-header">E-LOAD PRICE SETTINGS</h2>
	<c:if test="${fn:contains(sessionScope.userSession.role.permission, 'G5') }">
		<button class="btn btn-primary" data-toggle="modal" data-target="#addEloadPriceModal">
		 	Configure Price
		</button>
	</c:if>
	<br/><br/>
	<h4 class="sub-header">E-LOAD Price List</h4>
	<div class="table-responsive">
		<form action="eloadPrices.htm" name="searchForm" id="searchForm" method="post" >
			<table border=0>
				<tr>
					<td>Date: <input type="text" name="searchDate" id="datepicker" value="${searchDate }"></td>
					<td>
						E-LOAD Price: <s:select list="operatorsPrice" emptyOption="true" listKey="operator" listValue="operator" name="operatorPriceStr" id="operatorPriceStr" theme="simple" />
						<input type="text" name="price" id="price" class="decimalInput"/>
					</td>
					<td>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;</td>
					<td>
						Retail Price: <s:select list="operatorsRetailPrice" emptyOption="true" listKey="operator" listValue="operator" name="operatorRetailStr" id="operatorRetailStr" theme="simple" />
						<input type="text" name="retailPrice" id="retailPrice" class="decimalInput"/>
					</td>
					<td>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;</td>
					<td>
						<button class="btn btn-primary" id="searchCriteriaForm">Search</button>
					</td>
				</tr>
				<tr>	
					<td style="width:350px;">
						Mark-Up Price: <s:select list="operatorsMarkupPrice" emptyOption="true" listKey="operator" listValue="operator" name="operatorMarkupStr" id="operatorMarkupStr" theme="simple" />
						<input type="text" name="markupPrice" id="markupPrice" class="decimalInput"/>
					</td>
					<td>
						Price Status <s:select list="userStatuses" listKey="code" listValue="description" name="priceStatus" id="priceStatus" theme="simple"/>
					</td>
					<td></td>
					<td>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;</td>
					<td>
						
					</td>
				</tr>
			</table>
		</form>
	</div>
	<br/>
	<c:if test="${fn:contains(sessionScope.userSession.role.permission, 'G6') }">
		<div class="table-responsive" style="width:1100px; overflow: auto;">
			<ul id="myTab" class="nav nav-tabs" role="tablist">
		      <li class="active"><a href="#smart" role="tab" data-toggle="tab">SMART</a></li>
		      <li class=""><a href="#globe" role="tab" data-toggle="tab">GLOBE</a></li>
		      <li class=""><a href="#sun" role="tab" data-toggle="tab">SUN</a></li>
		    </ul>
		    <!-- start tab -->
		    <div id="myTabContent" class="tab-content">
		    	<div class="tab-pane fade active in" id="smart">
		    		<table border=0 class="table table-striped" style="width:1100px;">
		    			<thead>
							<tr>
								<th style="width:5%;">ID</th>
								<th style="width:8%;">E-LOAD PRICE</th>
								<th style="width:9%;">Retail Price</th>
								<th style="width:9%;">Mark-Up Price</th>
								<th style="width:9%;">Status</th>
								<th style="width:11%;">Created Date</th>
								<th style="width:11%;">Created By</th>
							</tr>
						</thead>
						<tbody>
							<c:forEach items="${pageEloadPriceSmart.contents }" var="query">
								<tr>
									<td>${query.priceId }</td>
									<td>${query.price }</td>
									<td>${query.retailPrice }</td>
									<td>${query.markupPrice }</td>
									<td>
										<c:if test="${fn:contains(sessionScope.userSession.role.permission, 'G7') }">
											<c:if test="${query.enableStatus eq 0 }">
												<a href="#" onclick="toggleStatus('${query.enableStatus }','${query.priceId }');">ENABLED</a>
											</c:if>
											<c:if test="${query.enableStatus ne 0 }">
												<a href="#" onclick="toggleStatus('${query.enableStatus }','${query.priceId }');">DISABLED</a>
											</c:if>
										</c:if>
										<c:if test="${!(fn:contains(sessionScope.userSession.role.permission, 'G7')) }">
											<c:if test="${query.enableStatus eq 0 }">
												ENABLED
											</c:if>
											<c:if test="${query.enableStatus ne 0 }">
												DISABLED
											</c:if>
										</c:if>
									</td>
									<td><fmt:formatDate type="both" value="${query.updatedDate}" /></td>
									<td>${query.updatedBy }</td>
								</tr>
							</c:forEach>
							<c:if test="${empty pageEloadPriceSmart.contents }">
								<tr>
									<td colspan="7" align="center">No records</td>
								</tr>
							</c:if>
			    		</tbody>
		    		</table>
		    	</div>
		    	<div class="tab-pane fade" id="globe">
		    		<table border=0 class="table table-striped" style="width:1100px;">
		    			<thead>
							<tr>
								<th style="width:5%;">ID</th>
								<th style="width:8%;">E-LOAD PRICE</th>
								<th style="width:9%;">Retail Price</th>
								<th style="width:9%;">Mark-Up Price</th>
								<th style="width:9%;">Status</th>
								<th style="width:11%;">Created Date</th>
								<th style="width:11%;">Created By</th>
							</tr>
						</thead>
						<tbody>
							<c:forEach items="${pageEloadPriceGlobe.contents }" var="query">
								<tr>
									<td>${query.priceId }</td>
									<td>${query.price }</td>
									<td>${query.retailPrice }</td>
									<td>${query.markupPrice }</td>
									<td>
										<c:if test="${fn:contains(sessionScope.userSession.role.permission, 'G7') }">
											<c:if test="${query.enableStatus eq 0 }">
												<a href="#" onclick="toggleStatus('${query.enableStatus }','${query.priceId }');">ENABLED</a>
											</c:if>
											<c:if test="${query.enableStatus ne 0 }">
												<a href="#" onclick="toggleStatus('${query.enableStatus }','${query.priceId }');">DISABLED</a>
											</c:if>
										</c:if>
										<c:if test="${!(fn:contains(sessionScope.userSession.role.permission, 'G7')) }">
											<c:if test="${query.enableStatus eq 0 }">
												ENABLED
											</c:if>
											<c:if test="${query.enableStatus ne 0 }">
												DISABLED
											</c:if>
										</c:if>
									</td>
									<td><fmt:formatDate type="both" value="${query.updatedDate}" /></td>
									<td>${query.updatedBy }</td>
								</tr>
							</c:forEach>
							<c:if test="${empty pageEloadPriceGlobe.contents }">
								<tr>
									<td colspan="7" align="center">No records</td>
								</tr>
							</c:if>
			    		</tbody>
		    		</table>
		    	</div>
		    	<div class="tab-pane fade" id="sun">
		    		<table border=0 class="table table-striped" style="width:1100px;">
		    			<thead>
							<tr>
								<th style="width:5%;">ID</th>
								<th style="width:8%;">E-LOAD PRICE</th>
								<th style="width:9%;">Retail Price</th>
								<th style="width:9%;">Mark-Up Price</th>
								<th style="width:9%;">Status</th>
								<th style="width:11%;">Created Date</th>
								<th style="width:11%;">Created By</th>
							</tr>
						</thead>
						<tbody>
							<c:forEach items="${pageEloadPriceSun.contents }" var="query">
								<tr>
									<td>${query.priceId }</td>
									<td>${query.price }</td>
									<td>${query.retailPrice }</td>
									<td>${query.markupPrice }</td>
									<td>
										<c:if test="${fn:contains(sessionScope.userSession.role.permission, 'G7') }">
											<c:if test="${query.enableStatus eq 0 }">
												<a href="#" onclick="toggleStatus('${query.enableStatus }','${query.priceId }');">ENABLED</a>
											</c:if>
											<c:if test="${query.enableStatus ne 0 }">
												<a href="#" onclick="toggleStatus('${query.enableStatus }','${query.priceId }');">DISABLED</a>
											</c:if>
										</c:if>
										<c:if test="${!(fn:contains(sessionScope.userSession.role.permission, 'G7')) }">
											<c:if test="${query.enableStatus eq 0 }">
												ENABLED
											</c:if>
											<c:if test="${query.enableStatus ne 0 }">
												DISABLED
											</c:if>
										</c:if>
									</td>
									<td><fmt:formatDate type="both" value="${query.updatedDate}" /></td>
									<td>${query.updatedBy }</td>
								</tr>
							</c:forEach>
							<c:if test="${empty pageEloadPriceSun.contents }">
								<tr>
									<td colspan="7" align="center">No records</td>
								</tr>
							</c:if>
			    		</tbody>
		    		</table>
		    	</div>
		    </div>
		</div>
	</c:if>
	<c:if test="${!(fn:contains(sessionScope.userSession.role.permission, 'G6')) }">
	<div class="row placeholders">
		<div class="col-xs-6 col-sm-3 placeholder">
			No access rights to proceed
		</div>
	</div>
	</c:if>
	
</div>
