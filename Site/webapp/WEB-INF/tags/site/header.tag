<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="site" tagdir="/WEB-INF/tags/site" %>
<%@ taglib prefix="wdk" tagdir="/WEB-INF/tags/wdk" %>

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

<%-- css from WDK  --%>
<wdk:includes refer="${refer}" /> 

<site:includes refer="${refer}"/>

</head>
<body>
<div id="header">
  <div id="site-logo">
    <a href="<c:url value='/home.jsp'/>"><image src="<c:url value='/wdkCustomization/images/site-logo.jpg'/>"/></a>
  </div>
   
  <div id="sub-logo">
    <a href="http://eupathdb.org"><image src="<c:url value='/wdkCustomization/images/partofeupath.png'/>"/></a>
  </div>

  <site:quickSearch />

  <div id="tool-sets">
    <a href="#">About OrthoMCL</a> |
    <a href="#">Help</a> |
    <site:login /> |
    <a href="#">Contact Us</a> |
    <a href="#"><image width="16" src="<c:url value='/wdkCustomization/images/twitter.gif' />"/></a>
    <a href="#"><image width="16" src="<c:url value='/wdkCustomization/images/facebook.png' />"/></a>
  </div>
</div>

<site:menubar refer="${refer}" />
