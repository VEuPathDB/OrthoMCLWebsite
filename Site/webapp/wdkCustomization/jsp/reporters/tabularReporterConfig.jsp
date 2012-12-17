<?xml version="1.0" encoding="UTF-8"?>
<jsp:root version="2.0"
    xmlns:jsp="http://java.sun.com/JSP/Page"
    xmlns:c="http://java.sun.com/jsp/jstl/core"
    xmlns:html="http://jakarta.apache.org/struts/tags-html"
    xmlns:imp="urn:jsptagdir:/WEB-INF/tags/imp">
  <jsp:directive.page contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"/>

  <!-- get wdkAnswer from requestScope -->
  <jsp:useBean id="wdkUser" scope="session" type="org.gusdb.wdk.model.jspwrap.UserBean"/>
  <c:set value="${requestScope.wdkStep}" var="wdkStep"/>
  <c:set var="wdkAnswer" value="${wdkStep.answerValue}" />
  <c:set var="format" value="${requestScope.wdkReportFormat}"/>

  <!-- display page header -->
  <imp:pageFrame title="Create and download a Report in Tabular Format">

    <!-- display description for page -->
    <p>
      <b>Generate a tab delimited report of your query result.  Select columns to
      include in the report.  Optionally include a first line with column names</b>
    </p>

    <!-- display the parameters of the question, and the format selection form -->
    <imp:reporter/>

    <!-- handle empty result set situation -->
    <c:choose>
      <c:when test="${wdkAnswer.resultSize eq 0}">
        No results for your query
      </c:when>
      <c:otherwise>

        <!-- content of current page -->
				<form name="downloadConfigForm" method="get" action="getDownloadResult.do">
				  <table>
				    <tr>
				      <td valign="top"><b>Columns:</b></td>
				      <td>
				        <input type="hidden" name="step" value="${step_id}"/>
				        <input type="hidden" name="wdkReportFormat" value="${format}"/>
				        <c:set var="attributeFields" value="${wdkAnswer.allReportMakerAttributes}"/>
				        <c:set var="numCols" value="2"/>
				        <table>
				          <tr>
				            <td colspan="${numCols}">
				              <input type="checkbox" name="selectedFields" value="default" onclick="wdk.uncheckFields(1);" checked="checked"/>
				              Default (same as in <a href="${pageContext.request.contextPath}/showSummary.do?step=${step_id}">result</a>), or...
				            </td>
				          </tr>
				          <imp:fieldColumns title="" numCols="2" attributes="${wdkAnswer.allReportMakerAttributes}"/>
				        </table>
				      </td>
				    </tr>
				    <tr>
				      <td valign="top">&#160;</td>
				      <td align="center">
				        <input type="button" value="select all" onclick="wdk.checkFields(1)"/>
				        <input type="button" value="clear all" selected="yes" onclick="wdk.checkFields(0)"/>
				      </td>
				    </tr>
				    <tr>
				      <td valign="top"><b>Column names: </b></td>
				      <td>
				        <input type="radio" name="includeHeader" value="yes" checked="checked"/>include
				        <input type="radio" name="includeHeader" value="no"/>exclude
				      </td>
				    </tr>
				    <tr>
				      <td valign="top"><b>Download Type: </b></td>
				      <td>
				        <input type="radio" name="downloadType" value="text"/>Text File
				        <input type="radio" name="downloadType" value="excel"/>Excel File
				        <input type="radio" name="downloadType" value="plain" checked="checked"/>Show in Browser
				      </td>
				    </tr>
				    <tr><td colspan="2">&#160;</td></tr>
				    <tr><td colspan="2">Please note: if you choose Excel as download type, you can only download maximum 10M (in bytes) of the results, and the rest are discarded. Opening huge Excel file may crash you system. If you need to get the complete results, please choose the Download Type is Text File, or Show in Browser.</td></tr>
				    <tr>
				      <td></td>
				      <td><html:submit property="downloadConfigSubmit" value="Get Report"/></td>
				    </tr>
				  </table>
				</form>
      </c:otherwise>
    </c:choose>
  </imp:pageFrame>
</jsp:root>
