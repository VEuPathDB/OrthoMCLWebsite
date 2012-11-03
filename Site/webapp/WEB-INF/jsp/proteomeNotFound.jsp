<?xml version="1.0" encoding="UTF-8"?>
<jsp:root version="2.0"
    xmlns:jsp="http://java.sun.com/JSP/Page"
    xmlns:c="http://java.sun.com/jsp/jstl/core"
    xmlns:imp="urn:jsptagdir:/WEB-INF/tags/imp">
  <jsp:directive.page contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"/>
  <imp:pageFrame title="OrthoMCL: Proteome Not Found" refer="proteomeNotFound">
    <c:choose>
      <c:when test="${empty jobId}">
        You must specify a Job ID.  Please check the URL and try again.
      </c:when>
      <c:otherwise>
        Could not find results for job id '${jobId}'.<br/>
        The likely cause is either the job id is incorrect or the job is older than
        ${purgeWindow} days and the result has been deleted.
      </c:otherwise>
    </c:choose>
  </imp:pageFrame>
</jsp:root>
