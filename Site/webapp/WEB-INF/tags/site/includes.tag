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
  
  <!-- comment out to use WDK's style -->
  <!-- include third party CSS first, so that we can easily override rules -->
  <!--<link rel="stylesheet" type="text/css" href="${base}/wdkCustomization/css/jquery-ui/jquery-ui-1.8.16.custom.css"/>-->

  <link rel="stylesheet" type="text/css" href="${base}/wdkCustomization/css/superfish/css/superfish.css"/>
  <link rel="stylesheet" type="text/css" href="${base}/wdkCustomization/css/common.css"/>

  <!-- adding some css for backgorund in contentcolumn2, used in strategy workspace -->
  <link rel="stylesheet" type="text/css" href="/assets/css/AllSites.css"/>
  <link rel="stylesheet" type="text/css" href="/assets/css/OrthoMCL.css"/>

  <script type="text/javascript" src="${base}/wdkCustomization/js/lib/hoverIntent.js"><jsp:text/></script>
  <script type="text/javascript" src="${base}/wdkCustomization/js/lib/superfish.js"><jsp:text/></script>
  <script type="text/javascript" src="${base}/wdkCustomization/js/lib/supersubs.js"><jsp:text/></script>

  <script type="text/javascript" src="${base}/wdkCustomization/js/lib/jquery.timers-1.2.js"><jsp:text/></script>
  <script type="text/javascript" src="${base}/wdkCustomization/js/common.js"><jsp:text/></script>
  
  <!-- Access twitter/facebook links, and configure menubar (superfish) -->
  <script type="text/javascript" src="${base}/js/nav.js"><jsp:text/></script>
  
  <c:if test="${refer eq 'home'}">
<!-- no need in ortho to open close categories in bubbles
    <script type="text/javascript" src="${base}/wdkCustomization/js/home.js"><jsp:text/></script> -->
    <link rel="stylesheet" type="text/css" href="${base}/wdkCustomization/css/home.css"/>
  </c:if>
  
  <c:if test="${refer eq 'about'}">
    <link rel="stylesheet" type="text/css" href="${base}/wdkCustomization/css/about.css"/>
  </c:if>

  <c:if test="${refer eq 'proteome'}">
    <link rel="stylesheet" type="text/css" href="${base}/wdkCustomization/css/proteome.css"/>
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

 
</jsp:root>
