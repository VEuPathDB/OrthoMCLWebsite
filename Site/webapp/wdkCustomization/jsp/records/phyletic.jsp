<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>
<%@ taglib prefix="pg" uri="http://jsptags.com/tags/navigation/pager" %>
<%@ taglib prefix="wdk" tagdir="/WEB-INF/tags/wdk" %>


<c:set var="wdkModel" value="${applicationScope.wdkModel}" />
<c:set var="wdkUser" value="${sessionScope.wdkUser}" />
<c:set var="record" value="${requestScope.wdkRecord}" />
<c:set var="recordClass" value="${record.recordClass}" />


<script type="text/javascript" src="<c:url value='/wdkCustomization/js/group.js' />"></script>


<%-- load the taxon info --%>
<c:set var="helperQuestions" value="${wdkModel.questionSetsMap['HelperQuestions']}" />
<c:set var="helperQuestion" value="${helperQuestions.questionsMap['ByDefault']}" />
<jsp:setProperty name="helperQuestion" property="user" value="${wdkUser}" />
<c:set var="helperRecords" value="${helperQuestion.answerValue.records}" />
<c:forEach items="${helperRecords}" var="item">
  <c:set var="helperRecord" value="${item}" />
</c:forEach>
<c:set var="taxons" value="${helperRecord.tables['Taxons']}" />

<div id="taxons" style="display:none">
  <c:forEach items="${taxons}" var="row">
    <div class="taxon" taxon-id="${row['taxon_id']}"
         parent="${row['parent_id']}" abbrev="${row['abbreviation']}" 
         leaf="${row['is_species']}" index="${row['sort_index']}"
         common-name="${row['common_name']}">${row['name']}</div>
  </c:forEach>
</div>

<div id="taxon-display"></div>

<div id="legend">
    <div class="count"><span count="0">&nbsp;0&nbsp;</span> no ortholog; </div>
    <div class="count"><span count="1">&nbsp;1&nbsp;</span> one ortholog; </div>
    <div class="count"><span count="2">&nbsp;n&nbsp;</span> more than one ortholog; </div>

</div>

<div id="control">
  <input id="showDetail" type="checkbox" checked="true" />group details <br />
  <input id="showPhyletic" type="checkbox" checked="true" />phyletic pattern <br />
  <input id="showCount" type="checkbox" checked="true" />phyletic pattern labels <br />
</div>



<table id="groups" class="Results_Table" width="100%" border="0" cellpadding="3" cellspacing="0">
<tbody class="rootBody">

  <c:choose>
    <c:when test="${i % 2 == 0}"><tr class="lines"></c:when>
    <c:otherwise><tr class="linesalt"></c:otherwise>
  </c:choose>

  <c:set value="${record.primaryKey}" var="primaryKey"/>
  <td width="100">${primaryKey}</td>

  <%-- load the taxon count --%>
  <c:set var="taxonCounts" value="${record.tables['TaxonCounts']}" />

  <td id="${primaryKey}" class="group">
    <div class="count-data">
      <c:forEach items="${taxonCounts}" var="row">
        <div class="count" taxon-id="${row['taxon_id']}">${row['count']}</div>
      </c:forEach>
    </div>
    <div class="phyletic-pattern"></div>
  </td>

</tr>

</tbody>
</table>
