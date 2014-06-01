<%@page language="java" contentType="text/html" %>
<%@include file="../common/taglib.jsp"%>

				<div class="col-sm-3 col-md-2 sidebar">
					<ul class="nav nav-sidebar">
						<li role="presentation" class="dropdown-header">ADMIN</li>
						<c:if test="${fn:contains(sessionScope.userSession.role.permission, 'A') }">
							<li <c:if test='${menuActive eq 1 }'>class="active"</c:if> ><a href="users.htm">Users</a></li>
						</c:if>
						<c:if test="${fn:contains(sessionScope.userSession.role.permission, 'B') }">
							<li <c:if test='${menuActive eq 2 }'>class="active"</c:if> ><a href="accessRights.htm">Access Rights</a></li>
						</c:if>
					</ul>
					<ul class="nav nav-sidebar">
						<li role="presentation" class="dropdown-header">OPERATION</li>
						<c:if test="${fn:contains(sessionScope.userSession.role.permission, 'C') }">
							<li <c:if test='${menuActive eq 3 }'>class="active"</c:if> ><a href="category.htm">Category</a></li>
						</c:if>
						<c:if test="${fn:contains(sessionScope.userSession.role.permission, 'D') }">
							<li <c:if test='${menuActive eq 4 }'>class="active"</c:if> ><a href="#">Products</a></li>
						</c:if>
						<li <c:if test='${menuActive eq 5 }'>class="active"</c:if> ><a href="">Inventory</a></li>
						<li <c:if test='${menuActive eq 6 }'>class="active"</c:if> ><a href="">Duty Check-In</a></li>
						<li <c:if test='${menuActive eq 7 }'>class="active"</c:if> ><a href="">Stocks on Hand</a></li>
						<li <c:if test='${menuActive eq 8 }'>class="active"</c:if> ><a href="">Daily Sales and Expenses</a></li>
						<li <c:if test='${menuActive eq 9 }'>class="active"</c:if> ><a href="">E-Load Balances</a></li>
						<li <c:if test='${menuActive eq 10 }'>class="active"</c:if> ><a href="">E-Load Daily Sales</a></li>
						<li <c:if test='${menuActive eq 11 }'>class="active"</c:if> ><a href="">Duty Check-Out</a></li>
					</ul>
					<ul class="nav nav-sidebar">
						<li role="presentation" class="dropdown-header">REPORTS</li>
						<li <c:if test='${menuActive eq 12 }'>class="active"</c:if> ><a href="#">Daily Sales and Expense</a></li>
						<li <c:if test='${menuActive eq 13 }'>class="active"</c:if> ><a href="#">Inventory</a></li>
						<li <c:if test='${menuActive eq 14 }'>class="active"</c:if> ><a href="#">E-Load Revenue</a></li>
						<li <c:if test='${menuActive eq 15 }'>class="active"</c:if> ><a href="#">Sales Revenue (Top High Sales Products)</a></li>
						<li <c:if test='${menuActive eq 16 }'>class="active"</c:if> ><a href="#">Sales Revenue (Top Low Sales Products)</a></li>
					</ul>
				</div>