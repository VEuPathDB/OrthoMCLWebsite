<%@ taglib prefix="imp" tagdir="/WEB-INF/tags/imp" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="w" uri="http://www.servletsuite.com/servlets/wraptag" %>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>

<!-- get wdkRecord from proper scope -->
<c:set value="${requestScope.wdkRecord}" var="wdkRecord"/>
<c:set var="sourceId" value="${wdkRecord.attributes['full_id']}" />

<span class="onload-function" data-function="eupathdb.pfamDomain.init"><jsp:text/></span>

<table width="100%" class="wdk-record-table">

  <c:forEach items="${wdkRecord.summaryAttributes}" var="attr">
    <c:set var="fieldVal" value="${attr.value}"/>
    <c:if test="${fieldVal.attributeField.internal == false}">
      <tr>
        <td class="label">${fieldVal.displayName}: </td>
        <td>
          <!-- need to know if fieldVal should be hot linked -->

          <c:choose>
            <c:when test="${fieldVal.class.name eq 'org.gusdb.wdk.model.record.attribute.LinkAttributeValue'}">
              <a href="${fieldVal.url}">${fieldVal.displayText}</a>
            </c:when>
            <c:otherwise>
              <font class="fixed"><w:wrap size="60">${fieldVal.value}</w:wrap></font>
            </c:otherwise>
          </c:choose>
        </td>
      </tr>
    </c:if>
  </c:forEach>
</table>

<!-- show all tables for record -->
<c:forEach items="${wdkRecord.tables}"  var="tblEntry">
  <c:set var="wdkTable" value="${tblEntry.value}" />
  <c:choose>
    <c:when test="${wdkTable.name == 'PFamDomains'}">

      <c:set var="domainCount" value="${wdkTable.numRows}" />
      <c:set var="maxLength" value="${wdkRecord.attributes['length']}" />
  <imp:toggle name="pfam-domains" displayName="PFam Domains" isOpen="true">
    <jsp:attribute name="content">

      <h4>Domain Architecture</h4>
      <table id="proteins" maxLength="${maxLength}" width="100%">

        <c:set var="odd" value="${true}" />
        <c:set var="rowClass" value="${odd ? 'rowLight' : 'rowMedium'}" />
        <c:set var="odd" value="${!odd}" />
        <tr class="protein ${rowClass}">
          <td>
            <div class="domains">
              <div class="protein-graph"> </div>
              <c:forEach items="${wdkTable.iterator}" var="row">
                <c:set var="name" value="${row['accession'].value}" />
                <c:set var="start" value="${row['start_min']}" />
                <c:set var="end" value="${row['end_max']}" />
                <c:if test="${name ne null and name ne ''}">
                  <div class="domain" id="${name}" start="${start}" end="${end}"
                       data-index="${row['domain_index']}" data-max="${row['max_index']}"
                       title="${name} (location: [${start} - ${end}])">
                  </div>
                </c:if>
              </c:forEach>
            </div>
          </td>
        </tr>
      </table>

      <br />
      <table id="domains" class="recordTable wdk-data-table" count="${domainCount}" seed="${sourceId}">
        <thead>
          <tr>
            <th>Accession</th>
            <th>Name</th>
            <th>Description</th>
            <th>Start</th>
            <th>End</th>
            <th>Legend</th>
          </tr>
        </thead>
        <tbody>
          <c:set var="odd" value="${true}" />
          <c:forEach items="${wdkTable.iterator}" var="domain">
            <c:set var="rowClass" value="${odd ? 'rowLight' : 'rowMedium'}" />
            <c:set var="odd" value="${!odd}" />
            <tr id="${domain['accession']}" class="domain ${rowClass}"
                data-index="${domain['domain_index']}" data-max="${domain['max_index']}" >
              <td><a href="http://pfam.xfam.org/family/${domain["accession"]}">${domain["accession"]}</a></td>
              <td>${domain["symbol"]}</td>
              <td>${domain["description"]}</td>
              <td>${domain["start_min"]}</td>
              <td>${domain["end_max"]}</td>
              <td><div class="legend"> </div></td>
            </tr>
          </c:forEach>
        </tbody>
      </table>


    </jsp:attribute>
  </imp:toggle>

    </c:when>

    <c:when test="${wdkTable.tableField.internal == false}">
      <div><jsp:text /></div>
      <imp:wdkTable tblName="${tblEntry.key}" isOpen="true"/>
    </c:when>

  </c:choose>
</c:forEach>
