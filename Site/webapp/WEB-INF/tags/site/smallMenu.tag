<?xml version="1.0" encoding="UTF-8"?>
<jsp:root version="2.0"
    xmlns:jsp="http://java.sun.com/JSP/Page"
    xmlns:c="http://java.sun.com/jsp/jstl/core"
    xmlns:imp="urn:jsptagdir:/WEB-INF/tags/imp">

  <!-- functions to be called when page loads -->
  <span class="onload-function" data-function="wdk.setUpNavDropDowns"><jsp:text/></span>
  <span class="onload-function" data-function="eupath.setup.setUpContactUsLogic"><jsp:text/></span>

  <!-- top level menu -->
  <div id="nav-top-div">
	  <ul id="nav-top">
	    <li>
	      <a href="${pageContext.request.contextPath}/about.do">About OrthoMCL</a>
	      <ul>
	        <imp:aboutMenu/>
	      </ul>
	    </li>
	    <li>
	      <a href="javascript:void()">Help</a>
	      <ul>
	        <c:if test="${refer eq 'summary'}">
	          <li><a href="javascript:void()" onclick="wdk.dyk.dykOpen()">Did You Know...</a></li>
	        </c:if>
	        <li><a href="http://workshop.eupathdb.org/current/">EuPathDB Workshop</a></li>
	        <li><a href="http://workshop.eupathdb.org/current/index.php?page=schedule">Exercises from Workshop</a></li>
	        <li><a href="http://www.genome.gov/Glossary/">NCBI's Glossary of Terms</a></li>
	        <li><a href="${pageContext.request.contextPath}/contact.do" class="open-window-contact-us">Contact Us</a></li>
	      </ul>
	    </li>
	    <imp:login/>
	    <li class="empty-divider"><a href="${pageContext.request.contextPath}/contact.do" class="open-window-contact-us">Contact Us</a></li>
	    <imp:socialMedia small="true"/>
	  </ul>
	</div>
</jsp:root>
