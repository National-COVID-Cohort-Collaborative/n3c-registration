<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="n3c" uri="http://icts.uiowa.edu/N3CRegistrationTagLib"%>
<%@ taglib prefix="sql" uri="http://java.sun.com/jsp/jstl/sql"%>
<%@ taglib prefix="util" uri="http://icts.uiowa.edu/tagUtil"%>
<!DOCTYPE html>

<html>
<jsp:include page="../head.jsp" flush="true" />

<style type="text/css" media="all">
@import "../resources/n3c_login_style.css";
</style>

<body>

	<jsp:include page="../header.jsp" flush="true" />

	<div class="main-block">
		<c:if test="${empty param.pattern }">
			<form name="incommon" method='POST' action='bind_organization.jsp'>
					<table class="table table-hover">
						<tbody>
								<tr>
								<th>ROR ID</th>
									<td><input name="id" value="${param.id}"></td>
								</tr>
								<tr>
								<th>ROR Name</th>
									<td><input name="name" value="${param.name}" size=40></td>
								</tr>
								<tr>
								<th>Email Domain</th>
									<td><input name="email" value="${param.email}"></td>
								</tr>
								<tr>
								<th>InCommon Pattern</th>
									<td><input name="pattern" value=""></td>
								</tr>
						</tbody>
					</table>
				<div style="text-align: left;">
					<button class="btn btn-n3c" type="submit" name="action" value="submit">Submit</button>
				</div>
			</form>
		</c:if>
		<c:if test="${not empty param.pattern }">
			<form name="incommon" method='POST' action='submit_organization.jsp'>
			<div class="row">
				<div class="col-6">
					<h3>DUA Master</h3>
					<table class="table table-hover">
						<tbody>
								<tr>
								<th>ROR ID</th>
									<td><input name="ror_id" value="${param.id}"></td>
								</tr>
								<tr>
								<th>ROR Name</th>
									<td><input name="ror_name" value="${param.name}" size=40></td>
								</tr>
								<tr>
								<th>Email Domain</th>
									<td><input name="email_domain" value="${param.email}"></td>
								</tr>
						</tbody>
					</table>
				</div>

				<div class="col-6">
					<h3>InCommon Federation</h3>
					<sql:query var="registration" dataSource="jdbc/N3CRegistrationTagLib">
				        select id, display_name
				        from incommon.organization
				        where display_name ~ ?
				        and federation = '1'
				        order by 2;
				        <sql:param>${param.pattern}</sql:param>
					</sql:query>
					<table class="table table-hover">
						<thead>
							<tr>
								<th></th>
								<th>InCommon ID</th>
								<th>InCommon Name</th>
							</tr>
						</thead>
						<tbody>
							<c:forEach items="${registration.rows}" var="row" varStatus="rowCounter">
								<tr>
									<td><input type="checkbox" name="incommon_id" value="${row.id}>${row.display_name}"></td>
									<td>${row.id}</td>
									<td>${row.display_name}</td>
								</tr>
							</c:forEach>
						</tbody>
					</table>
				</div>
			</div>
				<div style="text-align: left;">
					<button class="btn btn-n3c" type="submit" name="action" value="submit">Submit</button>
				</div>
				<input type="hidden" name="institution" value="${param.institution}">
			</form>
		</c:if>
	</div>
</body>
</html>
