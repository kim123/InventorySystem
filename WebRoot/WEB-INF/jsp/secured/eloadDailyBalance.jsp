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
	
	$('#updateBalanceButton').click(function(){
		var additional = $('#additional').val();
		var eloadBalanceId = $('#eloadBalanceId').val();
		var eloadTypeLabel = $('#eloadTypeLabel').val();
		
		if (additional=='') {
			document.getElementById('additional').focus();
			alert('Additional Balance field must not be empty');
			return false;
		}
		var dataString = 'additionalBalance='+additional+'&balanceId='+eloadBalanceId+'&eloadType='+eloadTypeLabel;
		$.ajax({
			type: "POST",
			url: "updateEloadAdditionalBalance.htm",
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
	
	$('.clickUpdateAddBal').click(function(e){
		var eloadtype = e.target.id.split("-")[1];
		var balanceid = e.target.id.split("-")[2];
		$('.eloadTypeLabel').html(eloadtype);
		$('#eloadBalanceId').val(balanceid);
		$('#eloadTypeLabel').val(eloadtype);
	});
	
});



</script>

<div class="modal fade" id="updateBalanceModal" tabindex="-1" role="dialog" aria-labelledby="myModalLabel" aria-hidden="true">
	<div class="modal-dialog">
    <div class="modal-content">
      <div class="modal-header">
        <button type="button" class="close" data-dismiss="modal" aria-hidden="true">&times;</button>
        <h4 class="modal-title" id="myModalLabel">Update Additional Balance for <span class="eloadTypeLabel"></span></h4>
      </div>
      <div class="modal-body">
       		<table border=0 align="center">
       			<tr>
       				<td><span class="eloadTypeLabel"></span>:&nbsp;&nbsp;</td>
       				<td><input type="text" name="additional" id="additional" class="decimalInput" placeholder="Numbers/Decimal only" style="width:150px" maxlength="5"/></td>
       				<td>&nbsp;&nbsp;&nbsp;<span class="label label-danger" id="errorMsgUser">*</span></td>
       			</tr>
       		</table>
       		<input type="hidden" name="eloadBalanceId" id="eloadBalanceId" />
       		<input type="hidden" name="eloadTypeLabel" class="eloadTypeLabel" id="eloadTypeLabel"/>
      </div>
      <div class="modal-footer">
        <button type="button" class="btn btn-default" data-dismiss="modal">Close</button>
        <button type="button" class="btn btn-primary" id="updateBalanceButton">Add</button>
      </div>
    </div>
  </div>
</div>

<div class="col-sm-9 col-sm-offset-3 col-md-10 col-md-offset-2 main">	
	<h2 class="page-header">E-LOAD DAILY BALANCE</h2>
	<br/>
	<div class="table-responsive">
		<form action="eloadDailyBalance.htm" name="searchForm" id="searchForm" method="post" >
			Date: <input type="text" name="searchDate" id="datepicker" value="${searchDate }">  &nbsp;&nbsp;&nbsp;
			<button class="btn btn-primary" id="searchCriteriaForm">Search</button>
		</form>
	</div>
	<br/>
	<div class="table-responsive" style="width:1100px; overflow: auto;">
		<c:if test="${!(fn:contains(sessionScope.userSession.role.permission, 'G4')) }">
	    	<div class="row placeholders">
				<div class="col-xs-6 col-sm-3 placeholder">
					No access rights to proceed
				</div>
			</div>
	    </c:if>
	    <c:if test="${fn:contains(sessionScope.userSession.role.permission, 'G4') }">
	    	<table border=0 class="table table-striped" style="width:1100px;">
	    		<thead>
					<tr>
						<th style="width:10%;">E-Load</th>
						<th style="width:9%;">Beg. Bal</th>
						<th style="width:9%;">Add. Bal</th>
						<th style="width:9%;">Total Bal</th>
						<th style="width:9%;">End. Bal</th>
						<th style="width:9%;">Sold Load</th>
						<th style="width:11%;">Created By</th>
						<th style="width:11%;">Created Date</th>
						<th style="width:11%;">Updated Date</th>
					</tr>
				</thead>
				<tbody>
					<c:forEach items="${pageEloadBalance.contents }" var="query" end="1">
						<tr>
							<td>SMART</td>
							<td><fmt:formatNumber type="number" pattern="#,##0.00" value="${query.startingEloadSmart}" /></td>
							<td>
								<fmt:formatNumber type="number" pattern="#,##0.00" value="${query.additionalBalanceSmart}" /> 
								<c:if test="${balanceUpdateType eq '1' }">
									<a href="#" data-toggle="modal" data-target="#updateBalanceModal" class="clickUpdateAddBal" id="eloadtype-SMART-${query.eloadDailyBalanceId }">(Update)</a>
								</c:if>
							</td>
							<td><fmt:formatNumber type="number" pattern="#,##0.00" value="${query.totalEloadSmart}" /></td>
							<td><fmt:formatNumber type="number" pattern="#,##0.00" value="${query.endingBalanceSmart}" /></td>
							<td><fmt:formatNumber type="number" pattern="#,##0.00" value="${query.actualSoldOutSmart}" /></td>
							<td>${query.creaetdBy }</td>
							<td><fmt:formatDate type="both" value="${query.createdDate}" /></td>
							<td><fmt:formatDate type="both" value="${query.updatedDateSmart}" /></td>
						</tr>
						<tr>
							<td>GLOBE</td>
							<td><fmt:formatNumber type="number" pattern="#,##0.00" value="${query.startingEloadGlobe}" /></td>
							<td>
								<fmt:formatNumber type="number" pattern="#,##0.00" value="${query.additionalBalanceGlobe}" /> 
								<c:if test="${balanceUpdateType eq '1' }">
									<a href="#" data-toggle="modal" data-target="#updateBalanceModal" class="clickUpdateAddBal" id="eloadtype-GLOBE-${query.eloadDailyBalanceId }">(Update)</a>
								</c:if>
							</td>
							<td><fmt:formatNumber type="number" pattern="#,##0.00" value="${query.totalEloadGlobe}" /></td>
							<td><fmt:formatNumber type="number" pattern="#,##0.00" value="${query.endingBalanceGlobe}" /></td>
							<td><fmt:formatNumber type="number" pattern="#,##0.00" value="${query.actualSoldOutGlobe}" /></td>
							<td>${query.creaetdBy }</td>
							<td><fmt:formatDate type="both" value="${query.createdDate}" /></td>
							<td><fmt:formatDate type="both" value="${query.updatedDateGlobe}" /></td>
						</tr>
						<tr>
							<td>SUN</td>
							<td><fmt:formatNumber type="number" pattern="#,##0.00" value="${query.startingEloadSun}" /></td>
							<td>
								<fmt:formatNumber type="number" pattern="#,##0.00" value="${query.additionalBalanceSun}" /> 
								<c:if test="${balanceUpdateType eq '1' }">
									<a href="#" data-toggle="modal" data-target="#updateBalanceModal" class="clickUpdateAddBal" id="eloadtype-SUN-${query.eloadDailyBalanceId }">(Update)</a>
								</c:if>
							</td>
							<td><fmt:formatNumber type="number" pattern="#,##0.00" value="${query.totalEloadSun}" /></td>
							<td><fmt:formatNumber type="number" pattern="#,##0.00" value="${query.endingBalanceSun}" /></td>
							<td><fmt:formatNumber type="number" pattern="#,##0.00" value="${query.actualSoldOutSun}" /></td>
							<td>${query.creaetdBy }</td>
							<td><fmt:formatDate type="both" value="${query.createdDate}" /></td>
							<td><fmt:formatDate type="both" value="${query.updatedDateSun}" /></td>
						</tr>
					</c:forEach>
					<c:if test="${empty pageEloadBalance.contents }">
							<tr>
								<td colspan="9" align="center">No records</td>
							</tr>
						</c:if>
				</tbody>
	    	</table>
	    </c:if>
	</div>
</div>