<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="imp" tagdir="/WEB-INF/tags/imp" %>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>

<c:set var="project" value="${applicationScope.wdkModel.displayName}" />

<%@ attribute name="title"
              description="Value to appear in page's title"
%>
<%@ attribute name="refer" 
              required="false" 
              description="Page calling this tag"
%>
<%---------------------------%>

<c:set var="props" value="${applicationScope.wdkModel.properties}" />
<c:set var="project" value="${props['PROJECT_ID']}" />
<c:set var="version" value="${applicationScope.wdkModel.version}" />
<c:set var="releaseDate" value="${applicationScope.wdkModel.releaseDate}" />

<c:set var="inputDateFormat" value="dd MMMM yyyy HH:mm"/>
<fmt:setLocale value="en-US"/>    <%-- req. for date parsing when client browser (e.g. curl) does not send locale --%>
<fmt:parseDate  var="rlsDate"               value="${releaseDate}"  pattern="${inputDateFormat}"/> 
<fmt:formatDate var="releaseDate_formatted" value="${rlsDate}"     pattern="d MMM yy"/>
 

<html>

<%--------------------------- HEAD of HTML doc ---------------------%>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8" />
<title>
	<c:out value="${title}" default="WDK ${project}" />
</title>

<link rel="icon" type="image/png" href="/assets/images/${project}/favicon.ico"> 
<link rel="shortcut icon" href="/assets/images/${project}/favicon.ico">

<imp:includes refer="${refer}"/>
</head>

<%--------------------------- BODY of HTML doc ---------------------%>
<body>

<!-- helper divs with generic information used by javascript -->
<%-- WHY NOT in includes.tag --%>
<imp:siteInfo />

<div id="header2">

  <div id="header-control" class="ui-widget ui-widget-content ui-corner-all">
 
    <div id="sub-logo">
      <a href="http://eupathdb.org"><image src="<c:url value='/wdkCustomization/images/partofeupath.png'/>"/></a>
    </div>

    <imp:quickSearch />

    <div id="tool-sets">
      <a href="#">About OrthoMCL</a> |
      <a href="#">Help</a> |
      <imp:login /> |
      <a href="#" class="open-dialog-contact-us">Contact Us</a> |
      <a href="#"><image width="16" src="<c:url value='/wdkCustomization/images/twitter.gif' />"/></a>
      <a href="#"><image width="16" src="<c:url value='/wdkCustomization/images/facebook.png' />"/></a>
    </div>
 
  </div>


<%------------- TOP LEFT: SITE name and release DATE  ----------%>
  <a href="/"><img src="/assets/images/${project}/title_s.png" alt="Link to ${project} homepage" align="left" /></a>
	Version ${version}<br/>
  ${releaseDate_formatted}


</div>  <%-- id="header2" --%>


<%------------- REST OF PAGE  ----------------%>
<imp:menubar refer="${refer}" />


<div id="main-content"><!-- the close DIV is defined in footer. -->
