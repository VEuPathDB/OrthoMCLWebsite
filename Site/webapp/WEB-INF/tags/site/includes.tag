<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="imp" tagdir="/WEB-INF/tags/imp" %>
<%@ taglib prefix="wdk" tagdir="/WEB-INF/tags/wdk" %>

<%@ attribute name="refer" 
	      required="true" 
	      description="Page calling this tag"
%>

<%-- includes the original wdk includes --%>
<wdk:includes refer="${refer}" /> 

<script type="text/javascript" src='<c:url value="/wdkCustomization/js/lib/apycom-menu.js"/>'></script>
<script type="text/javascript" src='<c:url value="/wdkCustomization/js/lib/jquery.timers-1.2.js"/>'></script>
<script type="text/javascript" src='<c:url value="/wdkCustomization/js/common.js"/>'></script>

<!-- <link rel="stylesheet" type="text/css" href="<c:url value='/wdkCustomization/css/jquery-ui/jquery-ui-1.8.16.custom.css' />">  -->
<link rel="stylesheet" type="text/css" href="<c:url value='/wdkCustomization/css/apycom-menu/menu.css' />">
<link rel="stylesheet" type="text/css" href="<c:url value='/wdkCustomization/css/common.css' />">

<c:if test="${refer == 'home'}">
  <script type="text/javascript" src='<c:url value="/wdkCustomization/js/home.js"/>'></script>
  <link rel="stylesheet" type="text/css" href="<c:url value='/wdkCustomization/css/home.css' />">
</c:if>

<c:if test="${refer == 'summary'}">
  <link rel="stylesheet" type="text/css" href="<c:url value='/wdkCustomization/css/results.css' />">
</c:if>

<c:if test="${refer == 'summary' || refer == 'record'}">
  <script type="text/javascript" src='<c:url value="/wdkCustomization/js/phyletic.js"/>'></script>
  <script type="text/javascript" src='<c:url value="/wdkCustomization/js/phyletic-pattern.js"/>'></script>
  <link rel="stylesheet" type="text/css" href="<c:url value='/wdkCustomization/css/group.css' />">
  <link rel="stylesheet" type="text/css" href="<c:url value='/wdkCustomization/css/phyletic-pattern.css' />">
</c:if>

<c:if test="${refer == 'summary' || refer == 'question'}">
  <script type="text/javascript" src='<c:url value="/wdkCustomization/js/ppform.js"/>'></script>
  <link rel="stylesheet" type="text/css" href="<c:url value='/wdkCustomization/css/ppform.css' />">
</c:if>

<c:if test="${refer == 'record'}">
  <script type="text/javascript" src='<c:url value="/wdkCustomization/js/pfamDomain.js"/>'></script>
  <link rel="stylesheet" type="text/css" href="<c:url value='/wdkCustomization/css/pfamDomain.css' />">
  <link rel="stylesheet" type="text/css" href="<c:url value='/wdkCustomization/css/record.css' />">
</c:if>

<link rel="stylesheet" href="/assets/css/OrthoMCL.css" type="text/css" />
