<?xml version="1.0" encoding="UTF-8"?>
<jsp:root version="2.0"
    xmlns:jsp="http://java.sun.com/JSP/Page"
    xmlns:c="http://java.sun.com/jsp/jstl/core">
  <jsp:directive.page contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"/>

  <!-- get wdkRecord from proper scope -->
  <c:set value="${requestScope.wdkRecord}" var="wdkRecord"/>

  <c:set var="msa" value="${wdkRecord.attributes['msa']}"/>

  <div id="msa">
    <c:choose>
      <c:when test="${empty msa.value}">
        Multiple Sequence Alignment not available for this ortholog group, <br />
        since it contains more than 100 genes.
      </c:when>
      <c:otherwise>
        <pre>
          ${msa.value}
        </pre>
      </c:otherwise>
    </c:choose>
  </div>

</jsp:root>
