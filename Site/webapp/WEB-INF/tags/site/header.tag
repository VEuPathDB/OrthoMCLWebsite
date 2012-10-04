<?xml version="1.0" encoding="UTF-8"?>
<jsp:root version="2.0"
    xmlns:jsp="http://java.sun.com/JSP/Page"
    xmlns:c="http://java.sun.com/jsp/jstl/core"
    xmlns:fmt="http://java.sun.com/jsp/jstl/fmt"
    xmlns:imp="urn:jsptagdir:/WEB-INF/tags/imp">
	
  <jsp:directive.attribute name="refer" required="false" 
              description="Page calling this tag"/>

  <c:set var="project" value="${applicationScope.wdkModel.properties['PROJECT_ID']}" />
  <c:set var="version" value="${applicationScope.wdkModel.version}" />

  <!-- required for date parsing when client browser (e.g. curl) does not send locale -->
  <fmt:setLocale value="en-US"/>
  <fmt:parseDate var="releaseDate" value="${applicationScope.wdkModel.releaseDate}" pattern="dd MMMM yyyy HH:mm"/> 
  <fmt:formatDate var="formattedReleaseDate" value="${releaseDate}" pattern="d MMM yy"/>

  <div id="header2">
    <div id="header-control" class="ui-widget ui-widget-content ui-corner-all">      
      <div id="sub-logo">
        <a href="http://eupathdb.org"><img src="${pageContext.request.contextPath}/wdkCustomization/images/partofeupath.png"/></a>
      </div>
      <imp:quickSearch/>
      <imp:smallMenu/>
    </div>
    <a href="${pageContext.request.contextPath}/home.do">
      <img src="/assets/images/${project}/title_s.png" alt="Link to ${project} homepage" align="left" />
    </a>
    Version ${version}<br/>
    ${formattedReleaseDate}
  </div>
</jsp:root>
