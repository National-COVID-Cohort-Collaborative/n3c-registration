<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="n3c" uri="http://icts.uiowa.edu/N3CRegistrationTagLib"%>
<%@ taglib prefix="util" uri="http://icts.uiowa.edu/tagUtil"%>
<%@ taglib prefix="sql" uri="http://java.sun.com/jsp/jstl/sql"%>

<h2>New Organizations from Airtable</h2>

<sql:query var="orgs" dataSource="jdbc/N3CRegistrationTagLib">
	select ror_id, name, substring(email_domain from '.*@(.*)') as email_domain from
		(select institutionid as ror_id, institutionname as name, duacontactemail as email_domain from airtable.covid_dua_master
		 union
		 select institutionid as ror_id, institutionname as name, tenantduacontactemail as email_domain from airtable.tenant_dua_master
		 ) as foo
	where ror_id not in (select ror_id from admin.organization)
	order by name
</sql:query>

<table class="table table-hover">
	<thead>
		<tr>
			<td>ROR ID</td>
			<td>Name</td>
			<td>Email Domain</td>
		</tr>
	</thead>
	<tbody>
		<c:forEach items="${orgs.rows}" var="row" varStatus="rowCounter">
			<tr>
				<td>${row.ror_id}</td>
				<td><a href="bind_organization.jsp?id=${row.ror_id}&name=${row.name}&email=${row.email_domain}">${row.name}</a></td>
				<td>${row.email_domain}</td>
			</tr>
		</c:forEach>
	</tbody>
</table>
