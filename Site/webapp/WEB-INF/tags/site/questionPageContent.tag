<?xml version="1.0" encoding="UTF-8"?>
<jsp:root version="2.0"
    xmlns:jsp="http://java.sun.com/JSP/Page"
    xmlns:c="http://java.sun.com/jsp/jstl/core"
    xmlns:html="http://jakarta.apache.org/struts/tags-html"
    xmlns:imp="urn:jsptagdir:/WEB-INF/tags/imp">
  
  <c:set var="recordType" value="${wdkQuestion.recordClass.type}"/>
  <c:set var="webProps" value="${wdkQuestion.propertyLists['websiteProperties']}" />
  <c:set var="hideOperation" value="${false}" />
  <c:set var="hideTitle" value="${false}" />
  <c:set var="hideAttrDescr" value="${false}" />

  <c:forEach var="prop" items="${webProps}">
    <c:choose>
      <c:when test="${prop eq 'hideOperation'}"><c:set var="hideOperation" value="${true}" /></c:when>
      <c:when test="${prop eq 'hideTitle'}"><c:set var="hideTitle" value="${true}" /></c:when>
      <c:when test="${prop eq 'hideAttrDescr'}"><c:set var="hideAttrDescr" value="${true}" /></c:when>
    </c:choose>
  </c:forEach>

  <c:if test="${hideTitle eq false}">
    <center><h1 style="font-size:140%">Identify ${recordType}s based on ${wdkQuestion.displayName}</h1></center><br/>
  </c:if>

  <html:form styleId="form_question" method="post" enctype="multipart/form-data" action="processQuestion">
    <imp:questionForm/>
    <c:if test="${hideOperation eq false}">
      <div class="filter-button">
        <html:submit property="questionSubmit" value="Get Answer"/>
      </div>
    </c:if>
  </html:form>

  <!-- displays question description, can be overridden by the custom question form -->
  <c:if test="${hideAttrDescr eq false}">
    <imp:questionDescription/>
  </c:if>
  
</jsp:root>
