<?xml version="1.0" encoding="UTF-8"?>
<jsp:root version="2.0"
    xmlns:jsp="http://java.sun.com/JSP/Page"
    xmlns:c="http://java.sun.com/jsp/jstl/core"
    xmlns:wdk="urn:jsptagdir:/WEB-INF/tags/wdk"
    xmlns:imp="urn:jsptagdir:/WEB-INF/tags/imp">

  <jsp:directive.attribute name="refer" required="false" 
              description="Page calling this tag"/>

  <c:set var="base" value="${pageContext.request.contextPath}"/>

  <!-- includes the original wdk includes -->
  <wdk:includes refer="${refer}"/>
  
  <script type="text/javascript" src="${base}/wdkCustomization/js/lib/apycom-menu.js"><jsp:text/></script>
  <script type="text/javascript" src="${base}/wdkCustomization/js/lib/jquery.timers-1.2.js"><jsp:text/></script>
  <script type="text/javascript" src="${base}/wdkCustomization/js/common.js"><jsp:text/></script>
  
  <!--<link rel="stylesheet" type="text/css" href="${base}/wdkCustomization/css/jquery-ui/jquery-ui-1.8.16.custom.css"/>-->
  <link rel="stylesheet" type="text/css" href="${base}/wdkCustomization/css/apycom-menu/menu.css"/>
  <link rel="stylesheet" type="text/css" href="${base}/wdkCustomization/css/common.css"/>

  
  <c:if test="${refer eq 'home'}">
    <script type="text/javascript" src="${base}/wdkCustomization/js/home.js"><jsp:text/></script>
    <link rel="stylesheet" type="text/css" href="${base}/wdkCustomization/css/home.css"/>
  </c:if>
  
  <c:if test="${refer eq 'summary'}">
    <link rel="stylesheet" type="text/css" href="${base}/wdkCustomization/css/results.css"/>
  </c:if>
  
  <c:if test="${refer eq 'summary' or refer eq 'record'}">
    <script type="text/javascript" src="${base}/wdkCustomization/js/phyletic.js"><jsp:text/></script>
    <link rel="stylesheet" type="text/css" href="${base}/wdkCustomization/css/group.css"/>
  </c:if>
  
  <c:if test="${refer eq 'summary' or refer eq 'question'}">
    <script type="text/javascript" src="${base}/wdkCustomization/js/ppform.js"><jsp:text/></script>
    <link rel="stylesheet" type="text/css" href="${base}/wdkCustomization/css/ppform.css"/>
  </c:if>
  
  <c:if test="${refer eq 'record'}">
    <script type="text/javascript" src="${base}/wdkCustomization/js/pfamDomain.js"><jsp:text/></script>
    <link rel="stylesheet" type="text/css" href="${base}/wdkCustomization/css/pfamDomain.css"/>
    <link rel="stylesheet" type="text/css" href="${base}/wdkCustomization/css/record.css"/>
  </c:if>

  <link rel="stylesheet" type="text/css" href="/assets/css/OrthoMCL.css"/>
</jsp:root>
