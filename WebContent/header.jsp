<%@ taglib prefix="util" uri="http://icts.uiowa.edu/tagUtil"%>
<style>

.navbar {
	color: #ffffff;
	background-color: #142b52;
	padding-bottom: 10px;
}

.navbar a {
    color: #fff;
}

.navbar button {
    color: #fff;
}

.dropdown-menu a {
    color: #000;
}

/*---------- HHS, NIH, NCATS branding bar  -------*/

.l-ribbon-wrapper {
  overflow: hidden;
  width: 100%;
  background-color: #20558a;
  display: block;
  height: 30px;
  padding-left: 3em;
  padding-right: 3em;
}

.l-ribbon {
    font: 0.9em/1.4em "Droid Sans",Trebuchet MS,Arial,Helvetica,sans-serif;
    padding: 0;
    margin: 0;
    list-style-image: none;
    list-style-type: none;
    margin-left: auto;
    margin-right: auto;
    overflow: hidden;
    margin: 0 auto;
    min-height: 100%;
    line-height: 1.5em;
    display: block;
}

.l-ribbon li a {
    display: block;
    color: #fff;
    float: left;
    padding-top: 6px;
    min-height: 30px;
}

.l-ribbon li span {
    display: block;
    color: #fff;
    float: left;
    padding-top: 6px;
    min-height: 30px;
}

.l-ribbon li .ribbon-right {
    filter: progid:DXImageTransform.Microsoft.Alpha(Opacity=30);
    opacity: 0.3;
    background-image: url(<util:propertyValue propertyFile="strapi" name="strapi-path"/>/uploads/nih_icon_list_9a32809d25.png);
    background-size: 189px 400px;
    background-position: -52px -126px;
    height: 30px;
    width: 20px;
    float: left;
    margin-left: 10px;
}

.ribbon-hhs {
    background-image: url(<util:propertyValue propertyFile="strapi" name="strapi-path"/>/uploads/nih_icon_list_9a32809d25.png);
    background-size: 189px 400px;
    background-position: 0 -126px;
    height: 27px;
    width: 22px;
    float: left;
    margin-right:.5em;
}

.ribbon-nih {
    background-image: url(<util:propertyValue propertyFile="strapi" name="strapi-path"/>/uploads/nih_icon_900ef05269.png );
    background-size: 20px;
    background-repeat: no-repeat;
    height: 20px;
    width: 20px;
    float:left;
    margin-right:.5em;
    margin-top: 5px;
}

.nav-actions-container {
	float: right;
}

</style>

<div class="l-ribbon-wrapper">
  <ul class="l-ribbon">
    <li><span class="ribbon-hhs"></span><a href="https://www.hhs.gov">U.S. Department of Health &amp; Human Services</a><span class="ribbon-right"></span></li>
    <li><span class="ribbon-nih"></span><a href="https://www.nih.gov/">National Institutes of Health</a><span class="ribbon-right"></span></li>
    <li><span class="ribbon-nih"></span><a href="https://ncats.nih.gov/">National Center for Advancing Translational Sciences</a><span class="ribbon-right"></span></li>
    
    <li class="nav-actions-container">
        <a href="https://unite.nih.gov/">Enclave Sign In</a>
        <span>&nbsp;|&nbsp;</span>
        <a href="<util:applicationRoot/>/account-instructions">Create Account</a>
        <span>&nbsp;|&nbsp;</span>
        <a href="https://labs.cd2h.org/registration/dologin.jsp">Profile</a>
    </li>
  </ul>
</div>

<jsp:include page="navbar.jsp" flush="true" />
