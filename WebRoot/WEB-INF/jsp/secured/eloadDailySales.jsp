<%@page language="java" contentType="text/html" %>
<%@include file="../common/taglib.jsp"%>

<script type="text/javascript">
$(document).ready(function(){
	$("#datepicker").datepicker({
		dateFormat: "yy-mm-dd"
	});
	
	$('.decimalInput').keypress(function(e){
		var charCode = (e.which) ? e.which : event.keyCode;
        if (charCode != 45 && (charCode != 46 || $(this).val().indexOf('.') != 0) && 
                (charCode < 48 || charCode > 57))
            return false;

        return true;
	});	
	
	$('#addEloadSalesButton').click(function(){
		$('#submitFormAddEloadSale').submit();
	});
	
	$('.decimalInput').keyup(function(e){
		/* var ctr = e.target.id.split("-")[1];
		var eload = e.target.id.split("-")[2];
		var idd = "#id-"+ctr+"-"+eload;
		
		var tempquantityvalue = $(idd).val();
		//alert("tanginang value:"+tempquantityvalue+",fuck test: "+isNaN(tempquantityvalue));
		if (tempquantityvalue=='') {
			alert('testinhhh');
		} else if (isNaN(tempquantityvalue)) {
			
		} else {
			var quantityinput = parseInt(tempquantityvalue);
			//var subtotal = parseInt($('#subTotal'+ctr).html());
			var price = parseFloat($('#price'+ctr).html());
			var newsubtotal = quantityinput*price;
			$('#subTotal'+ctr).html(newsubtotal);
			//alert("quantityinput:"+quantityinput+",price:"+price+",newsubtotal:"+newsubtotal);
			if (eload=='smart') {
				var smartTotal = $('#smartTotal').html();
				$('#smartTotal').html(parseFloat(smartTotal)+newsubtotal);
			} else if (eload=='globe') {
				var globeTotal = $('#globeTotal').html();
				$('#globeTotal').html(parseFloat(globeTotal)+newsubtotal);
			} else if (eload=='sun') {
				var sunTotal = $('#sunTotal').html();
				$('#sunTotal').html(parseFloat(sunTotal)+newsubtotal);
			}
		}
		
		 */
		var charCode = (e.which) ? e.which : event.keyCode;
        if (charCode != 45 && (charCode != 46 || $(this).val().indexOf('.') != -1) && 
                (charCode < 48 || charCode > 57))
            return false;

        return true;
		
	});
	
});
</script>

<div class="col-sm-9 col-sm-offset-3 col-md-10 col-md-offset-2 main">	
	<h2 class="page-header">E-LOAD DAILY SALES</h2>
	<br/>
	<div class="table-responsive">
		<form action="eloadDailySales.htm" name="searchForm" id="searchForm" method="post" >
			Date: <input type="text" name="searchDate" id="datepicker" value="${searchDate }">  &nbsp;&nbsp;&nbsp;
			<button class="btn btn-primary" id="searchCriteriaForm">Search</button>
		</form>
	</div>
	<br/>
	<c:if test="${priceListType eq '0' }">
	<p style="color:#FF0000;">NOTE: Adding a record for the Eload Daily Sales is considered to be final. </p>
	<br/>
	</c:if>
	<div class="table-responsive" style="width:1100px; overflow: auto;">
		<c:if test="${!(fn:contains(sessionScope.userSession.role.permission, 'G2')) }">
	    	<div class="row placeholders">
				<div class="col-xs-6 col-sm-3 placeholder">
					No access rights to proceed
				</div>
			</div>
	    </c:if>
	    <c:if test="${fn:contains(sessionScope.userSession.role.permission, 'G2') }">
	    	<s:form action="addEloadDailySales" method="post" theme="simple" id="submitFormAddEloadSale">
	    	<table border=1 class="table" style="width:1100px;">
	    		<tr>
	    			<td>
	    				<table border=0 class="table">
	    					<thead>
	    						<tr>
	    							<th colspan="3" style="width:10%; text-align:center;">SMART</th>
	    						</tr>
	    					</thead>
	    					<tbody>
	    						<tr>
	    							<td style="font-weight:bold; text-align:center;">Price</td>
	    							<td style="font-weight:bold; text-align:center;">Quantity</td>
	    							<!-- <td style="font-weight:bold; text-align:center;">SubTotal</td> -->
	    						</tr>
	    						<c:set var="ctr" value="1" />
	    						<c:forEach items="${pageEloadSalesSmart.contents }" var="query">
		    						<tr>
		    							<td style="text-align:center;"><span id="price${ctr }">${query.price }</span></td>
		    							<td style="text-align:center;">
		    								<c:if test="${priceListType eq '0' }">
		    									<c:if test="${query.total ne '0.00'}">
		    										${query.quantity }
		    									</c:if>
		    									<c:if test="${query.total eq '0.00'}">
		    										<input type="text"  style="width:100px" name="quantity${ctr }" class="decimalInput" placeholder="Numbers only" id="id-${ctr }-smart" value="0"/>
		    									</c:if>
		    								</c:if>
		    								<c:if test="${priceListType eq '1' }">
		    									${query.quantity }
		    								</c:if>
		    							</td>
		    							<%-- <td style="text-align:center;"><span id="subTotal${ctr }">${query.total }</span></td> --%>
		    						</tr>
		    						<c:set var="ctr" value="${ctr+1 }" />
		    					</c:forEach>
	    					</tbody>
	    				</table>
	    			</td>
	    			<td>
	    				<table border=0 class="table">
	    					<thead>
	    						<tr>
	    							<th colspan="3" style="width:10%; text-align:center;">GLOBE</th>
	    						</tr>
	    					</thead>
	    					<tbody>
	    						<tr>
	    							<td style="font-weight:bold; text-align:center;">Price</td>
	    							<td style="font-weight:bold; text-align:center;">Quantity</td>
	    							<!-- <td style="font-weight:bold; text-align:center;">SubTotal</td> -->
	    						</tr>
	    						<c:forEach items="${pageEloadSalesGlobe.contents }" var="query">
		    						<tr>
		    							<td style="text-align:center;"><span id="price${ctr }">${query.price }</span></td>
		    							<td style="text-align:center;">
		    								<c:if test="${priceListType eq '0' }">
		    									<c:if test="${query.total ne '0.00'}">
		    										${query.quantity }
		    									</c:if>
		    									<c:if test="${query.total eq '0.00'}">
		    										<input type="text"  style="width:100px" name="quantity${ctr }" class="decimalInput" placeholder="Numbers only" id="id-${ctr }-globe" value="0"/>
		    									</c:if>
		    								</c:if>
		    								<c:if test="${priceListType eq '1' }">
		    									${query.quantity }
		    								</c:if>
		    							</td>
		    							<%-- <td style="text-align:center;"><span id="subTotal${ctr }">${query.total }</span></td> --%>
		    						</tr>
		    						<c:set var="ctr" value="${ctr+1 }" />
		    					</c:forEach>
	    					</tbody>
	    				</table>
	    			</td>
	    			<td>
	    				<table border=0 class="table">
	    					<thead>
	    						<tr>
	    							<th colspan="3" style="width:10%; text-align:center;">SUN</th>
	    						</tr>
	    					</thead>
	    					<tbody>
	    						<tr>
	    							<td style="font-weight:bold; text-align:center;">Price</td>
	    							<td style="font-weight:bold; text-align:center;">Quantity</td>
	    							<!-- <td style="font-weight:bold; text-align:center;">SubTotal</td> -->
	    						</tr>
	    						<c:forEach items="${pageEloadSalesSun.contents }" var="query">
		    						<tr>
		    							<td style="text-align:center;"><span id="price${ctr }">${query.price }</span></td> 
		    							<td style="text-align:center;">
		    								<c:if test="${priceListType eq '0' }">
		    									<c:if test="${query.total ne '0.00'}">
		    										${query.quantity }
		    									</c:if>
		    									<c:if test="${query.total eq '0.00'}">
		    										<input type="text"  style="width:100px" name="quantity${ctr }" class="decimalInput" placeholder="Numbers only" id="id-${ctr }-sun" value="0"/>
		    									</c:if>
		    								</c:if>
		    								<c:if test="${priceListType eq '1' }">
		    									${query.quantity }
		    								</c:if>
		    							</td>
		    							<%-- <td style="text-align:center;"><span id="subTotal${ctr }">${query.total }</span></td> --%>
		    						</tr>
		    						<c:set var="ctr" value="${ctr+1 }" />
		    					</c:forEach>
	    					</tbody>
	    				</table>
	    			</td>
	    		</tr>
	    		<tr>
	    			<td>
	    				<b>Total:	<span id="smartTotal" style="text-align:right;">${smartTotal }</span></b>
	    			</td>
	    			<td>
	    				<b>Total:	<span id="globeTotal" style="text-align:right;">${globeTotal }</span></b>
	    			</td>
	    			<td>
	    				<b>Total:	<span id="sunTotal" style="text-align:right;">${sunTotal }</span></b>
	    			</td>
	    		</tr>
	    		<tr>
	    			<td colspan="3">Updated By: <span id="updatedBy">${updatedBy }</span></td>
	    		</tr>
	    		<tr>
	    			<td colspan="3">Updated Date: <span id="updatedDate"><fmt:formatDate type="both" value="${updatedDate}" /></span></td>
	    		</tr>
	    		<c:if test="${priceListType eq '0' }">
		    		<tr>
		    			<td colspan="3" style="text-align:center;"><button type="button" class="btn btn-primary" id="addEloadSalesButton">Submit</button></td>
		    		</tr>
	    		</c:if>
	    	</table>
	    	</s:form>
	    </c:if>
	</div>
</div>