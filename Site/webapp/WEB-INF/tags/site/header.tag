<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="imp" tagdir="/WEB-INF/tags/imp" %>

<c:set var="project" value="${applicationScope.wdkModel.displayName}" />

<%@ attribute name="title"
              description="Value to appear in page's title"
%>
<%@ attribute name="refer" 
              required="false" 
              description="Page calling this tag"
%>
<html>

<%--------------------------- HEAD of HTML doc ---------------------%>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8" />
<title>
	<c:out value="${title}" default="WDK ${project}" />
</title>

<!-- for IE and other beowsers -->
<link rel="icon" type="image/png" href="<c:url value="/images/favicon.ico" /> "> 
<link rel="shortcut icon" href="<c:url value="/images/favicon.ico" /> ">


<imp:includes refer="${refer}"/>

</head>

<body>

<!-- helper divs with generic information used by javascript -->
<imp:siteInfo />


<div id="header">
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

   <div id="site-logo">
<%--
    <a href="<c:url value='/home.jsp'/>"><image src="<c:url value='/wdkCustomization/images/site-logo.jpg'/>"/></a>
--%>
    <a href="<c:url value='/home.jsp'/>">OrthoMCL</a>
  </div>
</div>

<imp:menubar refer="${refer}" />

<div id="main-content"><!-- the close DIV is defined in footer. -->
