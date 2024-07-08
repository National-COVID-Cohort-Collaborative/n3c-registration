<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>
<%@ taglib prefix="n3c" uri="http://icts.uiowa.edu/N3CRegistrationTagLib"%>
<%@ taglib prefix="util" uri="http://icts.uiowa.edu/tagUtil"%>
<%@ taglib prefix="sql" uri="http://java.sun.com/jsp/jstl/sql"%>

<n3c:organization rorId="${param.ror_id}">
	<n3c:organizationName name='${param.ror_name}'/>
	<n3c:organizationEmailDomain emailDomain="${param.email_domain}"/>
	<c:if test="${not empty param.incommon_id}">
		<c:set var="incommon" value="${fn:split(param.incommon_id, '>')}"/>
		<n3c:organizationIncommonId incommonId="${incommon[0]}" />
		<n3c:organizationIncommonName incommonName="${incommon[1]}"/>
	</c:if>
</n3c:organization>

<n3c:foreachTenantGroup var="x">
	<n3c:tenantGroup>
		<sql:query var="tenant" dataSource="jdbc/N3CRegistrationTagLib">
			select duaexecuted from airtable.${tag_tenantGroup.groupName}_dua_master where institutionid = ?
			<sql:param>${param.ror_id}</sql:param>
		</sql:query>
		<c:forEach items="${tenant.rows}" var="row" varStatus="rowCounter">
			<n3c:dua rorId="${param.ror_id}">
				<n3c:duaDateExecuted dateExecuted="${row.duaexecuted}"/>
			</n3c:dua>
		</c:forEach>
	</n3c:tenantGroup>
</n3c:foreachTenantGroup>

<c:redirect url="index.jsp"/>
