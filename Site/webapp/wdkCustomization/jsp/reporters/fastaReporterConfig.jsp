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
  <imp:pageFrame title="Create and download a FASTA Report">

    <!-- display description for page -->
    <p>
      <b>Download the protein sequences in FASTA format.</b>
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
				  <input type="hidden" name="step" value="${step_id}"/>
				  <input type="hidden" name="wdkReportFormat" value="${format}"/>
				  <table>
				    <tr>
				      <td colspan="2" valign="top">
				        <input type="checkbox" name="hasOrganism" value="true" checked="checked">Include taxon name
				      </td>
				    </tr>
				    <tr>
				      <td colspan="2" valign="top">
				        <input type="checkbox" name="hasDescription" value="true" checked="checked">Include protein product.
				      </td>
				    </tr>
				    <tr>
				      <td valign="top">
				        <b>Download Type: </b>
				      </td>
				      <td>
				        <input type="radio" name="downloadType" value="text"/>Text File
				        <input type="radio" name="downloadType" value="plain" checked="checked"/>Show in Browser
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
