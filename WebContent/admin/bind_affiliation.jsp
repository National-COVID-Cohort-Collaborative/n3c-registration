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
	
	<n3c:registration email="${param.email}">

	<div class="main-block">
			<form name="incommon" method='POST' action='submit_affiliation.jsp'>
			<div class="row">
				<div class="col-6">
					<h3>Registration</h3>
					<table class="table table-hover">
						<tbody>
								<tr>
								<th>Email</th>
									<td><n3c:registrationEmail/></td>
								</tr>
								<tr>
								<th>Name</th>
									<td><n3c:registrationLastName/>, <n3c:registrationFirstName/></td>
								</tr>
						</tbody>
					</table>
				</div>

				<div class="col-6">
					<h3>Signatory Organizations</h3>
					<sql:query var="signatories" dataSource="jdbc/N3CRegistrationTagLib">
				        select ror_id, name, email_domain
				        from admin.organization
				        where ? ~* (email_domain||'$')
				        and email_domain != ''
				        order by 2;
				        <sql:param>${param.email}</sql:param>
					</sql:query>
					<table class="table table-hover">
						<thead>
							<tr>
								<th></th>
								<th>ROR ID</th>
								<th>Name</th>
								<th>Email Domain</th>
							</tr>
						</thead>
						<tbody>
							<c:forEach items="${signatories.rows}" var="row" varStatus="rowCounter">
								<tr>
									<td><input type="checkbox" name="ror_id" value="${row.ror_id}"></td>
									<td>${row.ror_id}</td>
									<td>${row.name}</td>
									<td>${row.email_domain}</td>
								</tr>
							</c:forEach>
						</tbody>
					</table>

					<h3>Signatory Organization Domain Aliases</h3>
					<sql:query var="signatories" dataSource="jdbc/N3CRegistrationTagLib">
				        select ror_id, name, alternate_domain
				        from admin.organization natural join admin.alternate_domain
				        where ? ~* (alternate_domain||'$')
				        and alternate_domain != ''
				        order by 2;
				        <sql:param>${param.email}</sql:param>
					</sql:query>
					<table class="table table-hover">
						<thead>
							<tr>
								<th></th>
								<th>ROR ID</th>
								<th>Name</th>
								<th>Email Domain</th>
							</tr>
						</thead>
						<tbody>
							<c:forEach items="${signatories.rows}" var="row" varStatus="rowCounter">
								<tr>
									<td><input type="checkbox" name="ror_id" value="${row.ror_id}"></td>
									<td>${row.ror_id}</td>
									<td>${row.name}</td>
									<td>${row.alternate_domain}</td>
								</tr>
							</c:forEach>
						</tbody>
					</table>
				</div>
			</div>
				<div style="text-align: left;">
					<button class="btn btn-n3c" type="submit" name="action" value="submit">Submit</button>
				</div>
				<input type="hidden" name="email" value="${param.email}">
			</form>
	</div>
	</n3c:registration>
</body>
</html>
