<%@ page language="java" contentType="text/html; charset=UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="n3c" uri="http://icts.uiowa.edu/N3CRegistrationTagLib"%>
<%@ taglib prefix="util" uri="http://icts.uiowa.edu/tagUtil"%>

<html>
	<jsp:include page="../head.jsp" flush="true" />

<style type="text/css" media="all">
	@import "../resources/n3c_login_style.css";
@import "<util:applicationRoot/>/resources/autocomplete.css";
</style>
<body>
	<script type="text/javascript">
    function process() {
    	var form = new FormData(document.getElementById("email"));
    	var inputValue = form.get("email").toLowerCase();
    	if (inputValue.endsWith("gmail.com")) {
    		alert("Use of GMail addresses for registration is not allowed. Please use your institutional email.")
    		return false;
    	}
    	$("#dua_data").load("<util:applicationRoot/>/authenticate/dua_check.jsp?email="+inputValue.match(/@(.*)/)[1]);
    	$("#una_data").load("<util:applicationRoot/>/authenticate/una_check.jsp?email="+inputValue.match(/@(.*)/)[1]);
    	return false;
    }
	</script>
	
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
</body>
</html>
