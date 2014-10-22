<%@page language="java" contentType="text/html" %>
<%@include file="../common/taglib.jsp"%>

<script type="text/javascript">
$(document).ready(function(){
	$('#checkInButton').click(function(e){
		var startingCash = $('#startingCash').val();
		var startingGlobeEload = $('#startingGlobeEload').val();
		var startingSmartEload = $('#startingSmartEload').val();
		var startingSunEload = $('#startingSunEload').val();
		
		if (startingCash=='') {
			document.getElementById('startingCash').focus();
			alert('Starting cash must not be empty');
			return false;
		} else if (startingGlobeEload=='') {
			document.getElementById('startingGlobeEload').focus();
			alert('Starting Globe E-LOAD must not be empty');
			return false;
		} else if (startingSmartEload=='') {
			document.getElementById('startingSmartEload').focus();
			alert('Starting Smart E-LOAD must not be empty');
			return false;
		} else if (startingSunEload=='') {
			document.getElementById('startingSunEload').focus();
			alert('Starting Sun E-LOAD must not be empty');
			return false;
		}
		
		var confirmSubmit = confirm('Checking in the starting cash is final. No more modification. Do you want to continue?');
		if (confirmSubmit==true) {
			var dataString = 'startingCash='+startingCash+'&startingGlobeEload='+startingGlobeEload+'&startingSmartEload='+startingSmartEload+'&startingSunEload='+startingSunEload;
			$.ajax({
				type: "POST",
				url: "doCheckIn.htm",
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
		}
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

<div class="col-sm-9 col-sm-offset-3 col-md-10 col-md-offset-2 main">	
	<h2 class="page-header">DUTY CHECK-IN</h2>
	<br/>
	<c:if test="${checkInDetail.onDutyStatus eq '0' }">
		<h4 class="sub-header">Check In Details</h4>
	</c:if>
	<c:if test="${checkInDetail.onDutyStatus eq '1' }">
		<h4 class="sub-header">Starting Amount</h4>
	</c:if>
	<div class="row placeholders">
		<div class="col-xs-6 col-sm-3 placeholder">
			<c:if test="${checkInDetail.onDutyStatus eq '0' }">
				<br/>
				<table border=0 style="width:400px">
					<tr>
						<td align="right"><b>Check In Time:</b></td>
						<td align="left">&nbsp;&nbsp;<fmt:formatDate type="both" value="${sessionScope.onDutySession.loginDate}" /></td>
					</tr>
					<tr>
						<td align="right"><b>Starting Cash:</b></td>
						<td align="left">&nbsp;&nbsp;Php&nbsp;<fmt:formatNumber type="number" pattern="#,##0.00" value="${checkInDetail.startingCash}" /></td>
					</tr>
					<tr>
						<td align="right"><b>Starting Globe E-LOAD:</b></td>
						<td align="left">&nbsp;&nbsp;Php&nbsp;<fmt:formatNumber type="number" pattern="#,##0.00" value="${checkInDetail.startingGlobeEload}" /></td>
					</tr>
					<tr>
						<td align="right"><b>Starting Sun E-LOAD:</b></td>
						<td align="left">&nbsp;&nbsp;Php&nbsp;<fmt:formatNumber type="number" pattern="#,##0.00" value="${checkInDetail.startingSmartEload}" /></td>
					</tr>
					<tr>
						<td align="right"><b>Starting Smart E-LOAD:</b></td>
						<td align="left">&nbsp;&nbsp;Php&nbsp;<fmt:formatNumber type="number" pattern="#,##0.00" value="${checkInDetail.startingSunEload}" /></td>
					</tr>
				</table>
			</c:if>
			<c:if test="${checkInDetail.onDutyStatus eq '1' }">
				
				<table border=0 style="width:410px">
					<tr>
						<td align="right">Starting Cash: </td>
						<td>&nbsp;&nbsp;Php&nbsp;<input type="text" name="startingCash" id="startingCash" class="decimalInput" placeholder="Numbers/Decimal only"/></td>
						<td>&nbsp;&nbsp;&nbsp;<span class="label label-danger" id="errorMsgUser">*</span></td>
					</tr>
					<tr>
						<td align="right">Starting Globe E-LOAD: </td>
						<td>&nbsp;&nbsp;Php&nbsp;<input type="text" name="startingGlobeEload" id="startingGlobeEload" class="decimalInput" placeholder="Numbers/Decimal only"/></td>
						<td>&nbsp;&nbsp;&nbsp;<span class="label label-danger" id="errorMsgUser">*</span></td>
					</tr>
					<tr>
						<td align="right">Starting Smart E-LOAD: </td>
						<td>&nbsp;&nbsp;Php&nbsp;<input type="text" name="startingSmartEload" id="startingSmartEload" class="decimalInput" placeholder="Numbers/Decimal only"/></td>
						<td>&nbsp;&nbsp;&nbsp;<span class="label label-danger" id="errorMsgUser">*</span></td>
					</tr>
					<tr>
						<td align="right">Starting Sun E-LOAD: </td>
						<td>&nbsp;&nbsp;Php&nbsp;<input type="text" name="startingSunEload" id="startingSunEload" class="decimalInput" placeholder="Numbers/Decimal only"/></td>
						<td>&nbsp;&nbsp;&nbsp;<span class="label label-danger" id="errorMsgUser">*</span></td>
					</tr>
					<tr>
						<td colspan="3">&nbsp;</td>
					</tr>
					<tr>
						<td colspan="3"><button type="button" class="btn btn-primary" id="checkInButton">Check In</button></td>
					</tr>
				</table>
			</c:if>
		</div>
	</div>
</div>