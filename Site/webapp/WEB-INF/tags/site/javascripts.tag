<?xml version="1.0" encoding="UTF-8"?>
<jsp:root version="2.0"
    xmlns:jsp="http://java.sun.com/JSP/Page"
    xmlns:c="http://java.sun.com/jsp/jstl/core"
    xmlns:wdk="urn:jsptagdir:/WEB-INF/tags/wdk"
    xmlns:common="urn:jsptagdir:/WEB-INF/tags/site-common"
    xmlns:imp="urn:jsptagdir:/WEB-INF/tags/imp">

  <jsp:directive.attribute name="refer" required="false" 
              description="Page calling this tag"/>

  <common:javascripts refer="${refer}"/>

  <c:set var="base" value="${pageContext.request.contextPath}"/>

  <script src="//d3js.org/d3.v3.min.js" charset="utf-8"><jsp:text/></script>

  <imp:script src="wdkCustomization/js/lib/jquery.timers-1.2.js" charset="utf-8"/>

  <c:if test="${refer eq 'summary'}">
    <imp:script src="wdkCustomization/js/customStrategy.js" charset="utf-8"/>
  </c:if>

  <c:if test="${refer eq 'summary' or refer eq 'record'}">
    <imp:script src="wdkCustomization/js/phyletic.js" charset="utf-8"/>
    <imp:script src="wdkCustomization/js/group-layout.js" charset="utf-8"/>
  </c:if>

  <c:if test="${refer eq 'summary' or refer eq 'question'}">
    <imp:script src="wdkCustomization/js/ppform.js" charset="utf-8"/>
    <imp:script src="wdkCustomization/js/questions/radio-params.js" charset="utf-8"/>
  </c:if>

  <c:if test="${refer eq 'record'}">
    <imp:script src="wdkCustomization/js/pfamDomain.js" charset="utf-8"/>
  </c:if>



</jsp:root>
