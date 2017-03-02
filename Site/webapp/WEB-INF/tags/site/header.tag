<?xml version="1.0" encoding="UTF-8"?>
<jsp:root version="2.0"
  xmlns:jsp="http://java.sun.com/JSP/Page"
  xmlns:c="http://java.sun.com/jsp/jstl/core"
  xmlns:fmt="http://java.sun.com/jsp/jstl/fmt"
  xmlns:common="urn:jsptagdir:/WEB-INF/tags/site-common"
  xmlns:imp="urn:jsptagdir:/WEB-INF/tags/imp">

  <jsp:directive.attribute name="refer" required="false" 
    description="Page calling this tag"/>

  <jsp:directive.attribute name="title" required="false" 
    description="Title of page"/>

  <c:set var="props" value="${applicationScope.wdkModel.properties}"/>
  <c:set var="project" value="${props['PROJECT_ID']}"/>

  <div id="toplink">
    <a href="http://eupathdb.org"><imp:image src="wdkCustomization/images/partofeupath.png" alt="Link to EuPathDB homepage"/></a>
  </div>
  <common:header refer="${refer}" title="${title}"/>
</jsp:root>
