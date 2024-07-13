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

	<n3c:registration email="${param.email}">

		<div class="main-block">
			<div class="row flex-wrap">
				<div id="dua_data" class="col-1">&nbsp;</div>
				<div id="official" class="col-5">

					<h2>
						<n3c:registrationLastName/>, <n3c:registrationFirstName/>
					</h2>

					<table>
						<tbody>
							<tr>
								<th>Email</th>
								<td><n3c:registrationEmail /></td>
							</tr>
							<tr>
								<th>Official Full Name</th>
								<td><n3c:registrationOfficialFullName /></td>
							</tr>
							<tr>
								<th>Official Last Name</th>
								<td><n3c:registrationOfficialLastName /></td>
							</tr>
							<tr>
								<th>Official First Name</th>
								<td><n3c:registrationOfficialFirstName /></td>
							</tr>
							<tr>
								<th>Official Institution</th>
								<td><n3c:registrationOfficialInstitution /></td>
							</tr>
							<tr>
								<th>ORCiD</th>
								<td><n3c:registrationOrcidId /></td>
							</tr>
							<tr>
								<th>Enclave UID(s)</th>
								<td>
									<sql:query var="uid" dataSource="jdbc/N3CRegistrationTagLib">
										select unite_user_id from n3c_admin.user_binding where user_binding.orcid_id = ?
										<sql:param><n3c:registrationOrcidId /></sql:param>
									</sql:query>
									<c:forEach items="${uid.rows}" var="row" varStatus="rowCounter">
										${row.unite_user_id}<br>
									</c:forEach>
								</td>
							</tr>							
						</tbody>
					</table>
				</div>
				<div id="dua_data" class="col-5">
					<h2></h2>
					<table>
						<tbody>

							<tr>
								<th>Last Name</th>
								<td><n3c:registrationLastName /></td>
							</tr>
							<tr>
								<th>First Name</th>
								<td><n3c:registrationFirstName /></td>
							</tr>
							<tr>
								<th>Institution</th>
								<td><n3c:registrationInstitution /></td>
							</tr>
							<tr>
								<th>Date Created</th>
								<td><n3c:registrationCreated /></td>
							</tr>
							<tr>
								<th>Date Last Updated</th>
								<td><n3c:registrationUpdated /></td>
							</tr>
							<tr>
								<th>Date Emailed</th>
								<td><n3c:registrationEmailed /></td>
							</tr>
						</tbody>
					</table>
				</div>
				<div id="local" class="col-1">&nbsp;</div>
			</div>
			<div class="row flex-wrap">
				<div id="dua_data" class="col-1">&nbsp;</div>
				<div id="links" class="col-5">

					<h4>Institutional Affiliations</h4>
					<ul>
					<n3c:foreachAffiliation var="x">
						<n3c:affiliation>
							<n3c:organization rorId="${tag_affiliation.rorId}">
								<li><a href="organization.jsp?ror_id=${tag_affiliation.rorId}"><n3c:organizationName/></a>
							</n3c:organization>
						</n3c:affiliation>
					</n3c:foreachAffiliation>
					</ul>

					<h4>Citizen Scientist DUAs</h4>
					<ul>
					<n3c:foreachCitizenScientist var="x">
						<n3c:citizenScientist>
							<n3c:tenantGroup groupName="${tag_citizenScientist.groupName}">
								<li><n3c:tenantGroupGroupName/> (<n3c:citizenScientistDateExecuted/>)
							</n3c:tenantGroup>
						</n3c:citizenScientist>
					</n3c:foreachCitizenScientist>
					</ul>

					<h4>Institution DUAs</h4>
					<ul>
					<n3c:foreachMember var="x">
						<n3c:member>
							<n3c:tenantGroup groupName="${tag_member.groupName}">
								<li><n3c:tenantGroupGroupName/> (<n3c:memberRequested/>)
							</n3c:tenantGroup>
						</n3c:member>
					</n3c:foreachMember>
					</ul>

				</div>
				<div id="other" class="col-5">
					<h2></h2>
					<table>
						<tbody>

							<tr>
								<th>GSuite</th>
								<td><n3c:registrationGsuiteEmail /></td>
							</tr>
							<tr>
								<th>Slack</th>
								<td><n3c:registrationSlackId /></td>
							</tr>
							<tr>
								<th>GitHub</th>
								<td><n3c:registrationGithubId /></td>
							</tr>
							<tr>
								<th>Twitter</th>
								<td><n3c:registrationTwitterId /></td>
							</tr>
						</tbody>
					</table>
				</div>
				<div id="dua_data" class="col-1">&nbsp;</div>
			</div>
		</div>
	</n3c:registration>
	<jsp:include page="../footer.jsp" flush="true" />
</body>
</html>
