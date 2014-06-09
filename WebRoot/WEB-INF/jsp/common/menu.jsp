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
						<li role="presentation" class="dropdown-header">EMPLOYEE</li>
						<c:if test="${fn:contains(sessionScope.userSession.role.permission, 'E1') }">
							<li <c:if test='${menuActive eq 6 }'>class="active"</c:if> ><a href="">Duty Check-In</a></li>
						</c:if>
						<c:if test="${fn:contains(sessionScope.userSession.role.permission, 'E2') }">
							<li <c:if test='${menuActive eq 17 }'>class="active"</c:if> ><a href="">Daily Journal</a></li>
						</c:if>
						<c:if test="${fn:contains(sessionScope.userSession.role.permission, 'E3') }">
							<li <c:if test='${menuActive eq 11 }'>class="active"</c:if> ><a href="">Duty Check-Out</a></li>
						</c:if>
					</ul>
					<ul class="nav nav-sidebar">
						<li role="presentation" class="dropdown-header">OPERATION</li>
						<c:if test="${fn:contains(sessionScope.userSession.role.permission, 'C') }">
							<li <c:if test='${menuActive eq 3 }'>class="active"</c:if> ><a href="category.htm">Category</a></li>
						</c:if>
						<c:if test="${fn:contains(sessionScope.userSession.role.permission, 'D') }">
							<li <c:if test='${menuActive eq 4 }'>class="active"</c:if> ><a href="product.htm">Products</a></li>
						</c:if>
						<c:if test="${fn:contains(sessionScope.userSession.role.permission, 'F') }">
							<li <c:if test='${menuActive eq 5 }'>class="active"</c:if> ><a href="">Inventory</a></li>
						</c:if>
						<c:if test="${fn:contains(sessionScope.userSession.role.permission, 'H') }">
							<li <c:if test='${menuActive eq 7 }'>class="active"</c:if> ><a href="">Stocks on Hand</a></li>
						</c:if>
						<c:if test="${fn:contains(sessionScope.userSession.role.permission, 'I') }">
							<li <c:if test='${menuActive eq 8 }'>class="active"</c:if> ><a href="">Daily Sales and Expenses</a></li>
						</c:if>
						<c:if test="${fn:contains(sessionScope.userSession.role.permission, 'G2') }">
							<li <c:if test='${menuActive eq 9 }'>class="active"</c:if> ><a href="">E-Load Balances</a></li>
						</c:if>
						<c:if test="${fn:contains(sessionScope.userSession.role.permission, 'G1') }">
							<li <c:if test='${menuActive eq 10 }'>class="active"</c:if> ><a href="">E-Load Daily Sales</a></li>
						</c:if>
					</ul>
					<ul class="nav nav-sidebar">
						<li role="presentation" class="dropdown-header">REPORTS</li>
						<c:if test="${fn:contains(sessionScope.userSession.role.permission, 'J1') }">
							<li <c:if test='${menuActive eq 12 }'>class="active"</c:if> ><a href="#">Daily Sales and Expense</a></li>
						</c:if>
						<c:if test="${fn:contains(sessionScope.userSession.role.permission, 'J2') }">
							<li <c:if test='${menuActive eq 13 }'>class="active"</c:if> ><a href="#">Weekly Sales and Expense</a></li>
						</c:if>
						<c:if test="${fn:contains(sessionScope.userSession.role.permission, 'J3') }">
							<li <c:if test='${menuActive eq 14 }'>class="active"</c:if> ><a href="#">Monthly Sales and Expense</a></li>
						</c:if>
						<c:if test="${fn:contains(sessionScope.userSession.role.permission, 'J4') }">
							<li <c:if test='${menuActive eq 15 }'>class="active"</c:if> ><a href="#">Yearly Sales and Expense</a></li>
						</c:if>
						<c:if test="${fn:contains(sessionScope.userSession.role.permission, 'J5') }">
							<li <c:if test='${menuActive eq 16 }'>class="active"</c:if> ><a href="#">Inventory</a></li>
						</c:if>
						<c:if test="${fn:contains(sessionScope.userSession.role.permission, 'J6') }">
							<li <c:if test='${menuActive eq 17 }'>class="active"</c:if> ><a href="#">E-Load Revenue</a></li>
						</c:if>
						<c:if test="${fn:contains(sessionScope.userSession.role.permission, 'J7') }">
							<li <c:if test='${menuActive eq 18 }'>class="active"</c:if> ><a href="#">Sales Revenue (Top High Sales Products)</a></li>
						</c:if>
						<c:if test="${fn:contains(sessionScope.userSession.role.permission, 'J8') }">
							<li <c:if test='${menuActive eq 19 }'>class="active"</c:if> ><a href="#">Sales Revenue (Top Low Sales Products)</a></li>
						</c:if>
					</ul>
				</div>