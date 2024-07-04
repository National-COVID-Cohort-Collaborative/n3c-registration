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
	
	<div class="container center-box">
		<div class="main-block">
			<div class="block">
				<h2 class="center">N3C Registration Admin</h2>

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
