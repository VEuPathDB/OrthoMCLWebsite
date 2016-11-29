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
  <!-- JavaScript provided by WDK -->
  <imp:wdkJavascripts refer="${refer}" debug="${debug}"/>

  <script src="http://d3js.org/d3.v3.min.js" charset="utf-8"><jsp:text/></script>

  <imp:script src="wdkCustomization/js/lib/hoverIntent.js"/>
  <imp:script src="wdkCustomization/js/lib/superfish.js"/>
  <imp:script src="wdkCustomization/js/lib/supersubs.js"/>

  <imp:script src="wdkCustomization/js/lib/jquery.timers-1.2.js"/>
  <imp:script src="wdkCustomization/js/common.build.js"/>

  <!-- Access twitter/facebook links, and configure menubar (superfish) -->
  <imp:script src="js/nav.js"/>

  <c:if test="${refer eq 'summary'}">
    <imp:script src="wdkCustomization/js/customStrategy.js"/>
  </c:if>

  <c:if test="${refer eq 'summary' or refer eq 'record'}">
    <imp:script src="wdkCustomization/js/phyletic.js"/>
    <imp:script src="wdkCustomization/js/group-layout.js"/>
  </c:if>

  <c:if test="${refer eq 'summary' or refer eq 'question'}">
    <imp:script src="wdkCustomization/js/ppform.js"/>
    <imp:script src="wdkCustomization/js/question/radio-params.js"/>
  </c:if>

  <c:if test="${refer eq 'record'}">
    <imp:script src="wdkCustomization/js/pfamDomain.js"/>
  </c:if>



</jsp:root>
