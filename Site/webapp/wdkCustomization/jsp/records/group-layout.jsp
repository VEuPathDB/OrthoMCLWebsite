<?xml version="1.0" encoding="UTF-8"?>
<jsp:root version="2.0"
    xmlns:jsp="http://java.sun.com/JSP/Page"
    xmlns:c="http://java.sun.com/jsp/jstl/core"
    xmlns:fn="http://java.sun.com/jsp/jstl/functions"
    xmlns:imp="urn:jsptagdir:/WEB-INF/tags/imp"
	  xmlns:svg="http://www.w3.org/2000/svg">
  <jsp:directive.page contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"/>

  <c:set var="layout" value="${requestScope.layout}" />

<c:choose>
  <c:when test="${layout == null}">
    <div class="tip">Cluster graph is available for groups of 2 to 499 sequences.</div>
  </c:when>
  <c:otherwise> <!-- show layout -->

    <imp:layout />

  </c:otherwise> <!-- End of show layout -->
</c:choose>
  
</jsp:root>
