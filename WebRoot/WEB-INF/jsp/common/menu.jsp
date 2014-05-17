<%@page language="java" contentType="text/html" %>
<%@include file="../common/taglib.jsp"%>

				<div class="col-sm-3 col-md-2 sidebar">
					<ul class="nav nav-sidebar">
						<li role="presentation" class="dropdown-header">ADMIN</li>
						<li <c:if test='${menuActive eq 1 }'>class="active"</c:if> ><a href="users.htm">Users</a></li>
						<li ><a href="#">Access Rights</a></li>
					</ul>
					<ul class="nav nav-sidebar">
						<li role="presentation" class="dropdown-header">OPERATION</li>
						<li><a href="#">Category</a></li>
						<li><a href="#">Products</a></li>
						<li><a href="">Inventory</a></li>
						<li><a href="">Duty Check-In</a></li>
						<li><a href="">Stocks on Hand</a></li>
						<li><a href="">Daily Sales and Expenses</a></li>
						<li><a href="">E-Load Balances</a></li>
						<li><a href="">E-Load Daily Sales</a></li>
						<li><a href="">Duty Check-Out</a></li>
					</ul>
					<ul class="nav nav-sidebar">
						<li role="presentation" class="dropdown-header">REPORTS</li>
						<li><a href="#">Daily Sales and Expense</a></li>
						<li><a href="#">Inventory</a></li>
						<li><a href="#">E-Load Revenue</a></li>
						<li><a href="#">Sales Revenue (Top High Sales Products)</a></li>
						<li><a href="#">Sales Revenue (Top Low Sales Products)</a></li>
					</ul>
				</div>