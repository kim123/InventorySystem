<%@page language="java" contentType="text/html" %>
<%@include file="../common/taglib.jsp"%>

<script type="text/javascript">
$(document).ready(function(){
	
	$('#totalCash').keyup(function(e){
		var totalCash = $('#totalCash').val();
		if (totalCash=='') {
			document.getElementById('totalCash').focus();
			alert('Total Cash must not be empty');
			return false;
		}
		var cashHandOver = $('#cashHandOver').val();
		if (cashHandOver!='') {
			var cashEnding = totalCash-cashHandOver;
			$('#cashEnding').val(cashEnding);
		}
	});
	
	$('#cashHandOver').keyup(function(e){
		var cashHandOver = $('#cashHandOver').val();
		if (cashHandOver=='') {
			document.getElementById('cashHandOver').focus();
			alert('Cash Hand Over to JFI must not be empty');
			return false;
		}
		var totalCash = $('#totalCash').val();
		if (cashHandOver>totalCash) {
			document.getElementById('cashHandOver').focus();
			alert('Total Cash must be greater than the Cash Hand Over');
			return false;
		}
		var cashEnding = totalCash-cashHandOver;
		$('#cashEnding').val(cashEnding);
	});
	
	$('#checkOutButton').click(function(e){
		var totalCash = $('#totalCash').val();
		var cashHandOver = $('#cashHandOver').val();
		var endingBalanceGlobe = $('#endingBalanceGlobe').val();
		var endingBalanceSmart = $('#endingBalanceSmart').val();
		var endingBalanceSun = $('#endingBalanceSun').val();
		var journalEntry = $('#journalEntry').val();
		
		if (totalCash=='') {
			document.getElementById('totalCash').focus();
			alert('Total Cash must not be empty');
			return false;
		} else if (cashHandOver=='') {
			document.getElementById('cashHandOver').focus();
			alert('Cash Hand Over to JFI must not be empty');
			return false;
		} else if (endingBalanceGlobe=='') {
			document.getElementById('endingBalanceGlobe').focus();
			alert('Ending Balance for Globe E-LOAD must not be empty');
			return false;
		} else if (endingBalanceSmart=='') {
			document.getElementById('endingBalanceSmart').focus();
			alert('Ending Balance for Smart E-LOAD must not be empty');
			return false;
		} else if (endingBalanceSun=='') {
			document.getElementById('endingBalanceSun').focus();
			alert('Ending Balance for Sun E-LOAD must not be empty');
			return false;
		} else if (journalEntry=='') {
			document.getElementById('journalEntry').focus();
			alert('Journal Entry must not be empty');
			return false;
		}

		document.getElementById('checkOutForm').submit();
		
	});
	
	$('.decimalInput').keypress(function(e){
		//var keyCode = e.which;
				var charCode = (e.which) ? e.which : event.keyCode;
		        if (charCode != 45 && (charCode != 46 || $(this).val().indexOf('.') != -1) && 
		                (charCode < 48 || charCode > 57))
		            return false;

		        return true;
	});
});
</script>

<div class="col-sm-9 col-sm-offset-3 col-md-10 col-md-offset-2 main">	
	<h2 class="page-header">DUTY CHECK-OUT</h2>
	<br/><br/>
	<c:if test="${empty checkOutDate}">
		<h4 class="sub-header">Check-out the amount:</h4>
	</c:if>
	<c:if test="${not empty checkOutDate}">
		<h4 class="sub-header">Check-Out Details:</h4>
	</c:if>
	<div class="row placeholders">
		<div class="col-xs-6 col-sm-3 placeholder">
			<c:if test="${empty checkOutDate}">
				<br/>
				<form action="doCheckOut.htm" method="post" name="checkOutForm" id="checkOutForm">
				<table border=0 style="width:650px">
					<tr>
						<td align="right">Total Cash: </td>
						<td align="left">&nbsp;&nbsp;Php&nbsp;<input type="text" name="totalCash" id="totalCash" class="decimalInput" placeholder="Numbers/Decimal only"/>
							&nbsp;&nbsp;&nbsp;<span class="label label-danger" id="errorMsgUser">*</span>
						</td>
					</tr>
					<tr>
						<td align="right">Cash Given to JFI: </td>
						<td align="left">&nbsp;&nbsp;Php&nbsp;<input type="text" name="cashHandOver" id="cashHandOver" class="decimalInput" placeholder="Numbers/Decimal only"/>
							&nbsp;&nbsp;&nbsp;<span class="label label-danger" id="errorMsgUser">*</span>
						</td>
					</tr>
					<tr>
						<td align="right">Cash Ending: </td>
						<td align="left">&nbsp;&nbsp;Php&nbsp;<input type="text" id="cashEnding" disabled="disabled"/></td>
					</tr>
					<tr>
						<td align="right">Ending Balance for Globe E-LOAD: </td>
						<td align="left">&nbsp;&nbsp;Php&nbsp;<input type="text" name="endingBalanceGlobe" id="endingBalanceGlobe" class="decimalInput" value="${endingBalanceGlobe }" disabled="disabled"/>
							&nbsp;&nbsp;&nbsp;<span class="label label-danger" id="errorMsgUser">*</span>
						</td>
					</tr>
					<tr>
						<td align="right">Ending Balance for Smart E-LOAD: </td>
						<td align="left">&nbsp;&nbsp;Php&nbsp;<input type="text" name="endingBalanceSmart" id="endingBalanceSmart" class="decimalInput" value="${endingBalanceSmart }" disabled="disabled"/>
							&nbsp;&nbsp;&nbsp;<span class="label label-danger" id="errorMsgUser">*</span>
						</td>
					</tr>
					<tr>
						<td align="right">Ending Balance for Sun E-LOAD: </td>
						<td align="left">&nbsp;&nbsp;Php&nbsp;<input type="text" name="endingBalanceSun" id="endingBalanceSun" class="decimalInput" value="${endingBalanceSun }" disabled="disabled"/>
							&nbsp;&nbsp;&nbsp;<span class="label label-danger" id="errorMsgUser">*</span>
						</td>
					</tr>
					<tr>
						<td align="right" valign="top">Journal Entry: </td>
						<td align="left">&nbsp;&nbsp;&nbsp;<textarea rows="4" cols="50" name="journalEntry" id="journalEntry"></textarea>
							&nbsp;&nbsp;&nbsp;<span class="label label-danger" id="errorMsgUser" valign="top">*</span>
						</td>
					</tr>
					<tr><td>&nbsp;</td></tr>
					<tr>
						<td colspan="2">
							<button type="button" class="btn btn-primary" id="checkOutButton">Check Out</button>
						</td>
					</tr>
				</table>
				</form>
			</c:if>
			<c:if test="${not empty checkOutDate}">
				<br/>
				<table border=0 style="width:600px">
					<tr>
						<td align="right"><b>Check-Out Time:</b></td>
						<td align="left">&nbsp;&nbsp;&nbsp;&nbsp;<fmt:formatDate type="both" value="${checkOutDate}" /></td>
					</tr>
					<tr>
						<td align="right"><b>Journal Entry:</b></td>
						<td align="left">&nbsp;&nbsp;&nbsp;&nbsp;
							<c:out value="${journalEntry }" />
						</td>
					</tr>
				</table>
			</c:if>
		</div>
	</div>
</div>