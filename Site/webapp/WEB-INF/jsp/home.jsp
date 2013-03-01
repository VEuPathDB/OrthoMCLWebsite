<?xml version="1.0" encoding="UTF-8"?>
<jsp:root version="2.0"
    xmlns:jsp="http://java.sun.com/JSP/Page"
    xmlns:c="http://java.sun.com/jsp/jstl/core"
    xmlns:wdk="urn:jsptagdir:/WEB-INF/tags/wdk" 
    xmlns:imp="urn:jsptagdir:/WEB-INF/tags/imp">
  <jsp:directive.page contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"/>

  <imp:pageFrame title="OrthoMCL" refer="home">
	  <div id="contentcolumn">
	    <ul>
	      <imp:searchCategories />
	      <li>
	      	<!--   <a title="Tools">Tools</a>  -->
					<img class="bubble-header" src="/assets/images/OrthoMCL/bubble_id_third_option2.png" alt="Tools" />
	        <ul id="info">
	          <li style="list-style-type:disc;margin-left:2em;"><a href="${pageContext.request.contextPath}/showQuestion.do?questionFullName=SequenceQuestions.ByBlast">BLAST</a></li>
	          <li style="list-style-type:disc;margin-left:2em;"><a href="${pageContext.request.contextPath}/proteomeUpload.do">Assign your proteins to groups</a></li>
	        </ul>
          <div id="infobottom"><jsp:text/></div>
	      </li>
	    </ul>
	  </div>	  
  </imp:pageFrame>
</jsp:root>
