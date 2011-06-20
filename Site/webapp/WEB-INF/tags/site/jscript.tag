<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="wdk" tagdir="/WEB-INF/tags/wdk" %>

<%@ attribute name="refer" 
 	      type="java.lang.String"
	      required="true" 
	      description="Page calling this tag"
%>





<%-- JQuery library is included by WDK --%>
<c:if test="${refer == 'customSummary'}">
	<wdk:strategyScript />

<%-- CHECK IF THIS IS NEEDED ----  javascript provided by site 
	<script type="text/javascript" src="/assets/js/customStrategy.js"></script>
	<script type="text/javascript" src="/assets/js/ortholog.js"></script>
--%>

</c:if>

<c:if test="${refer == 'customSummary' || refer == 'customQuestion'}">
	<wdk:parameterScript />
<%-- REMOVE
	<script type="text/javascript" src="/assets/js/orthologpattern.js"></script>
	<script type="text/javascript" src="/assets/js/blast.js"></script>
--%>

</c:if>

<%-- js for quick seach box --%>
<%-- REMOVE
	<script type="text/javascript" src="/assets/js/quicksearch.js"></script>
--%>

<!-- dynamic query grid code -->
<%-- REMOVE
	<script type="text/javascript" src="/assets/js/dqg.js"></script>
	<script type="text/javascript" src="/assets/js/newitems.js"></script>
--%>

<%-- CHECK IF NEEDED
	<script type="text/javascript" src="/assets/js/popups.js"></script>
--%>


<!-- fix to transparent png images in IE 7 -->
<!--[if lt IE 7]>
<%-- NEEDED? where does it go? wdk or wdktemplatesite? --%>
	<script type="text/javascript" src="/assets/js/pngfix.js"></script>
<![endif]-->

<!-- js for Contact Us window -->
<%-- REMOVE
	<script type='text/javascript' src='<c:url value="/js/newwindow.js"/>'></script>
--%>


<%-- show/hide the tables in the record page --%>
<%--  REMOVE
	<script type='text/javascript' src="/assets/js/show_hide_tables.js"></script>
--%>
