<?xml version="1.0" encoding="UTF-8"?>
<jsp:root version="2.0"
  xmlns:jsp="http://java.sun.com/JSP/Page"
  xmlns:c="http://java.sun.com/jsp/jstl/core"
  xmlns:imp="urn:jsptagdir:/WEB-INF/tags/imp"
  xmlns:common="urn:jsptagdir:/WEB-INF/tags/site-common">

  <jsp:directive.attribute name="title" required="true"
    description="Value to appear in page's title"/>
  <jsp:directive.attribute name="refer" required="false" 
    description="Page calling this tag"/>
  <jsp:directive.attribute name="bufferContent" required="false" 
    description="Page calling this tag"/>

  <c:set var="project" value="${applicationScope.wdkModel.displayName}"/>

  <common:pageFrame title="${title}" refer="${refer}" banner="OrthoMCL">

    <c:if test="${refer == 'home' or refer == 'home2' }">
      <imp:sidebar/>
    </c:if>

    <c:set var="showBanner">
      <imp:extraBanner refer="${refer}" title="${title}"/>
    </c:set>

    <imp:siteAnnounce refer="${refer}" showBanner="${showBanner}"/>

    <div id="main-content">
      <jsp:doBody/>
    </div>

  </common:pageFrame>
</jsp:root>
