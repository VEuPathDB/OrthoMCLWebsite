<?xml version="1.0" encoding="UTF-8"?>
<jsp:root version="2.0"
    xmlns:jsp="http://java.sun.com/JSP/Page"
    xmlns:c="http://java.sun.com/jsp/jstl/core"
    xmlns:imp="urn:jsptagdir:/WEB-INF/tags/imp">
  <jsp:directive.page contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"/>

  <!-- get wdkAnswer from requestScope -->
  <c:set value="${wdkAnswer}" var="wdkAnswer"/>
  <c:set var="format" value="${wdkReportFormat}"/>

  <!-- display page header -->
  <imp:pageFrame title="Download Results" refer="reporter" bufferContent="true">

    <!-- table sets the red line on top -->
    <table border="0" width="100%" cellpadding="1" cellspacing="0" bgcolor="white" class="thinTopBorders">
      <tr>
        <td bgcolor="white" valign="top">
         

          <!-- display the parameters of the question, and the format selection form -->
          <imp:reporter/>

          <!-- handle empty result set situation -->
          <c:if test="${wdkAnswer.resultSize eq 0}">
            No results for your query
          </c:if>
        </td>
      </tr>
    </table>
  </imp:pageFrame>
</jsp:root>
