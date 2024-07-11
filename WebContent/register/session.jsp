<%@ page language="java" contentType="text/html; charset=UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="n3c" uri="http://icts.uiowa.edu/N3CRegistrationTagLib"%>
<%@ taglib prefix="sql" uri="http://java.sun.com/jsp/jstl/sql"%>
<%@ taglib prefix="util" uri="http://icts.uiowa.edu/tagUtil"%>

    <c:set var="user_email" scope="session">${attributes.get("email")[0]}</c:set>
	
	<c:if test="${n3c:adminExists(user_email)}">
        <c:set scope="session" var='admin' value='yes' />
	</c:if>

    <c:set var="first_name">${attributes.get("given_name")[0]}</c:set>
    <c:set var="last_name">${attributes.get("family_name")[0]}</c:set>
    <c:set var="institution">${attributes.get("org")[0]}</c:set>
    <c:set var="name">${attributes.get("name")[0]}</c:set>

    <c:if test="${n3c:registrationExists(user_email)}">
	    <n3c:registration email="${user_email}">
	        <n3c:registrationOfficialFirstName officialFirstName="${first_name}"/>
	        <n3c:registrationOfficialLastName officialLastName="${last_name}"/>
	        <n3c:registrationOfficialFullName officialFullName="${name}"/>
	        <n3c:registrationOfficialInstitution officialInstitution="${institution}"/>
	        <n3c:registrationUpdatedToNow/>
	    </n3c:registration>
	    <c:if test="${not empty admin}">
	        <c:redirect url="/admin" />
	    </c:if>
        <c:redirect url="../profile.jsp"/>
    </c:if>

    <n3c:registration email="${user_email}">
        <n3c:registrationOfficialFirstName officialFirstName="${first_name}"/>
        <n3c:registrationOfficialLastName officialLastName="${last_name}"/>
        <n3c:registrationOfficialFullName officialFullName="${name}"/>
        <n3c:registrationFirstName firstName="${first_name}"/>
        <n3c:registrationLastName lastName="${last_name}"/>
        <n3c:registrationInstitution institution="${institution}"/>
        <n3c:registrationOfficialInstitution officialInstitution="${institution}"/>
        <n3c:registrationCreatedToNow/>
        <n3c:registrationUpdatedToNow/>
    </n3c:registration>
    
    // check user email to organization primary email_domain

	<sql:query var="primaries" dataSource="jdbc/N3CRegistrationTagLib">
		select ror_id,email_domain from admin.organization where ? ~ (email_domain||'$') and email_domain != ''
		<sql:param>${user_email}</sql:param>
	</sql:query>
	<c:forEach items="${primaries.rows}" var="row" varStatus="rowCounter">
		<n3c:registration email="${user_email}">
			<n3c:organization rorId="${row.ror_id}">
				<n3c:affiliation/>
				<n3c:foreachDua var="x">
					<n3c:dua>
						<n3c:member groupName="${tag_dua.groupName}">
							<n3c:memberRequestedToNow/>
						</n3c:member>
					</n3c:dua>
				</n3c:foreachDua>
			</n3c:organization>
		</n3c:registration>
	    <c:redirect url="/register/"/>
	</c:forEach>
    
    // check user email to organization alternate_domains

	<sql:query var="secondaries" dataSource="jdbc/N3CRegistrationTagLib">
		select ror_id,alternate_domain from admin.alternate_domain where ? ~ (alternate_domain||'$') and alternate_domain != ''
		<sql:param>${user_email}</sql:param>
	</sql:query>
	<c:forEach items="${secondaries.rows}" var="row" varStatus="rowCounter">
		<n3c:registration email="${user_email}">
			<n3c:organization rorId="${row.ror_id}">
				<n3c:affiliation/>
				<n3c:foreachDua var="x">
					<n3c:dua>
						<n3c:member groupName="${tag_dua.groupName}">
							<n3c:memberRequestedToNow/>
						</n3c:member>
					</n3c:dua>
				</n3c:foreachDua>
			</n3c:organization>
		</n3c:registration>
	    <c:redirect url="/register/"/>
	</c:forEach>
    
    // inquire about citizen scientist status
    
    <c:redirect url="/register/"/>
