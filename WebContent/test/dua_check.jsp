<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="n3c" uri="http://icts.uiowa.edu/N3CRegistrationTagLib"%>
<%@ taglib prefix="util" uri="http://icts.uiowa.edu/tagUtil"%>
<%@ taglib prefix="sql" uri="http://java.sun.com/jsp/jstl/sql"%>

<h2>DUA check: ${param.email}</h2>

<sql:query var="dua" dataSource="jdbc/N3CRegistrationTagLib">
	select ror_id,ror_name,duaexecuted as date from n3c_admin.dua_organization,n3c_admin.dua_master where dua_organization.ror_id=dua_master.institutionid and ? ~ (email_domain||'$')
	<sql:param>${param.email}</sql:param>
</sql:query>

<h3>COVID Enclave</h3>

<c:forEach items="${dua.rows}" var="row" varStatus="rowCounter">
	<p><b>${row.ror_name}</b> has an executed COVID Data Use Agreement (DUA), signed ${row.date}.</p>
	<c:set var="covid_dua">${row.ror_id}</c:set>
</c:forEach>

<c:if test="${empty covid_dua}">
	<p>Your institution does not have an executed COVID Data Use Agreement (DUA). If you are seeking access to
	the COVID Enclave, you can continue with your registration, but access will not be granted until a DUA
	is executed. (You will not have to take further action if this is the case - you will receive an email
	notification when your account is created.)</p>
</c:if>

<sql:query var="dua" dataSource="jdbc/N3CRegistrationTagLib">
	select ror_id,ror_name,tenantduaexecuted as date from tenant_admin.dua_organization,tenant_admin.dua_master where dua_organization.ror_id=dua_master.institutionid and ? ~ (email_domain||'$')
	<sql:param>${param.email}</sql:param>
</sql:query>

<h3>Tenant Enclaves</h3>

<c:forEach items="${dua.rows}" var="row" varStatus="rowCounter">
	<p><b>${row.ror_name}</b> has an executed Tenant Data Use Agreement (DUA), signed ${row.date}, that covers the following:</p>
	<ul>
		<li>N3C Education Enclave
		<li>N3C Cancer Enclave
		<li>N3C Renal Enclave
	</ul>
	<c:set var="tenant_dua">${row.ror_id}</c:set>
</c:forEach>

<c:if test="${empty tenant_dua}">
	<p>Your institution does not have an executed Tenant Data Use Agreement (DUA). If you are seeking access to
	one of the Enclaves below, you can continue with your registration, but access will not be granted until a DUA
	is executed. (You will not have to take further action if this is the case - you will receive an email
	notification when your account is created.)</p>
	<ul>
		<li>N3C Education Enclave
		<li>N3C Cancer Enclave
		<li>N3C Renal Enclave
	</ul>
</c:if>
