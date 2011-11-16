<%@ taglib prefix="site" tagdir="/WEB-INF/tags/site" %>
<%@ taglib prefix="wdk" tagdir="/WEB-INF/tags/wdk" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="w" uri="http://www.servletsuite.com/servlets/wraptag" %>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>

<!-- get wdkRecord from proper scope -->
<c:set value="${requestScope.wdkRecord}" var="wdkRecord"/>
<c:set var="groupName" value="${wdkRecord.attributes['group_name']}" />
<c:set var="proteins" value="${wdkRecord.tables['ProteinPFams']}" />
<c:set var="domains" value="${wdkRecord.tables['PFams']}" />

<%-- generate domain colors --%>
<c:set var="domainCount" value="${fn:length(domains)}" />
<c:set var="maxLength" value="${wdkRecord.attributes['max_length']}" />


<script type="text/javascript">
$(initializePfams);
</script>


<h3>List of Domains (present in this group)</h3>
<table id="domains" count="${domainCount}" seed="${groupName}">
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


<h3>List of Protein Domain Architectures</h3>
<table id="proteins" maxLength="${maxLength}" width="100%">
  <tr>
    <th>Accession</th>
    <th>Length</th>
    <th id="ruler" width="100%"></th>
  </tr>

  <c:set var="odd" value="${true}" />
  <c:set var="previous_id" value="${''}" />
  <c:forEach items="${proteins}" var="row">
    <c:set var="source_id" value="${row['source_id'].value}" />
    <c:if test="${previous_id != source_id}">
      <c:if test="${previous_id != ''}"></div></td></tr></c:if>
      <c:set var="previous_id" value="${source_id}" />
      <c:set var="rowClass" value="${odd ? 'rowLight' : 'rowMedium'}" />
      <c:set var="odd" value="${!odd}" />
      <tr class="protein ${rowClass}">
        <td class="source-id">
          <a href="<c:url value='/showRecord.do?name=SequenceRecordClasses.SequenceRecordClass&source_id=${source_id}' />">${source_id}</a>
        </td>
        <td class="length">${row['length']}</td>
        <td>
          <div class="domains">
            <div class="protein-graph"> </div>
    </c:if>
    <c:set var="name" value="${row['primary_identifier'].value}" />
    <c:set var="start" value="${row['start_min']}" />
    <c:set var="end" value="${row['end_max']}" />
    <c:if test="${name != null && name != ''}">
      <div class="domain" id="${name}" start="${start}" end="${end}"
           title="${name} (location: [${start} - ${end}])">
        <div></div>
      </div>
    </c:if>
  </c:forEach>
  <c:if test="${previous_id != ''}">
  <div></td></tr>
</c:if>
</table>

