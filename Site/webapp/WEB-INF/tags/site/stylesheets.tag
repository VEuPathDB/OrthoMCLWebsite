<?xml version="1.0" encoding="UTF-8"?>
<jsp:root version="2.0"
    xmlns:jsp="http://java.sun.com/JSP/Page"
    xmlns:c="http://java.sun.com/jsp/jstl/core"
    xmlns:wdk="urn:jsptagdir:/WEB-INF/tags/wdk"
    xmlns:imp="urn:jsptagdir:/WEB-INF/tags/imp">

  <jsp:directive.attribute name="refer" required="false" 
              description="Page calling this tag"/>

  <c:set var="base" value="${pageContext.request.contextPath}"/>

  <jsp:useBean id="websiteRelease" class="org.eupathdb.common.controller.WebsiteReleaseConstants"/>
  <c:set var="debug" value="${requestScope.WEBSITE_RELEASE_STAGE eq websiteRelease.development}"/>
  <!-- includes the original wdk includes -->
  <wdk:wdkStylesheets refer="${refer}" debug="${debug}"/>

  <!-- comment out to use WDK's style -->
  <!-- include third party CSS first, so that we can easily override rules -->
  <!--<imp:stylesheet rel="stylesheet" type="text/css" href="wdkCustomization/css/jquery-ui/jquery-ui-1.8.16.custom.css"/>-->

  <imp:stylesheet rel="stylesheet" type="text/css" href="wdkCustomization/css/superfish/css/superfish.css"/>
  <imp:stylesheet rel="stylesheet" type="text/css" href="wdkCustomization/css/common.css"/>

  <!-- adding some css for backgorund in contentcolumn2, used in strategy workspace -->
  <imp:stylesheet rel="stylesheet" type="text/css" href="css/AllSites.css"/>
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
  </c:if>

  <c:if test="${refer eq 'record'}">
    <imp:stylesheet rel="stylesheet" type="text/css" href="wdkCustomization/css/pfamDomain.css"/>
    <imp:stylesheet rel="stylesheet" type="text/css" href="wdkCustomization/css/record.css"/>
  </c:if>

</jsp:root>
