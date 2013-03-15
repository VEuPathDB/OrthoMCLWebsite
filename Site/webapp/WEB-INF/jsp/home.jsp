<?xml version="1.0" encoding="UTF-8"?>
<jsp:root version="2.0"
    xmlns:jsp="http://java.sun.com/JSP/Page"
    xmlns:c="http://java.sun.com/jsp/jstl/core"
    xmlns:wdk="urn:jsptagdir:/WEB-INF/tags/wdk" 
    xmlns:imp="urn:jsptagdir:/WEB-INF/tags/imp">
  <jsp:directive.page contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"/>

  <imp:pageFrame title="OrthoMCL" refer="home">
	  <div id="contentcolumn">
	    <ul id="bubbles">
	      <imp:searchCategories from="home"/>
	      <li>
	      	<!--   <a title="Tools">Tools</a>  -->
					<img class="bubble-header" src="/assets/images/OrthoMCL/bubble_id_third_option2.png" alt="Tools" />
	        <ul class="info">
	          <li style="list-style-type:disc;margin-left:2em;"><a href="${pageContext.request.contextPath}/showQuestion.do?questionFullName=SequenceQuestions.ByBlast">BLAST</a></li>
	          <li style="list-style-type:disc;margin-left:2em;"><a href="${pageContext.request.contextPath}/proteomeUpload.do">Assign your proteins to groups</a></li>
	          <li style="list-style-type:disc;margin-left:2em;"><a href="/common/downloads/software">Download OrthoMCL software</a></li>
	          <li style="list-style-type:disc;margin-left:2em;"><a href="/serviceList.jsp">Web Services</a></li>
                  <li style="list-style-type:disc;margin-left:2em;"><a href="${constants.orthoGoogleUrl}">Publications mentioning OrthoMCL</a></li>
	        </ul>
          <div class="infobottom"><jsp:text/></div>
	      </li>
	    </ul>
	  </div>	  
  </imp:pageFrame>
</jsp:root>
