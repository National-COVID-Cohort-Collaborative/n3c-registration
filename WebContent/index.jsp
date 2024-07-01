<%@ page language="java" contentType="text/html; charset=UTF-8"	pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="util" uri="http://icts.uiowa.edu/tagUtil"%>
<!DOCTYPE html>
<html>
	<jsp:include page="head.jsp" flush="true" />

<style type="text/css" media="all">
	@import "resources/n3c_login_style.css";
</style>

<body>

	<jsp:include page="navbar.jsp" flush="true" />
	
	<c:if test="${not empty not_logged_in}">
		<div class=" n3c_alert">
    		<i class="fa fa-exclamation" aria-hidden="true">&emsp;</i>Our apologies, but you must successfully log in through NIH prior to registering. Click <a href="dologin.jsp">here</a> to be redirected.<br/>
    	</div>
    	<c:remove var="not_logged_in"/>
    </c:if>


	<div class="container center-box shadow-border">
    	<h2 class="header-text"><img src="images/n3c_logo.png" class="n3c_logo_header" alt="N3C Logo">N3C Registration</h2>
    	<div style="text-align:center;">
			<h4 style="margin-bottom:30px;">Welcome!  Thank you for your interest in the National Clinical Cohort Collaborative (N3C).</h4>
 			
    		
			<p>Please register your profile information on the following page.  After submitting your information, please follow the <a href="https://covid.cd2h.org/for-tenant-researchers" target="_blank">onboarding instructions</a>
			to request access to the N3C Team Drive, mailing lists, N3C calendar, Slack, and GitHub.</p>
 
 			<p>You will receive a copy of your responses and are encouraged to update your information as needed.</p>
 			
			<p class="n3c_alert" style="margin-bottom:0px; display:none;">Please note the form has recently been updated; please review your prior responses to assure accuracy as the order of questions has changed.</p>
			
			

        	<a href="<util:applicationRoot/>/authenticate" class="btn btn-lg btn-n3c" style="margin-top:30px; margin-bottom:30px;">Click here to Register</a>
        	
			
			
			<p style="font-size:15px; font-style:italic; margin-bottom:30px; color:#6d6d6d; display:none;">Applications for membership will be reviewed/approved rapidly during the week, but may extend up to 48 hours over weekends. Your patience and understanding is appreciated.</p>
			
			<p>Please submit a <a href="https://n3c-help.atlassian.net/servicedesk/customer/portal/2">support desk ticket</a> with any questions.</p>
			<div style="display:none;">
				<a href="dologin.jsp?attrs=1" class="btn btn-n3c">NCATS UNA demo login</a> This is here for the moment to support login debugging.
			</div>
        </div>
	</div>
	<jsp:include page="footer.jsp" flush="true" />
</body>
</html>
