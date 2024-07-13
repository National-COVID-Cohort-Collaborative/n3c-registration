<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="sql" uri="http://java.sun.com/jsp/jstl/sql"%>
<%@ taglib prefix="n3c" uri="http://icts.uiowa.edu/N3CRegistrationTagLib"%>
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
		<div class="row flex-wrap">
			<div id="dua_data" class="col-1">&nbsp;</div>
			<div id="dua_data" class="col-10">

				<h2>Organizations</h2>

				<table id="roster" class="table table-hover">
					<thead>
						<tr>
							<th>Institution</th>
							<th>Name</th>
							<th>Email</th>
							<th>ORCiD</th>
							<th>Created</th>
							<th>Updated</th>
						</tr>
					</thead>
					<tbody>
						<sql:query var="orgs" dataSource="jdbc/N3CRegistrationTagLib">
							select
								email,
								last_name,
								first_name,
								orcid_id,
								ror_id,
								name,
								created,
								updated
							from admin.registration natural join admin.affiliation natural join admin.organization order by name, last_name, first_name;
						</sql:query>
						<c:forEach items="${orgs.rows}" var="row" varStatus="rowCounter">
							<tr>
								<td><a href="organization.jsp?ror_id=${row.ror_id}">${row.name}</a></td>
								<td><a href="user.jsp?email=${row.email}">${row.last_name}, ${row.first_name}</a></td>
								<td>${row.email}</td>
								<td>${row.orcid_id}</td>
								<td>${row.created}</td>
								<td>${row.updated}</td>
							</tr>
						</c:forEach>
					</tbody>
				</table>
			</div>
			<div id="dua_data" class="col-1">&nbsp;</div>
		</div>
	</div>
	<jsp:include page="../footer.jsp" flush="true" />
	<script type="text/javascript">
		new DataTable("#roster");
	</script>
</body>
</html>
