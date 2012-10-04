<?xml version="1.0" encoding="UTF-8"?>
<jsp:root version="2.0"
    xmlns:jsp="http://java.sun.com/JSP/Page"
    xmlns:c="http://java.sun.com/jsp/jstl/core"
    xmlns:imp="urn:jsptagdir:/WEB-INF/tags/imp">

  <!-- functions to be called when page loads -->
  <span class="onload-function" data-function="setUpNavDropDowns"><jsp:text/></span>
  <span class="onload-function" data-function="Setup.setUpContactUsLogic"><jsp:text/></span>

  <!-- top level menu -->
  <div id="nav-top-div">
	  <ul id="nav-top">
	    <li><a href="${pageContext.request.contextPath}/about.do">About OrthoMCL</a></li>
	    <li>
	      <a href="javascript:void()">Help</a>
	      <ul>
	        <c:if test="${refer eq 'customSummary'}">
	          <li><a href="javascript:void()" onclick="dykOpen()">Did You Know...</a></li>
	        </c:if>
	        <li><a href="http://workshop.eupathdb.org/current/">EuPathDB Workshop</a></li>
	        <li><a href="http://workshop.eupathdb.org/current/index.php?page=schedule">Exercises from Workshop</a></li>
	        <li><a href="http://www.genome.gov/Glossary/">NCBI's Glossary of Terms</a></li>
	        <li><a href="javascript:void()" class="open-dialog-contact-us">Contact Us</a></li>
	      </ul>
	    </li>
	    <imp:login/>
	    <li class="empty-divider"><a href="javascript:void()" class="open-dialog-contact-us">Contact Us</a></li>
	    <li class="socmedia-link no-divider">
	      <a href="#"><img width="16" src="${pageContext.request.contextPath}/wdkCustomization/images/twitter.gif"/></a>
	    </li>
	    <li class="socmedia-link no-divider">
	      <a href="#"><img width="16" src="${pageContext.request.contextPath}/wdkCustomization/images/facebook.png"/></a>
	    </li>
	  </ul>
	</div>
</jsp:root>
