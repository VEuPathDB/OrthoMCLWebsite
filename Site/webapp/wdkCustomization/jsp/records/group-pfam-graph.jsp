<?xml version="1.0" encoding="UTF-8"?>
<jsp:root version="2.0"
    xmlns:jsp="http://java.sun.com/JSP/Page"
    xmlns:c="http://java.sun.com/jsp/jstl/core"
    xmlns:fn="http://java.sun.com/jsp/jstl/functions"
    xmlns:imp="urn:jsptagdir:/WEB-INF/tags/imp"
    xmlns:wdkfn="http://gusdb.org/wdk/functions">
  <jsp:directive.page contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"/>

  <!-- get wdkRecord from proper scope -->
  <c:set value="${requestScope.wdkRecord}" var="wdkRecord"/>
  <c:set var="groupName" value="${wdkRecord.attributes['group_name']}"/>
  <c:set var="proteins" value="${wdkRecord.tables['ProteinPFams']}"/>
  <c:set var="domains" value="${wdkRecord.tables['PFams']}"/>
  <c:set var="proteinGroups" value="${wdkfn:groupAttributeRecordsBySource(proteins)}"/>

  <!-- generate domain colors -->
  <c:set var="domainCount" value="${fn:length(domains)}"/>
  <c:set var="maxLength" value="${wdkRecord.attributes['max_length']}"/>

  <span class="onload-function" data-function="initializePfams"><jsp:text/></span>

  <!-- <h3>List of Domains (present in this group)</h3> -->
  <imp:toggle name="pfam-domains" displayName="PFam Domains" isOpen="true">
    <jsp:attribute name="content">
      <table id="domains" count="${domainCount}" seed="${groupName}">
        <tr>
          <th>Accession</th>
          <th>Name</th>
          <th>Description</th>
          <th>Count</th>
          <th>Legend</th>
        </tr>
        <c:set var="odd" value="${true}"/>
        <c:forEach items="${domains}" var="domain">
          <c:set var="rowClass" value="${odd ? 'rowLight' : 'rowMedium'}" />
          <c:set var="odd" value="${not odd}" />
          <tr id="${domain['primary_identifier']}" class="domain ${rowClass}">
            <td>${domain["primary_identifier"]}</td>
            <td>${domain["secondary_identifier"]}</td>
            <td>${domain["remark"]}</td>
            <td>${domain["count"]}</td>
            <td><div class="legend"> </div></td>
          </tr>
        </c:forEach>
      </table>
    </jsp:attribute>
  </imp:toggle>

  <!-- <h3>List of Protein Domain Architectures</h3> -->
  <imp:toggle name="pfam-domain-architectures" displayName="Protein Domain Architectures" isOpen="true">
    <jsp:attribute name="content">
      <table id="proteins" class="wdk-data-table" data-sorting="[true, true, false]" maxLength="${maxLength}" width="100%">
        <thead>
          <tr>
            <th>Accession</th>
            <th>Length</th>
            <th id="ruler" width="100%"></th>
          </tr>
        </thead>
        <tbody>
          <c:set var="odd" value="${true}"/>
          <c:forEach items="${proteinGroups}" var="proteinGroup">
            <c:set var="sourceId" value="${proteinGroup[0]['source_id'].value}"/>
            <c:set var="rowClass" value="${odd ? 'rowLight' : 'rowMedium'}" />
            <c:set var="odd" value="${!odd}"/>
            <tr class="protein ${rowClass}">
              <td class="source-id">
                <a href="${pageContext.request.contextPath}/showRecord.do?name=SequenceRecordClasses.SequenceRecordClass&amp;source_id=${sourceId}' />">${sourceId}</a>
              </td>
              <td class="length">${proteinGroup[0]['length']}</td>
              <td>
                <div class="domains">
                  <div class="protein-graph"><jsp:text/></div>
                  <c:forEach items="${proteinGroup}" var="row">
                    <c:set var="name" value="${row['primary_identifier'].value}"/>
                    <c:set var="start" value="${row['start_min']}"/>
                    <c:set var="end" value="${row['end_max']}"/>
                    <c:if test="${not empty name}">
                      <div class="domain" id="${name}" start="${start}" end="${end}"
                           title="${name} (location: [${start} - ${end}])">
                        <div></div>
                      </div>
                    </c:if>
                  </c:forEach>
                </div>
              </td>
            </tr>
          </c:forEach>
        </tbody>
      </table>
    </jsp:attribute>
  </imp:toggle>
</jsp:root>
