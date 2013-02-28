<?xml version="1.0" encoding="UTF-8"?>
<jsp:root version="2.0"
    xmlns:c="http://java.sun.com/jsp/jstl/core"
    xmlns:fmt="http://java.sun.com/jsp/jstl/fmt"
    xmlns:jsp="http://java.sun.com/JSP/Page"
    xmlns:imp="urn:jsptagdir:/WEB-INF/tags/imp">
  <jsp:directive.page contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"/>  

  <c:set var="helperQuestion" value="${wdkModel.questionSetsMap['HelperQuestions'].questionsMap['ByDefault']}"/>
  <!-- must set user on question before retrieving answer value -->	
  <jsp:setProperty name="helperQuestion" property="user" value="${wdkUser}"/>
  <!-- compile records and obtain statistics -->
  <c:forEach items="${helperQuestion.answerValue.records}" var="item">
    <c:set var="helperRecord" value="${item}"/>
  </c:forEach>
  <c:set var="organism_count" value="${helperRecord.attributes['organism_count'].value}"/>
  <c:set var="protein_count" value="${helperRecord.attributes['protein_count'].value}"/>
  <c:set var="group_count" value="${helperRecord.attributes['group_count'].value}"/>

  <c:set var="releaseOverview">
    <div id="release-overview">
      <ul>
        <li>Genomes: <strong><fmt:formatNumber value="${organism_count}"/></strong></li>
        <li>Protein Sequences: <strong><fmt:formatNumber value="${protein_count}"/></strong></li>
        <li>Ortholog Groups: <strong><fmt:formatNumber value="${group_count}"/></strong></li>
      </ul>
    </div>
  </c:set>

  <imp:pageFrame refer="data-source" title="Species Summary">
    <imp:toggle name="release-overview" displayName="Overview"
      content="${releaseOverview}" isOpen="true"/>
    <imp:wdkTable tblName="DataSummary" isOpen="true" dataTable="true"/>
  </imp:pageFrame>
</jsp:root>
