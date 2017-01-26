<?xml version="1.0" encoding="UTF-8"?>
<jsp:root version="2.0"
    xmlns:jsp="http://java.sun.com/JSP/Page"
    xmlns:c="http://java.sun.com/jsp/jstl/core"
    xmlns:imp="urn:jsptagdir:/WEB-INF/tags/imp">
  <jsp:directive.page contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"/>

  <!-- ORTHO data summary -->
  <imp:pageFrame refer="data-source" title="Release Summary">

  <c:set var="wdkRecord" value="${requestScope.wdkRecord}" />
  <c:set var="summary" value="${requestScope.summaryTable}" />
  <c:set var="taxons" value="${requestScope.taxons}" />
  <c:set var="recordClass" value="${requestScope.recordClass}" />


  <table class="recordTable wdk-data-table">

  <thead>
    <c:set var="h" value="0"/>
    <tr class="headerRow">
        <c:forEach var="hCol" items="${summary.tableField.attributeFields}">
           <c:if test="${hCol.internal == false}">
             <c:set var="h" value="${h+1}"/>
             <th align="left">${hCol.displayName}</th>
           </c:if>
        </c:forEach>
    </tr>
  </thead>

  <tbody>
    <c:set var="i" value="0"/>
    <c:forEach var="row" items="${summary.iterator}">
        <c:set var="rowClass">
        <c:choose>
            <c:when test="${i % 2 == 0}">rowLight</c:when>
            <c:otherwise>rowMedium</c:otherwise>
        </c:choose>
        </c:set>
        <tr class="${rowClass}">
        <c:forEach var="rColEntry" items="${row}">
          <c:set var="attributeValue" value="${rColEntry.value}"/>
          <c:if test="${attributeValue.attributeField.internal == false}">
            <c:choose>
              <c:when test="${rColEntry.key == 'root_taxon'}">
                 <c:set var="taxonKey" value="${row['three_letter_abbrev'].value}" />
                 <c:set var="taxon" value="${taxons[taxonKey]}" />
                 <c:set var="root" value="${taxon.root}" />
                 <td class="taxon-root" width="80" style="background-color:${root.color}"
                     title="${root.name}">
                   ${root.abbrev}
                 </td>
              </c:when>
              <c:otherwise>
                <imp:wdkAttribute attributeValue="${attributeValue}" truncate="false" recordClass="${recordClass}" />
              </c:otherwise>
            </c:choose>
          </c:if>
        </c:forEach>

        </tr>
        <c:set var="i" value="${i +  1}"/>
    </c:forEach>
  </tbody>
</table>

  </imp:pageFrame>

</jsp:root>
