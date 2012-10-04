<?xml version="1.0" encoding="UTF-8"?>
<jsp:root version="2.0"
    xmlns:jsp="http://java.sun.com/JSP/Page"
    xmlns:c="http://java.sun.com/jsp/jstl/core"
    xmlns:imp="urn:jsptagdir:/WEB-INF/tags/imp">
  <jsp:directive.page contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"/>

  <imp:pageFrame title="OrthoMCL" refer="home">
	  <imp:sidebar/>
	  <div id="search-bubbles">
	    <ul>
	      <imp:searchCategories /> <!-- wdk: generates two <li>, one bubble per category -->
	      <li>
	        <a title="Tools">Tools</a>
	        <ul>
	          <li><a href="${pageContext.request.contextPath}/showQuestion.do?questionFullName=SequenceQuestions.ByBlast">BLAST</a></li>
	          <li><a href="${pageContext.request.contextPath}/proteomeUpload.do">Assign proteins to groups</a></li>
	        </ul>
	      </li>
	    </ul>
	  </div>	  
  </imp:pageFrame>

</jsp:root>
