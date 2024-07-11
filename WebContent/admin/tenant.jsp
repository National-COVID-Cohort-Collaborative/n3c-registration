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
				<n3c:tenantGroup groupName="${param.group}">
					<h2>Tenant Group: <n3c:tenantGroupGroupName/></h2>
					
					<p><n3c:tenantGroupDescription/></p>
					
					<h3>Tenants:</h3>
					<ul>
					<n3c:foreachTenant var="x">
						<n3c:tenant>
							<li><n3c:tenantTenantName/> - <n3c:tenantDescription/>
						</n3c:tenant>
					</n3c:foreachTenant>
					</ul>
					
					<h3>Institutional DUAs</h3>
					<ul>
					<n3c:foreachDua var="x" useOrganization="true" sortCriteria="name">
						<n3c:dua>
							<n3c:organization rorId = "${tag_dua.rorId}">
								<li><a href="<util:applicationRoot/>/admin/organization.jsp?ror_id=<n3c:organizationRorId/>"><n3c:organizationName/></a>
							</n3c:organization>
						</n3c:dua>
					</n3c:foreachDua>
					</ul>
					
					<h3>Citizen Scientist DUAs</h3>
					<ul>
					<n3c:foreachCitizenScientist var="x" useRegistration="true" sortCriteria="last_name,first_name">
						<n3c:citizenScientist>
							<n3c:registration email = "${tag_citizenScientist.email}">
								<li><a href="<util:applicationRoot/>/admin/user.jsp?email=<n3c:registrationEmail/>"><n3c:registrationLastName/>, <n3c:registrationFirstName/></a>
							</n3c:registration>
						</n3c:citizenScientist>
					</n3c:foreachCitizenScientist>
					</ul>

				</n3c:tenantGroup>
			</div>
			<div id="dua_data" class="col-1">&nbsp;</div>
		</div>
	</div>
	<jsp:include page="../footer.jsp" flush="true" />
</body>
</html>
