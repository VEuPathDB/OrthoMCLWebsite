<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="wdk" tagdir="/WEB-INF/tags/wdk" %>

<%@ attribute name="refer" 
	      required="true" 
	      description="Page calling this tag"
%>


<%-- scripts & styles that are applied to all pages --%>
<script type="text/javascript" src='<c:url value="/wdkCustomization/js/lib/apycom-menu.js"/>'></script>


<link rel="stylesheet" type="text/css" href="<c:url value='/wdkCustomization/css/jquery-ui/jquery-ui-1.8.16.custom.css' />">
<link rel="stylesheet" type="text/css" href="<c:url value='/wdkCustomization/css/apycom-menu/menu.css' />">
<link rel="stylesheet" type="text/css" href="<c:url value='/wdkCustomization/css/common.css' />">



<%-- scripts & styles that are used on home page only --%>
<c:if test="${refer == 'home'}">

<script type="text/javascript" src='<c:url value="/wdkCustomization/js/home.js"/>'></script>

<link rel="stylesheet" type="text/css" href="<c:url value='/wdkCustomization/css/home.css' />">
</c:if>
