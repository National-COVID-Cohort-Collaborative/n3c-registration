<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="n3c" uri="http://icts.uiowa.edu/N3CRegistrationTagLib"%>
<%@ taglib prefix="util" uri="http://icts.uiowa.edu/tagUtil"%>
<%@ taglib prefix="sql" uri="http://java.sun.com/jsp/jstl/sql"%>

<h2>UNA check: ${param.email}</h2>

<sql:query var="dua" dataSource="jdbc/N3CRegistrationTagLib">
	select incommon_id,incommon_name from n3c_admin.dua_organization where incommon_id is not null and email_domain = ?
	union 
	select incommon_id,incommon_name from tenant_admin.dua_organization where incommon_id is not null and email_domain = ?
	<sql:param>${param.email}</sql:param>
	<sql:param>${param.email}</sql:param>
</sql:query>

<c:forEach items="${dua.rows}" var="row" varStatus="rowCounter">
	<p><b>${row.incommon_name}</b> is federated with InCommon, which supports use of your institutional credentials
	to log into N3C. Click on the button below to continue your registration.</p>
	<a href="https://unite.nih.gov" class="btn btn-primary btn-n3c active" role="button" aria-pressed="true">Login Via InCommon</a>
	<c:set var="incommon_id">${row.incommon_id}</c:set>
</c:forEach>

<c:if test="${empty incommon_id}">
	<p>Your institution is not federated with InCommon, so you will need to log into N3C via login.gov. If you already have a
	login.gov ID that uses your institutional email, click on the button below to continue your registration. If you do not already
	have a login.gov ID, you need to first create on using your institutional email and then click on the button below to
	continue your registration.</p>
	<a href="https://unite.nih.gov" class="btn btn-primary btn-n3c active" role="button" aria-pressed="true">Login Via Login.gov</a>
</c:if>
