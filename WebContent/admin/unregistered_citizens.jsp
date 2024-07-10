<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="n3c" uri="http://icts.uiowa.edu/N3CRegistrationTagLib"%>
<%@ taglib prefix="util" uri="http://icts.uiowa.edu/tagUtil"%>
<%@ taglib prefix="sql" uri="http://java.sun.com/jsp/jstl/sql"%>

<h2>Orphan Citizen Scientists from Airtable</h2>

<n3c:foreachTenantGroup var="x">
	<n3c:tenantGroup>
		<h3><n3c:tenantGroupGroupName /></h3>

		<sql:query var="cs" dataSource="jdbc/N3CRegistrationTagLib">
			select email,first_name,last_name,date from airtable.citizens
			where type = ?
			and not exists (select email from admin.citizen_scientist)
			order by date desc
			<sql:param>${tag_tenantGroup.groupName == 'Tenant' ? 'CLINICAL' : 'COVID'}</sql:param>
		</sql:query>

		<table class="table table-hover">
			<thead>
				<tr>
					<td>Email</td>
					<td>Name</td>
					<td>Date Executed</td>
				</tr>
			</thead>
			<tbody>
				<c:forEach items="${cs.rows}" var="row" varStatus="rowCounter">
					<tr>
						<td>${row.email}</td>
						<td>${row.last_name}, ${row.first_name}</td>
						<td>${row.date}</td>
					</tr>
				</c:forEach>
			</tbody>
		</table>
	</n3c:tenantGroup>
</n3c:foreachTenantGroup>
