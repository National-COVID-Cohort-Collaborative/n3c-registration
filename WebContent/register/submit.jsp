<%@ page language="java" contentType="text/html; charset=UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="n3c" uri="http://icts.uiowa.edu/N3CRegistrationTagLib"%>
<%@ taglib prefix="util" uri="http://icts.uiowa.edu/tagUtil"%>
<c:if test="${empty user_email}">
    <c:set scope="session" var="not_logged_in" value="t"/>
    <c:redirect url="index.jsp"/>
</c:if>

<n3c:registration email="${user_email}">
	<n3c:registrationOfficialFirstName officialFirstName="${param.official_first_name}" />
	<n3c:registrationOfficialLastName officialLastName="${param.official_last_name}" />
	<n3c:registrationOfficialFullName officialFullName="${param.official_full_name}" />
	<n3c:registrationFirstName firstName="${param.first_name}" />
	<n3c:registrationLastName lastName="${param.last_name}" />
	<n3c:registrationInstitution institution="${param.institution}" />
	<n3c:registrationOrcidId orcidId="${param.orcid}" />
	<n3c:registrationGsuiteEmail gsuiteEmail="${param.gsuite}" />
	<n3c:registrationSlackId slackId="${param.slack}" />
	<n3c:registrationGithubId githubId="${param.github}" />
	<n3c:registrationTwitterId twitterId="${param.twitter}" />
	<n3c:registrationUpdatedToNow />
</n3c:registration>

<c:if test="${not util:regexMatches(param.orcid,'^([0-9]{4}-){3}[0-9]{3}[0-9X]$')}">
    <c:redirect url="register.jsp">
    	<c:param name="alert">An ORCiD ID is required.</c:param>
    </c:redirect>
</c:if>

<c:redirect url="../profile.jsp" />
