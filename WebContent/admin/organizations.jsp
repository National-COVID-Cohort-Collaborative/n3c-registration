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

				<table>
					<thead>
						<tr>
							<th>ROR ID</th>
							<th>ROR Name</th>
							<th>Email Domain</th>
							<th>InCommon ID</th>
							<th>InCommon Name</th>
							<th>Matched Email Domains</th>
							<th>Unmatched Email Domains</th>
						</tr>
					</thead>
					<tbody>
						<sql:query var="orgs" dataSource="jdbc/N3CRegistrationTagLib">
							select
								foo.*,
								(select count(*) from admin.organization natural join admin.affiliation
								 where organization.ror_id=foo.ror_id
								   and (lower(email) ~ lower(email_domain)
								   		or exists (select alternate_domain from admin.alternate_domain
								   			where lower(email) ~ lower(alternate_domain)
								   			  and foo.ror_id = alternate_domain.ror_id))) as matched_email_count,
								(select count(*) from admin.organization natural join admin.affiliation
								 where organization.ror_id=foo.ror_id
								   and (lower(email) !~ lower(email_domain)
								   		and not exists (select alternate_domain from admin.alternate_domain
								   			where lower(email) ~ lower(alternate_domain)
								   			  and foo.ror_id = alternate_domain.ror_id))) as unmatched_email_count
							from admin.organization as foo order by name;
						</sql:query>
						<c:forEach items="${orgs.rows}" var="row" varStatus="rowCounter">
							<tr>
								<td>${row.ror_id}</td>
								<td><a href="organization.jsp?ror_id=${row.ror_id}">${row.name}</a></td>
								<td>${row.email_domain}</td>
								<td>${row.incommon_id}</td>
								<td>${row.incommon_name}</td>
								<td>${row.matched_email_count}</td>
								<td>${row.unmatched_email_count}</td>
							</tr>
						</c:forEach>
					</tbody>
				</table>
			</div>
			<div id="dua_data" class="col-1">&nbsp;</div>
		</div>
	</div>
</body>
</html>
