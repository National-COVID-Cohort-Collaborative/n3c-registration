<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
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
	
	<div class="container center-box shadow-border">
	<script type="text/javascript">
	var submittedEmail = null;
    function process() {
    	var form = new FormData(document.getElementById("email"));
    	submittedEmail = form.get("email").toLowerCase();
    	if (submittedEmail.endsWith("gmail.com")) {
    		$('#gmailModal').modal()
    		return false;
    	}
    	$("#dua_data").load("<util:applicationRoot/>/authenticate/dua_check.jsp?email="+submittedEmail.match(/@(.*)/)[1]);
    	$("#una_data").load("<util:applicationRoot/>/authenticate/una_check.jsp?email="+submittedEmail.match(/@(.*)/)[1]);
    	return false;
    }
	</script>
	<!-- Modal dialog documentation: https://getbootstrap.com/docs/4.0/components/modal/  -->

	<!-- Modal -->
	<div class="modal fade" id="gmailModal" tabindex="-1" role="dialog" aria-labelledby="gmailModalTitle" aria-hidden="true">
	  <div class="modal-dialog modal-dialog-centered" role="document">
	    <div class="modal-content">
	      <div class="modal-header">
	        <h5 class="modal-title" id="gmailModalTitle">GMail Usage Restrictions</h5>
	        <button type="button" class="close" data-dismiss="modal" aria-label="Close">
	          <span aria-hidden="true">&times;</span>
	        </button>
	      </div>
	      <div class="modal-body">
	        Use of GMail addresses for registration is only allowed if you wish to access N3C as a citizen scientist - that is,
	        someone not affiliated with an organization that has executed a Data Use Agreement. If you are affiliated with an
	        organization, please use your institutional email.
	      </div>
	      <div class="modal-footer">
	        <button type="button" class="btn btn-secondary" data-dismiss="modal">Close</button>
	        <button type="button" class="btn btn-primary" onclick="window.location.replace('../citizen-scientist?email='+submittedEmail);" >
	        	Continue to Citizen Scientist registration
	        </button>
	      </div>
	    </div>
	  </div>
	</div>	

	<div class="container-fluid">
		<div class="main-block">
			<div class="block">
				<h2 class="center">N3C Registration</h2>
				<p>Please submit your institutional email:</p>
				<form id="email" onsubmit="return process();">
					<input name="email">
					<input type="submit" name="Submit">
				</form>
				<div class="row flex-wrap">
					<div id="dua_data" class="card col-6 shade-blue">
					left
					</div>
					<div id="una_data" class="card col-6 shade-blue">
					right
					</div>
				</div>
			</div>
		</div>
	</div>
	</div>
</body>
</html>
