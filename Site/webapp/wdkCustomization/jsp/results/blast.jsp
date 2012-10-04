<?xml version="1.0" encoding="UTF-8"?>
<jsp:root version="2.0"
    xmlns:jsp="http://java.sun.com/JSP/Page"
    xmlns:c="http://java.sun.com/jsp/jstl/core"
    xmlns:imp="urn:jsptagdir:/WEB-INF/tags/imp">
  <jsp:directive.page contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"/>

  <c:set var="wdkStep" value="${requestScope.wdkStep}" />
  <c:set var="wdkAnswer" value="${wdkStep.answerValue}"/>

<pre>
${wdkAnswer.resultMessage}
</pre>

</jsp:root>