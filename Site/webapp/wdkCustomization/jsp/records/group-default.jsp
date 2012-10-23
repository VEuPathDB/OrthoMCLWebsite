<?xml version="1.0" encoding="UTF-8"?>
<jsp:root version="2.0"
    xmlns:jsp="http://java.sun.com/JSP/Page"
    xmlns:c="http://java.sun.com/jsp/jstl/core"
    xmlns:imp="urn:jsptagdir:/WEB-INF/tags/imp">
  <jsp:directive.page contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"/>

  <c:set var="record" value="${requestScope.wdkRecord}"/>
  <c:set var="recordClass" value="${record.recordClass}"/>

  <!-- load the taxon info -->
  <c:set var="helperQuestions" value="${wdkModel.questionSetsMap['HelperQuestions']}"/>
  <c:set var="helperQuestion" value="${helperQuestions.questionsMap['ByDefault']}"/>
  <jsp:setProperty name="helperQuestion" property="user" value="${wdkUser}"/>
  <c:set var="helperRecords" value="${helperQuestion.answerValue.records}"/>
  <c:forEach items="${helperRecords}" var="item">
    <c:set var="helperRecord" value="${item}"/>
  </c:forEach>
  <c:set var="taxons" value="${helperRecord.tables['Taxons']}"/>

  <div class="phyletic-pattern record-panel">

    <div id="taxons" style="display:none">
      <c:forEach items="${taxons}" var="row">
        <div class="taxon" taxon-id="${row['taxon_id']}"
             parent="${row['parent_id']}" abbrev="${row['abbreviation']}" 
             leaf="${row['is_species']}" index="${row['sort_index']}"
             common-name="${row['common_name']}">${row['name']}</div>
      </c:forEach>
    </div>

    <span class="onload-function" data-function="initializePhyleticView"><jsp:text/></span>

    <div id="taxon-display"></div>

    <div id="legend">
      <div class="count"><span count="0">&#160;0&#160;</span> no ortholog; </div>
      <div class="count"><span count="1">&#160;1&#160;</span> one ortholog; </div>
      <div class="count"><span count="2">&#160;n&#160;</span> more than one ortholog; </div>
    </div>

    <div id="control">
      <input id="showCount" type="checkbox" checked="checked"/>phyletic pattern labels <br/>
    </div>

    <div id="groups" class="Results_Table">
      <c:set value="${record.primaryKey}" var="primaryKey"/>

      <!-- load the taxon count -->
      <c:set var="taxonCounts" value="${record.tables['TaxonCounts']}" />

      <div id="${primaryKey}" class="group">
        <div class="count-data">
          <c:forEach items="${taxonCounts}" var="row">
            <div class="count" taxon-id="${row['taxon_id']}">${row['count']}</div>
          </c:forEach>
        </div>
        <div class="phyletic-pattern"></div>
      </div>
    </div>
  </div>
  <!-- end of .phyletic-pattern -->

  <c:set var="attributes" value="${record.summaryAttributes}" />
	<div class="group-info">
	  <h3>Group statistics</h3>
	  <table>
	    <tr>
	      <c:forEach items="${attributes}" var="entry">
	        <th>${entry.value.attributeField.displayName}</th>
	      </c:forEach>
	    </tr>
	    <tr>
	      <c:forEach items="${attributes}" var="entry">
	        <c:set var="attribute" value="${entry.value}" />
	        <td>
	          <c:choose>
	            <c:when test="${attribute.class.name eq 'org.gusdb.wdk.model.LinkAttributeValue'}">
	              <a href="${attribute.url}">${attribute.displayText}</a>
	            </c:when>
	            <c:otherwise>
	              <font class="fixed">${attribute.value}</font>
	            </c:otherwise>
	          </c:choose>
	        </td>
	      </c:forEach>
	    </tr>
	  </table>  
	</div>
	
	<div class="sequences">
	  <c:url var="fastaLink" value="processQuestion.do?questionFullName=SequenceQuestions.ByAccession&amp;skip_to_download=1&amp;wdkReportFormat=fasta&amp;value(accession)=${primaryKey}"/>
          <c:url var="strategyLink" value="processQuestion.do?questionFullName=SequenceQuestions.ByAccession&amp;value(accession)=${primaryKey}" />
          Get Sequences:
	  <a class="button ui-state-default ui-corner-all" href="${fastaLink}">As Fasta file</a>
          <a class="button ui-state-default ui-corner-all" href="${strategyLink}">As new strategy</a>
	  <c:set var="proteins" value="${wdkRecord.tables['Sequences']}"/>
	  <imp:wdkTable tblName="${proteins.name}" isOpen="true"/>
	</div>
	
</jsp:root>
