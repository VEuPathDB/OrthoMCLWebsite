<?xml version="1.0" encoding="UTF-8"?>
<jsp:root version="2.0"
    xmlns:jsp="http://java.sun.com/JSP/Page"
    xmlns:c="http://java.sun.com/jsp/jstl/core"
    xmlns:fn="http://java.sun.com/jsp/jstl/functions"
    xmlns:imp="urn:jsptagdir:/WEB-INF/tags/imp">
  <jsp:directive.page contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"/>

  <c:set var="layout" value="${viewModel}" />
  <html>
    <body>
      <c:choose>
        <c:when test="${layout == null}">
          <div class="tip">Cluster graph is only available for sequence search results with no more than 200 sequences.</div>
        </c:when>
        <c:otherwise> <!-- show layout -->
          <imp:layout layout="${layout}" />
        </c:otherwise> <!-- End of show layout -->
      </c:choose>
    </body>
  </html>
</jsp:root>
