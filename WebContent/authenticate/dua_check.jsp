<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="n3c" uri="http://icts.uiowa.edu/N3CRegistrationTagLib"%>
<%@ taglib prefix="util" uri="http://icts.uiowa.edu/tagUtil"%>
<%@ taglib prefix="sql" uri="http://java.sun.com/jsp/jstl/sql"%>

<h2>DUA check: ${param.email}</h2>

<sql:query var="duas" dataSource="jdbc/N3CRegistrationTagLib">
	select ror_id,ror_name from n3c_admin.dua_organization where ? ~ (email_domain||'$')
	<sql:param>${param.email}</sql:param>
</sql:query>
<n3c:foreachTenantGroup var="x">
	<n3c:tenantGroup>
		<h3><n3c:tenantGroupDescription /></h3>
		<c:forEach items="${duas.rows}" var="row" varStatus="rowCounter">
			<c:choose>
				<c:when test="${n3c:duaExists(row.ror_id,tag_tenantGroup.groupName)}">
					<n3c:dua rorId="${row.ror_id}" groupName="${tag_tenantGroup.groupName}" >
						<n3c:organization rorId="${tag_dua.rorId}">
							<p><b><n3c:organizationName/></b> <n3c:tenantGroupPositiveMessage/> <n3c:duaDateExecuted/>.</p>
						</n3c:organization>
					</n3c:dua>
				</c:when>
				<c:otherwise>
					<n3c:tenantGroupNegativeMessage/>
				</c:otherwise>
			</c:choose>
		</c:forEach>
		<c:if test="${n3c:tenantGroupHasTenant(tag_tenantGroup.groupName)}">
			<ul>
				<n3c:foreachTenant var="x">
					<n3c:tenant>
						<li><n3c:tenantDescription/>
					</n3c:tenant>
				</n3c:foreachTenant>
			</ul>
		</c:if>
	</n3c:tenantGroup>
</n3c:foreachTenantGroup>
