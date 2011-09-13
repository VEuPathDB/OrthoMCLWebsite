<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>
<%@ taglib prefix="pg" uri="http://jsptags.com/tags/navigation/pager" %>
<%@ taglib prefix="wdk" tagdir="/WEB-INF/tags/wdk" %>


<c:set var="wdkModel" value="${applicationScope.wdkModel}" />
<c:set var="wdkUser" value="${sessionScope.wdkUser}" />
<c:set var="wdkStep" value="${requestScope.wdkStep}" />
<c:set var="question" value="${wdkStep.question}" />
<c:set var="wdkAnswer" value="${wdkStep.answerValue}"/>
<c:set var="answerRecords" value="${wdkAnswer.records}" />
<c:set var="rcName" value="${question.recordClass.fullName}" />

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

<script>
$(function() {
    document.groupManager = new GroupManager();
    document.groupManager.initialize();
});
</script>


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


<!-- pager -->
<pg:pager isOffset="true"
          scope="request"
          items="${wdk_paging_total}"
          maxItems="${wdk_paging_total}"
          url="${wdk_paging_url}"
          maxPageItems="${wdk_paging_pageSize}"
          export="currentPageNumber=pageNumber">
  <c:forEach var="paramName" items="${wdk_paging_params}">
    <pg:param name="${paramName}" id="pager" />
  </c:forEach>
  <c:if test="${wdk_summary_checksum != null}">
    <pg:param name="summary" id="pager" />
  </c:if>
  <c:if test="${wdk_sorting_checksum != null}">
    <pg:param name="sort" id="pager" />
  </c:if>

<%--------- PAGING TOP BAR ----------%>
<table width="100%" border="0" cellpadding="3" cellspacing="0">
	<tr class="subheaderrow">
	<th style="text-align: left;white-space:nowrap;"> 
	       <wdk:pager wdkAnswer="${wdkAnswer}" pager_id="top"/> 
	</th>
	<th style="text-align: right;white-space:nowrap;">
               <wdk:addAttributes wdkAnswer="${wdkAnswer}" commandUrl="${commandUrl}"/>
	</th>
	<th style="text-align: right;white-space:nowrap;width:5%;">
	    &nbsp;
	</th>
	</tr>
</table>
<%--------- END OF PAGING TOP BAR ----------%>

<!-- content of current page -->
<c:set var="sortingAttrNames" value="${wdkAnswer.sortingAttributeNames}" />
<c:set var="sortingAttrOrders" value="${wdkAnswer.sortingAttributeOrders}" />

<%--------- RESULTS  ----------%>
<div class="Results_Div flexigrid">
<div class="bDiv">
<div class="bDivBox">
<table id="groups" class="Results_Table" width="100%" border="0" cellpadding="3" cellspacing="0" step="${wdkStep.stepId}">
<tbody class="rootBody">

<c:set var="i" value="0"/>

<c:forEach items="${answerRecords}" var="record">
  <c:choose>
    <c:when test="${i % 2 == 0}"><tr class="lines"></c:when>
    <c:otherwise><tr class="linesalt"></c:otherwise>
  </c:choose>

  <c:set value="${record.primaryKey}" var="primaryKey"/>
  <c:set var="pkValues" value="${primaryKey.values}" />
  <c:set var="recordLinkKeys" value="" />
  <c:forEach items="${pkValues}" var="pkValue">
      <c:set var="recordLinkKeys" value="${recordLinkKeys}&${pkValue.key}=${pkValue.value}" />
  </c:forEach>
  <td width="100">
    <a href="showRecord.do?name=${rcName}${recordLinkKeys}">${primaryKey}</a>
  </td>

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
<c:set var="i" value="${i+1}"/>
</c:forEach>

</tbody>
</table>
</div>
</div>
</div>
<%--------- END OF RESULTS  ----------%>

<%--------- PAGING BOTTOM BAR ----------%>
<table width="100%" border="0" cellpadding="3" cellspacing="0">
	<tr class="subheaderrow">
	<th style="text-align:left;white-space:nowrap;"> 
	       <wdk:pager wdkAnswer="${wdkAnswer}" pager_id="bottom"/> 
	</th>
	<th style="text-align:right;white-space:nowrap;">
		&nbsp;
	</th>
	<th style="text-align:right;white-space:nowrap;width:5%;">
	    &nbsp;
	</th>
	</tr>
</table>
<%--------- END OF PAGING BOTTOM BAR ----------%>
</pg:pager>

