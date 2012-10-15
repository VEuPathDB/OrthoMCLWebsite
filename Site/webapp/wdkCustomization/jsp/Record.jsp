<?xml version="1.0" encoding="UTF-8"?>
<jsp:root version="2.0"
    xmlns:jsp="http://java.sun.com/JSP/Page"
    xmlns:c="http://java.sun.com/jsp/jstl/core"
    xmlns:imp="urn:jsptagdir:/WEB-INF/tags/imp">
  <jsp:directive.page contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"/>

  <!-- get wdkRecord from proper scope -->
  <c:set value="${requestScope.wdkRecord}" var="wdkRecord"/>

  <!-- display page header with recordClass type in banner -->
  <c:set value="${wdkRecord.recordClass.type}" var="recordType"/>

  <!-- if recordClass is Group, add sequence count as subtitle -->
  <c:if test="${recordType eq 'Group'}">
    <c:set value="(${wdkRecord.attributes['number_of_members'].value} sequences)" var="recordSubtitle"/>
  </c:if>

  <imp:pageFrame refer="record" title="${recordType} Record page">
    <imp:record record="${wdkRecord}" recordSubtitle="${recordSubtitle}"/>
  </imp:pageFrame>

</jsp:root>
