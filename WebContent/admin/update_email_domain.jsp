<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="sql" uri="http://java.sun.com/jsp/jstl/sql"%>
<%@ taglib prefix="n3c" uri="http://icts.uiowa.edu/N3CRegistrationTagLib"%>
<%@ taglib prefix="util" uri="http://icts.uiowa.edu/tagUtil"%>

<n3c:organization rorId="${param.ror_id}">
	<n3c:organizationEmailDomain emailDomain="${param.email_domain}"/>
</n3c:organization>

<c:redirect url="organization.jsp">
	<c:param name="ror_id" value="${param.ror_id}"/>
</c:redirect>
