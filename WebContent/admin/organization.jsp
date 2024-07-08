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

	<n3c:organization rorId="${param.ror_id}">

		<div class="main-block">
			<div class="row flex-wrap">
				<div id="dua_data" class="col-1">&nbsp;</div>
				<div id="dua_data" class="col-5">

					<h2>
						<n3c:organizationName />
					</h2>

					<table>
						<tbody>
							<tr>
								<th>ROR ID</th>
								<td><n3c:organizationRorId /></td>
							</tr>
							<tr>
								<th>ROR Name</th>
								<td><n3c:organizationName /></td>
							</tr>
							<tr>
								<th>Email Domain</th>
								<td><n3c:organizationEmailDomain /></td>
							</tr>
							<tr>
								<th>InCommon ID</th>
								<td><n3c:organizationIncommonId /></td>
							</tr>
							<tr>
								<th>InCommon Name</th>
								<td><n3c:organizationIncommonName /></td>
							</tr>
						</tbody>
					</table>
					<h4>User Roster</h4>
					<ul>
					<n3c:foreachAffiliation var="x" useRegistration="true" sortCriteria="last_name">
						<n3c:affiliation>
							<n3c:registration email="${tag_affiliation.email}">
								<li><n3c:registrationLastName/>, <n3c:registrationFirstName/> (<n3c:registrationEmail/>)
							</n3c:registration>
						</n3c:affiliation>
					</n3c:foreachAffiliation>
					</ul>
				</div>
				<div id="dua_data" class="col-5">
					<h4>Update Email Domain</h4>
					<form action="update_email_domain.jsp">
						<input type="hidden" name="ror_id" value="<n3c:organizationRorId/>">
						<input type="text" name="email_domain" value="<n3c:organizationEmailDomain/>">
					</form>
					<h4>Alternate Email Domains</h4>
					<ul>
					<n3c:foreachAlternateDomain var="x">
						<n3c:alternateDomain>
							<li><n3c:alternateDomainAlternateDomain/>
						</n3c:alternateDomain>
					</n3c:foreachAlternateDomain>
					</ul>
					<form action="add_alternate_domain.jsp">
						<input type="hidden" name="ror_id" value="<n3c:organizationRorId/>">
						Add a new alternate: <input type="text" name="alternate_domain" value="<n3c:organizationEmailDomain/>">
					</form>
					<h4>Unmatched User Email Domains</h4>
					<sql:query var="unmatched" dataSource="jdbc/N3CRegistrationTagLib">
							select email,first_name,last_name from admin.registration natural join admin.affiliation natural join admin.organization
							where organization.ror_id = ?
							  and lower(email) !~ lower(email_domain)
							  and not exists (select alternate_domain from admin.alternate_domain
								   				where lower(email) ~ lower(alternate_domain)
								   			  	and organization.ror_id = alternate_domain.ror_id)
							order by last_name,first_name;
							<sql:param>${param.ror_id}</sql:param>
						</sql:query>
						<ul>
						<c:forEach items="${unmatched.rows}" var="row" varStatus="rowCounter">
							<li>${row.last_name}, ${row.first_name} (${row.email})
						</c:forEach>
						</ul>
				</div>
				<div id="dua_data" class="col-1">&nbsp;</div>
			</div>
		</div>
	</n3c:organization>
</body>
</html>
