<?xml version="1.0" encoding="UTF-8"?>
<jsp:root version="2.0"
    xmlns:jsp="http://java.sun.com/JSP/Page"
    xmlns:c="http://java.sun.com/jsp/jstl/core"
    xmlns:common="urn:jsptagdir:/WEB-INF/tags/site-common"
    xmlns:imp="urn:jsptagdir:/WEB-INF/tags/imp">

  <jsp:directive.attribute name="refer" required="false" 
              description="Page calling this tag"/>

  <c:set var="base" value="${pageContext.request.contextPath}"/>

  <jsp:useBean id="websiteRelease" class="org.eupathdb.common.controller.WebsiteReleaseConstants"/>
  <c:set var="debug" value="${requestScope.WEBSITE_RELEASE_STAGE eq websiteRelease.development}"/>
  <!-- includes the original wdk includes -->
  <common:stylesheets refer="${refer}"/>

  <imp:stylesheet rel="stylesheet" type="text/css" href="wdkCustomization/css/common.css"/>
  <imp:stylesheet rel="stylesheet" type="text/css" href="css/OrthoMCL.css"/>

  <c:if test="${refer eq 'home'}">
<!-- no need in ortho to open close categories in bubbles
    <script type="text/javascript" src="wdkCustomization/js/home.js"><jsp:text/></script> -->
    <imp:stylesheet rel="stylesheet" type="text/css" href="wdkCustomization/css/home.css"/>
  </c:if>

  <c:if test="${refer eq 'about'}">
    <imp:stylesheet rel="stylesheet" type="text/css" href="wdkCustomization/css/about.css"/>
  </c:if>

  <c:if test="${refer eq 'proteome'}">
    <imp:stylesheet rel="stylesheet" type="text/css" href="wdkCustomization/css/proteome.css"/>
  </c:if>

  <c:if test="${refer eq 'summary'}">
    <imp:stylesheet rel="stylesheet" type="text/css" href="wdkCustomization/css/results.css"/>
  </c:if>

  <c:if test="${refer eq 'summary' or refer eq 'record'}">
    <imp:stylesheet rel="stylesheet" type="text/css" href="wdkCustomization/css/group.css"/>
    <imp:stylesheet rel="stylesheet" type="text/css" href="wdkCustomization/css/group-layout.css"/>  
  </c:if>

  <c:if test="${refer eq 'summary' or refer eq 'question'}">
    <imp:stylesheet rel="stylesheet" type="text/css" href="wdkCustomization/css/question.css"/>
    <imp:stylesheet rel="stylesheet" type="text/css" href="wdkCustomization/css/ppform.css"/>
    <imp:stylesheet rel="stylesheet" type="text/css" href="wdkCustomization/css/radio-params.css"/>
  </c:if>

  <c:if test="${refer eq 'record'}">
    <imp:stylesheet rel="stylesheet" type="text/css" href="wdkCustomization/css/pfamDomain.css"/>
    <imp:stylesheet rel="stylesheet" type="text/css" href="wdkCustomization/css/record.css"/>
  </c:if>

</jsp:root>
