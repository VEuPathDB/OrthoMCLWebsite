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
  <c:set var="wdkAnswer" value="${wdkStep.answerValue}"/>
  <c:set var="format" value="${requestScope.wdkReportFormat}"/>
  
  <!-- display page header -->
  <imp:pageFrame title="Create and download a Full Records Report">

    <!-- display description for page -->
    <p>
      <b>Generate a report that contents the complete information for each
      record.  Select columns to include in the report.</b>
    </p>

    <!-- display the parameters of the question, and the format selection form -->
    <imp:reporter/>

    <!-- handle empty result set situation -->
    <c:choose>
      <c:when test='${wdkAnswer.resultSize eq 0}'>
        No results for your query
      </c:when>
      <c:otherwise>

        <!-- content of current page -->
				<form name="downloadConfigForm" method="get" action="getDownloadResult.do">
				  <table>
				    <tr>
				      <td valign="top">
				        <b>Columns:</b>
				      </td>
				      <td>
				        <input type="hidden" name="step" value="${step_id}"/>
				        <input type="hidden" name="wdkReportFormat" value="${format}"/>
                <c:set var="numCols" value="2"/>
				        <table>
				          <imp:fieldColumns title="Attributes" numCols="${numCols}" attributes="${wdkAnswer.allReportMakerAttributes}"/>
				          <imp:fieldColumns title="Tables" numCols="${numCols}" attributes="${wdkAnswer.allReportMakerTables}"/>
				        </table>
				      </td>
				    </tr>
				    <tr>
				      <td valign="top">&#160;</td>
				      <td align="center">
				        <input type="button" value="select all" onclick="makeSelection(1)"/>
				        <input type="button" value="clear all" selected="yes" onclick="makeSelection(0)"/>
				        <input type="button" value="select inverse" selected="yes" onclick="makeSelection(-1)"/>
				      </td>
				    </tr>
				    <tr>
				      <td valign="top"><b>Download Type: </b></td>
				      <td>
				        <input type="radio" name="downloadType" value="text"/>Text File
				        <input type="radio" name="downloadType" value="plain" checked="checked"/>Show in Browser
				      </td>
				    </tr>
				    <tr>
				      <td colspan="2" valign="top">
				        <input type="checkbox" name="hasEmptyTable" value="true" checked="checked"/>Include Empty Table
				      </td>
				    </tr>
				    <tr>
				      <td colspan="2">&#160;</td>
				    </tr>
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
