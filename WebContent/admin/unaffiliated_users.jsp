<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="n3c" uri="http://icts.uiowa.edu/N3CRegistrationTagLib"%>
<%@ taglib prefix="util" uri="http://icts.uiowa.edu/tagUtil"%>
<%@ taglib prefix="sql" uri="http://java.sun.com/jsp/jstl/sql"%>

<h2>Unaffiliated Users</h2>

<sql:query var="users" dataSource="jdbc/N3CRegistrationTagLib">
	select email,first_name,last_name,institution,created from admin.registration
	where email not in (select email from admin.affiliation)
	and email not in (select email from admin.citizen_scientist)
	order by created desc
</sql:query>

<table class="table table-hover">
	<thead>
		<tr>
			<td>Email</td>
			<td>Name</td>
			<td>Institution</td>
			<td>Created</td>
		</tr>
	</thead>
	<tbody>
		<c:forEach items="${users.rows}" var="row" varStatus="rowCounter">
			<tr>
				<td>${row.email}</td>
				<td><a href="bind_affiliation.jsp?email=${row.email}">${row.last_name}, ${row.first_name}</a></td>
				<td>${row.institution}</td>
				<td>${row.created}</td>
			</tr>
		</c:forEach>
	</tbody>
</table>
