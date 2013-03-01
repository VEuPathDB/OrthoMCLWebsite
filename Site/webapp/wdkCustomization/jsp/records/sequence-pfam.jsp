<?xml version="1.0" encoding="UTF-8"?>
<jsp:root version="2.0"
    xmlns:jsp="http://java.sun.com/JSP/Page"
    xmlns:c="http://java.sun.com/jsp/jstl/core"
    xmlns:fn="http://java.sun.com/jsp/jstl/functions"
    xmlns:imp="urn:jsptagdir:/WEB-INF/tags/imp">
  <jsp:directive.page contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"/>

	<!-- get wdkRecord from proper scope -->
	<c:set value="${requestScope.wdkRecord}" var="wdkRecord"/>
	<c:set var="sourceId" value="${wdkRecord.attributes['full_id']}" />
	<c:set var="proteins" value="${wdkRecord.tables['ProteinPFams']}" />
	<c:set var="domains" value="${wdkRecord.tables['PFams']}" />
	
	<!-- generate domain colors -->
	<c:set var="domainCount" value="${fn:length(domains)}" />
	<c:set var="maxLength" value="${wdkRecord.attributes['length']}" />

  <span class="onload-function" data-function="initializePfams"><jsp:text/></span>

  <!-- <h3>List of Domains (present in this group)</h3> -->
  <imp:toggle name="pfam-domains" displayName="List of Domains (present in this group)" isOpen="true">
    <jsp:attribute name="content">
      <table id="domains" count="${domainCount}" seed="${sourceId}">
        <tr>
          <th>Accession</th>
          <th>Name</th>
          <th>Description</th>
          <th>Legend</th>
        </tr>
        <c:set var="odd" value="${true}" />
        <c:forEach items="${domains}" var="domain">
          <c:set var="rowClass" value="${odd ? 'rowLight' : 'rowMedium'}" />
          <c:set var="odd" value="${!odd}" />
          <tr id="${domain['primary_identifier']}" class="domain ${rowClass}" >
            <td>${domain["primary_identifier"]}</td>
            <td>${domain["secondary_identifier"]}</td>
            <td>${domain["remark"]}</td>
            <td><div class="legend"> </div></td>
          </tr>
        </c:forEach>
      </table>
    </jsp:attribute>
  </imp:toggle>
	
	
  <!-- <h3>List of Protein Domain Architectures</h3> -->
  <imp:toggle name="pfam-domain-architectures" displayName="List of Protein Domain Architectures" isOpen="true">
    <jsp:attribute name="content">
      <table id="proteins" maxLength="${maxLength}" width="100%">
        <tr>
          <th>Accession</th>
          <th id="ruler" width="100%"></th>
        </tr>
      
        <c:set var="odd" value="${true}" />
        <c:set var="rowClass" value="${odd ? 'rowLight' : 'rowMedium'}" />
        <c:set var="odd" value="${!odd}" />
        <tr class="protein ${rowClass}">
          <td class="source-id">${sourceId}</td>
          <td>
            <div class="domains">
              <div class="protein-graph"> </div>
              <c:forEach items="${proteins}" var="row">
                <c:set var="name" value="${row['primary_identifier'].value}" />
                <c:set var="start" value="${row['start_min']}" />
                <c:set var="end" value="${row['end_max']}" />
                <c:if test="${name ne null and name ne ''}">
                  <div class="domain" id="${name}" start="${start}" end="${end}"
                       title="${name} (location: [${start} - ${end}])">
                    <div> </div>
                  </div>
                </c:if>
              </c:forEach>
            </div>
          </td>
        </tr>
      </table>
    </jsp:attribute>
  </imp:toggle>

</jsp:root>
