<?xml version="1.0" encoding="UTF-8"?>
<jsp:root version="2.0"
    xmlns:jsp="http://java.sun.com/JSP/Page"
    xmlns:c="http://java.sun.com/jsp/jstl/core"
    xmlns:fn="http://java.sun.com/jsp/jstl/functions"
    xmlns:imp="urn:jsptagdir:/WEB-INF/tags/imp">
  <jsp:directive.page contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"/>

  <!-- get wdkRecord from proper scope -->
  <c:set value="${requestScope.wdkRecord}" var="wdkRecord"/>
  <c:set var="groupName" value="${wdkRecord.attributes['group_name']}"/>
  <c:set var="proteins" value="${wdkRecord.tables['ProteinPFams']}"/>
  <c:set var="domains" value="${wdkRecord.tables['PFams']}"/>

  <!-- generate domain colors -->
  <c:set var="domainCount" value="${fn:length(domains)}"/>
  <c:set var="maxLength" value="${wdkRecord.attributes['max_length']}"/>

  <span class="onload-function" data-function="initializePfams"><jsp:text/></span>

  <h3>List of Domains (present in this group)</h3>
  <table id="domains" count="${domainCount}" seed="${groupName}">
	  <tr>
	    <th>Accession</th>
	    <th>Name</th>
	    <th>Description</th>
	  </tr>
	  <c:set var="odd" value="${true}" />
	  <c:forEach items="${domains}" var="domain">
	    <c:set var="rowClass" value="${odd ? 'rowLight' : 'rowMedium'}" />
	    <c:set var="odd" value="${!odd}" />
	    <tr id="${domain['primary_identifier']}" class="domain ${rowClass}" >
	      <td>${domain["primary_identifier"]}</td>
	      <td>${domain["secondary_identifier"]}</td>
	      <td>${domain["remark"]}</td>
	    </tr>
	  </c:forEach>
	</table>

	<h3>List of Protein Domain Architectures</h3>
	<table id="proteins" maxLength="${maxLength}" width="100%">
	  <tr>
	    <th>Accession</th>
	    <th>Protein Length</th>
	    <th>Pfam Domain</th>
	    <th>Domain Start</th>
	    <th>Domain End</th>
	  </tr>
	
	  <c:set var="odd" value="${true}" />
	  <c:set var="previous_id" value="${''}" />
	  <c:forEach items="${proteins}" var="row">
	    <c:set var="source_id" value="${row['source_id'].value}" />
	    <c:set var="rowClass" value="${odd ? 'rowLight' : 'rowMedium'}" />
	    <c:set var="odd" value="${!odd}" />
	    <tr class="protein ${rowClass}">
	      <td class="source-id">
	        <a href="${pageContext.request.contextPath}/showRecord.do?name=SequenceRecordClasses.SequenceRecordClass&amp;source_id=${source_id}">${source_id}</a>
	      </td>
	      <td class="length">${row['length']}</td>
	      <td>${row['primary_identifier'].value}</td>
	      <td>${row['start_min']}</td>
	      <td>${row['end_max']}</td>
	    </tr>
	  </c:forEach>
	</table>

</jsp:root>
