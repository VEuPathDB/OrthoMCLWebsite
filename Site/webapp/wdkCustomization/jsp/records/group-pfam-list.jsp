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
  <c:set var="domainCount" value="${domains.numRows}"/>
  <c:set var="maxLength" value="${wdkRecord.attributes['max_length']}"/>

  <!-- <span class="onload-function" data-function="eupathdb.pfamDomain.init"><jsp:text/></span> -->

  <!-- <h3>List of Domains (present in this group)</h3> -->
  <imp:toggle name="pfam-domains-list" displayName="PFam Domains" isOpen="true">
    <jsp:attribute name="content">
      <table id="domains" count="${domainCount}" seed="${groupName}">
        <tr>
          <th>Accession</th>
          <th>Symbol</th>
          <th>Description</th>
          <th>Count</th>
        </tr>
        <c:set var="odd" value="${true}" />
        <c:forEach items="${domains.iterator}" var="domain">
          <c:set var="rowClass" value="${odd ? 'rowLight' : 'rowMedium'}" />
          <c:set var="odd" value="${!odd}" />
          <tr id="${domain['accession']}" class="domain ${rowClass}" >
            <td><a href="http://pfam.xfam.org/family/${domain['accession']}">${domain["accession"]}</a></td>
            <td>${domain["symbol"]}</td>
            <td>${domain["description"]}</td>
            <td>${domain["occurrences"]}</td>
          </tr>
        </c:forEach>
      </table>
    </jsp:attribute>
  </imp:toggle>

  <!-- <h3>List of Protein Domain Architectures</h3> -->
  <imp:toggle name="protein-domain-architectures" displayName="Protein Domain Locations" isOpen="true">
    <jsp:attribute name="content">
      <table id="proteins" class="wdk-data-table" maxLength="${maxLength}" width="100%">
        <thead>
          <tr>
            <th>Accession</th>
            <th>Core/Peripheral</th>
            <th>Protein Length</th>
            <th>Pfam Domain</th>
            <th>Domain Start</th>
            <th>Domain End</th>
          </tr>
        </thead>
      
        <tbody>
          <c:set var="odd" value="${true}" />
          <c:set var="previous_id" value="${''}" />
          <c:forEach items="${proteins.iterator}" var="row">
            <c:set var="source_id" value="${row['full_id'].value}" />
            <c:set var="length" value="${row['protein_length'].value}" />
            <c:set var="rowClass" value="${odd ? 'rowLight' : 'rowMedium'}" />
            <c:set var="odd" value="${!odd}" />
            <tr class="protein ${rowClass}">
              <td class="source-id">
                <a href="${pageContext.request.contextPath}/showRecord.do?name=SequenceRecordClasses.SequenceRecordClass&amp;full_id=${source_id}">${source_id}</a>
              </td>
              <td>${row['core_peripheral']}</td>
              <td>${length}</td>
              <td>${row['accession'].value}</td>
              <td>${row['start_min']}</td>
              <td>${row['end_max']}</td>
            </tr>
          </c:forEach>
        </tbody>
      </table>
    </jsp:attribute>
  </imp:toggle>

</jsp:root>
