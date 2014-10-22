<%@page language="java" contentType="text/html" %>
<%@include file="../common/taglib.jsp"%>

				<div class="col-sm-3 col-md-2 sidebar">
					<ul class="nav nav-sidebar">
						<c:if test="${fn:contains(sessionScope.userSession.role.permission, 'A') || fn:contains(sessionScope.userSession.role.permission, 'B') }">
							<li role="presentation" class="dropdown-header">ADMIN</li>
						</c:if>
						<c:if test="${fn:contains(sessionScope.userSession.role.permission, 'A') }">
							<li <c:if test='${menuActive eq 1 }'>class="active"</c:if> ><a href="users.htm">Users</a></li>
						</c:if>
						<c:if test="${fn:contains(sessionScope.userSession.role.permission, 'B') }">
							<li <c:if test='${menuActive eq 2 }'>class="active"</c:if> ><a href="accessRights.htm">Access Rights</a></li>
						</c:if>
					</ul>
					<ul class="nav nav-sidebar">
						<c:if test="${fn:contains(sessionScope.userSession.role.permission, 'E') }">
							<li role="presentation" class="dropdown-header">EMPLOYEE</li>
						</c:if>
						<c:if test="${fn:contains(sessionScope.userSession.role.permission, 'E1') }">
							<li <c:if test='${menuActive eq 6 }'>class="active"</c:if> ><a href="checkIn.htm">Duty Check-In</a></li>
						</c:if>
						<%-- <c:if test="${fn:contains(sessionScope.userSession.role.permission, 'E2') }">
							<li <c:if test='${menuActive eq 17 }'>class="active"</c:if> ><a href="">Daily Journal</a></li>
						</c:if> --%>
						<c:if test="${fn:contains(sessionScope.userSession.role.permission, 'E3') }">
							<c:choose>
								<c:when test="${sessionScope.onDutySession.onDutyStatus eq '0' }">
									<li <c:if test='${menuActive eq 20 }'>class="active"</c:if> ><a href="checkOut.htm">Duty Check-Out</a></li>
								</c:when>
								<c:otherwise>
									<li <c:if test='${menuActive eq 20 }'>class="active"</c:if> ><a href="#" onclick="alert('You need to check in first before checking out.');">Duty Check-Out</a></li>
								</c:otherwise>
							</c:choose>
						</c:if>
					</ul>
					<ul class="nav nav-sidebar">
						<c:if test="${fn:contains(sessionScope.userSession.role.permission, 'C') ||
										fn:contains(sessionScope.userSession.role.permission, 'D') ||
										fn:contains(sessionScope.userSession.role.permission, 'F') ||
										fn:contains(sessionScope.userSession.role.permission, 'H') ||
										fn:contains(sessionScope.userSession.role.permission, 'I') ||
										fn:contains(sessionScope.userSession.role.permission, 'G2')}">
							<li role="presentation" class="dropdown-header">OPERATION</li>
						</c:if>
						<c:if test="${fn:contains(sessionScope.userSession.role.permission, 'C') }">
							<%-- <c:choose>
								<c:when test="${sessionScope.onDutySession.onDutyStatus eq '0' }"> --%>
									<li <c:if test='${menuActive eq 3 }'>class="active"</c:if> ><a href="category.htm">Category</a></li>
								<%-- </c:when>
								<c:otherwise>
									<li <c:if test='${menuActive eq 3 }'>class="active"</c:if> ><a href="#" onclick="alert('You need to check in first before proceeding.');">Category</a></li>
								</c:otherwise>
							</c:choose> --%>
						</c:if>
						<c:if test="${fn:contains(sessionScope.userSession.role.permission, 'D') }">
							<%-- <c:choose>
								<c:when test="${sessionScope.onDutySession.onDutyStatus eq '0' }"> --%>
									<li <c:if test='${menuActive eq 4 }'>class="active"</c:if> ><a href="product.htm">Products</a></li>
								<%-- </c:when>
								<c:otherwise>
									<li <c:if test='${menuActive eq 4 }'>class="active"</c:if> ><a href="#" onclick="alert('You need to check in first before proceeding.');">Products</a></li>
								</c:otherwise>
							</c:choose> --%>
						</c:if>
						<c:if test="${fn:contains(sessionScope.userSession.role.permission, 'F') }">
							<c:choose>
								<c:when test="${sessionScope.onDutySession.onDutyStatus eq '0'}">
									<li <c:if test='${menuActive eq 5 }'>class="active"</c:if> ><a href="inventory.htm">Inventory</a></li>
								</c:when>
								<c:when test="${!(fn:contains(sessionScope.userSession.role.permission, 'E'))}">
									<li <c:if test='${menuActive eq 5 }'>class="active"</c:if> ><a href="inventory.htm">Inventory</a></li>
								</c:when>
								<c:otherwise>
									<li <c:if test='${menuActive eq 5 }'>class="active"</c:if> ><a href="#" onclick="alert('You need to check in first before proceeding.');">Inventory</a></li>
								</c:otherwise>
							</c:choose>
						</c:if>
						<c:if test="${fn:contains(sessionScope.userSession.role.permission, 'H') }">
							<c:choose>
								<c:when test="${sessionScope.onDutySession.onDutyStatus eq '0' }">
									<li <c:if test='${menuActive eq 7 }'>class="active"</c:if> ><a href="stocksonhand.htm">Stocks on Hand</a></li>
								</c:when>
								<c:otherwise>
									<li <c:if test='${menuActive eq 7 }'>class="active"</c:if> ><a href="#" onclick="alert('You need to check in first before proceeding.');">Stocks on Hand</a></li>
								</c:otherwise>
							</c:choose>
						</c:if>
						<c:if test="${fn:contains(sessionScope.userSession.role.permission, 'I') }">
							<c:choose>
								<c:when test="${sessionScope.onDutySession.onDutyStatus eq '0' }">
									<li <c:if test='${menuActive eq 8 }'>class="active"</c:if> ><a href="dailySalesExpenses.htm">Daily Sales and Expenses</a></li>
								</c:when>
								<c:otherwise>
									<li <c:if test='${menuActive eq 8 }'>class="active"</c:if> ><a href="#" onclick="alert('You need to check in first before proceeding.');">Daily Sales and Expenses</a></li>
								</c:otherwise>
							</c:choose>
						</c:if>
						<c:if test="${fn:contains(sessionScope.userSession.role.permission, 'G') }">
							<c:choose>
								<c:when test="${sessionScope.onDutySession.onDutyStatus eq '0' }">
									<li <c:if test='${menuActive eq 9 }'>class="active"</c:if> ><a href="eloadDailyBalance.htm">E-Load Daily Balances</a></li>
								</c:when>
								<c:otherwise>
									<li <c:if test='${menuActive eq 9 }'>class="active"</c:if> ><a href="#" onclick="alert('You need to check in first before proceeding.');">E-Load Daily Balances</a></li>
								</c:otherwise>
							</c:choose>
						</c:if>
						<c:if test="${fn:contains(sessionScope.userSession.role.permission, 'G') }">
							<c:choose>
								<c:when test="${sessionScope.onDutySession.onDutyStatus eq '0' }">
									<li <c:if test='${menuActive eq 10 }'>class="active"</c:if> ><a href="eloadDailySales.htm">E-Load Daily Sales</a></li>
								</c:when>
								<c:otherwise>
									<li <c:if test='${menuActive eq 10 }'>class="active"</c:if> ><a href="#" onclick="alert('You need to check in first before proceeding.');">E-Load Daily Sales</a></li>
								</c:otherwise>
							</c:choose>
						</c:if>
						<c:if test="${fn:contains(sessionScope.userSession.role.permission, 'G') }">
							<c:choose>
								<c:when test="${sessionScope.onDutySession.onDutyStatus eq '0' }">
									<li <c:if test='${menuActive eq 11 }'>class="active"</c:if> ><a href="eloadPrices.htm">E-Load Prices</a></li>
								</c:when>
								<c:otherwise>
									<li <c:if test='${menuActive eq 11 }'>class="active"</c:if> ><a href="#" onclick="alert('You need to check in first before proceeding.');">E-Load Prices</a></li>
								</c:otherwise>
							</c:choose>
						</c:if>
					</ul>
					<ul class="nav nav-sidebar">
						<c:if test="${fn:contains(sessionScope.userSession.role.permission, 'J') }">
							<li role="presentation" class="dropdown-header">REPORTS</li>
						</c:if>
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