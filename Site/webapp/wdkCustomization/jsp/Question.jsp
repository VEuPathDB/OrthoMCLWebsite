<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="imp" tagdir="/WEB-INF/tags/imp" %>
<%@ taglib prefix="imp" tagdir="/WEB-INF/tags/imp" %>
<%@ taglib prefix="html" uri="http://jakarta.apache.org/struts/tags-html" %>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>

<%-- partial is used for internal questions in queryList4.tag --%>
<c:set var="Question_Header" scope="request">
  <c:if test="${requestScope.partial != 'true'}">
    <imp:header title="Search for ${wdkQuestion.recordClass.type}s by ${wdkQuestion.displayName}" refer="question" />
  </c:if>
</c:set>

${Question_Header}

<c:set var="recordType" value="${wdkQuestion.recordClass.type}"/>

<c:set var="webProps" value="${wdkQuestion.propertyLists['websiteProperties']}" />
<c:set var="hideOperation" value="${false}" />
<c:set var="hideTitle" value="${false}" />
<c:set var="hideAttrDescr" value="${false}" />

<c:forEach var="prop" items="${webProps}">
  <c:choose>
    <c:when test="${prop == 'hideOperation'}"><c:set var="hideOperation" value="${true}" /></c:when>
    <c:when test="${prop == 'hideTitle'}"><c:set var="hideTitle" value="${true}" /></c:when>
    <c:when test="${prop == 'hideAttrDescr'}"><c:set var="hideAttrDescr" value="${true}" /></c:when>
  </c:choose>
</c:forEach>

<c:if test="${hideTitle == false}">
	<center><h1 style="font-size:140%">Identify ${recordType}s based on ${wdkQuestion.displayName}</h1></center><br>
</c:if>

<html:form styleId="form_question" method="post" enctype='multipart/form-data' action="/processQuestion.do">

<imp:questionForm />

<c:if test="${hideOperation == false}">
    <div class="filter-button"><html:submit property="questionSubmit" value="Get Answer"/></div>
</c:if>

</html:form>

<c:set var="Question_Footer" scope="request">
  <%-- displays question description, can be overridden by the custom question form --%>
<c:if test="${hideAttrDescr == false}">
  <imp:questionDescription />
</c:if>

<c:if test="${requestScope.partial != 'true'}">
  <imp:footer />
</c:if>
</c:set>

${Question_Footer}
