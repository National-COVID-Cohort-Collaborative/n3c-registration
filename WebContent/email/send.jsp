<%@ page language="java" contentType="text/html; charset=UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="n3c" uri="http://icts.uiowa.edu/N3CRegistrationTagLib"%>
<%@ taglib prefix="mail" uri="http://slis.uiowa.edu/mailtaglib"%>
<%@ taglib prefix="sql" uri="http://java.sun.com/jsp/jstl/sql"%>

<n3c:registration email="${user_email}">
	<sql:query var="rors" dataSource="jdbc/N3CRegistrationTagLib">
		select email from palantir.tenant_user where email = ? and (citizen_scientist or ror_id in (select institutionid from palantir.tenant_organization where tenantduaexecuted is not null));
		<sql:param><n3c:registrationEmail /></sql:param>
	</sql:query>
	<c:forEach items="${rors.rows}" var="row" varStatus="rowCounter">
		<c:set var='valid' value='yes' />
	</c:forEach>

	<c:if test="${empty valid}">
		<sql:query var="rors" dataSource="jdbc/N3CRegistrationTagLib">
			select email from palantir.n3c_user
			where email = ?
			  and (
			  	ror_id in (select institutionid from palantir.tenant_organization where dua_signed is null)
			  	or (
			  		ror_id in (select id from ror.organization)
			  	and ror_id not in (select institutionid from palantir.tenant_organization)
			  	)
			  	or (
			  		email like '%.edu'
			  	and ror_id not in (select institutionid from palantir.tenant_organization)
			  	)
			  );
			<sql:param><n3c:registrationEmail /></sql:param>
		</sql:query>
		<c:forEach items="${rors.rows}" var="row" varStatus="rowCounter">
			<c:set var='dua_pending' value='yes' />
		</c:forEach>
	</c:if>
	
	<c:if test="${empty valid and empty dua_pending}">
		<sql:query var="rors" dataSource="jdbc/N3CRegistrationTagLib">
			select email from palantir.n3c_user where email = ? and not citizen_scientist and ror_id not in (select institutionid from palantir.tenant_organization);
			<sql:param><n3c:registrationEmail /></sql:param>
		</sql:query>
		<c:forEach items="${rors.rows}" var="row" varStatus="rowCounter">
			<c:set var='citizen_pending' value='yes' />
		</c:forEach>
	</c:if>
	
	<c:choose>
		<c:when test="${not empty valid}">
			<mail:message host="gmail">
				<mail:fromAddress address="noreply@ctsa.io" name="The N3C Team" />
				<mail:recipientAddress address="${user_email}" name="${tag_registration.getFirstName()} ${tag_registration.getLastName()}" />
				<mail:bccAddress address="david-eichmann@uiowa.edu"/>
                <mail:bccAddress address="n3c-reg@ctsa.io"/>
				<mail:subject>N3C Registration in Process</mail:subject>
				<mail:htmlBody>
					<jsp:include page="in_process.jsp"/>
				</mail:htmlBody>
			</mail:message>
		</c:when>
		<c:when test="${empty valid and not empty dua_pending}">
			<mail:message host="gmail">
				<mail:fromAddress address="noreply@ctsa.io" name="The N3C Team" />
				<mail:recipientAddress address="${user_email}" name="${tag_registration.getFirstName()} ${tag_registration.getLastName()}" />
                <mail:bccAddress address="david-eichmann@uiowa.edu"/>
				<mail:subject>N3C Registration Pending</mail:subject>
				<mail:htmlBody>
					<jsp:include page="dua_pending.jsp"/>
				</mail:htmlBody>
			</mail:message>
		</c:when>
		<c:when test="${empty valid and empty dua_pending and not empty citizen_pending}">
			<mail:message host="gmail">
				<mail:fromAddress address="noreply@ctsa.io" name="The N3C Team" />
				<mail:recipientAddress address="${user_email}" name="${tag_registration.getFirstName()} ${tag_registration.getLastName()}" />
                <mail:bccAddress address="david-eichmann@uiowa.edu"/>
				<mail:subject>N3C Registration Pending</mail:subject>
				<mail:htmlBody>
					<jsp:include page="citizen_pending.jsp"/>
				</mail:htmlBody>
			</mail:message>
		</c:when>
		<c:otherwise>
			<mail:message host="gmail">
				<mail:fromAddress address="noreply@ctsa.io" name="The N3C Team" />
				<mail:recipientAddress address="${user_email}" name="${tag_registration.getFirstName()} ${tag_registration.getLastName()}" />
                <mail:bccAddress address="david-eichmann@uiowa.edu"/>
				<mail:subject>N3C Registration in Problem Resolution</mail:subject>
				<mail:htmlBody>
					<jsp:include page="problem_resolution.jsp"/>
				</mail:htmlBody>
			</mail:message>
		</c:otherwise>
	</c:choose>
	<n3c:registrationEmailedToNow/>
</n3c:registration>
