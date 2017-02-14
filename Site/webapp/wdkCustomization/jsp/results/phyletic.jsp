<?xml version="1.0" encoding="UTF-8"?>
<jsp:root version="2.0"
    xmlns:jsp="http://java.sun.com/JSP/Page"
    xmlns:c="http://java.sun.com/jsp/jstl/core"
    xmlns:fn="http://java.sun.com/jsp/jstl/functions"
    xmlns:pg="http://jsptags.com/tags/navigation/pager"
    xmlns:imp="urn:jsptagdir:/WEB-INF/tags/imp">
  <jsp:directive.page contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"/>

  <c:set var="wdkStep" value="${requestScope.wdkStep}"/>
  <c:set var="question" value="${wdkStep.question}"/>
  <c:set var="wdkAnswer" value="${wdkStep.answerValue}"/>
  <c:set var="answerRecords" value="${wdkAnswer.records}"/>
  <c:set var="rcName" value="${question.recordClass.fullName}"/>

  <span class="onload-function"
    data-function="initializePhyleticView"><jsp:text/>
  </span>

  <!-- load the taxon info. The taxon info is used by group phyletic pattern query -->
  <c:set var="helperQuestions" value="${wdkModel.questionSetsMap['HelperQuestions']}"/>
  <c:set var="helperQuestion" value="${helperQuestions.questionsMap['ByDefault']}"/>
  <jsp:setProperty name="helperQuestion" property="user" value="${wdkUser}"/>
  <c:set var="helperRecords" value="${helperQuestion.answerValue.records}"/>
  <c:forEach items="${helperRecords}" var="item">
    <c:set var="helperRecord" value="${item}"/>
  </c:forEach>
  <c:set var="taxons" value="${helperRecord.tables['Taxons']}"/>

  <div id="taxons" style="display:none">
    <c:forEach items="${taxons.iterator}" var="row">
      <div class="taxon" taxon-id="${row['taxon_id']}"
           parent="${row['parent_id']}" abbrev="${row['abbreviation']}" 
           leaf="${row['is_species']}" index="${row['sort_index']}"
           common-name="${row['common_name']}">${row['name']}</div>
    </c:forEach>
  </div>

  <div id="legend-wrapper">
    <h4 id="legend-label">Legend:</h4>
    <div id="legend">
      <div class="count"><span count="0">&#160;0&#160;</span> no ortholog </div>
      <div class="count"><span count="1">&#160;1&#160;</span> one ortholog </div>
      <div class="count"><span count="2">&#160;n&#160;</span> more than one ortholog </div>
    </div>

    <div id="taxon-display"></div>
    <div style="clear:both"><jsp:text/></div>
  </div>

  <div id="control">
    <input id="showCount" type="checkbox" checked="true"/>phyletic pattern labels<br/>
  </div>

  <!-- pager -->
  <pg:pager isOffset="true"
            scope="request"
            items="${wdk_paging_total}"
            maxItems="${wdk_paging_total}"
            url="${requestUri}"
            maxPageItems="${wdk_paging_pageSize}"
            export="currentPageNumber=pageNumber">
    <c:forEach var="paramName" items="${wdk_paging_params}">
      <pg:param name="${paramName}" id="pager" />
    </c:forEach>
    <c:if test="${wdk_summary_checksum ne null}">
      <pg:param name="summary" id="pager" />
    </c:if>
    <c:if test="${wdk_sorting_checksum ne null}">
      <pg:param name="sort" id="pager" />
    </c:if>

    <!--         PAGING TOP BAR          -->
    <table class="pager" width="100%" border="0" cellpadding="3" cellspacing="0">
	    <tr class="subheaderrow">
	      <th style="text-align:left; white-space:nowrap;"> 
	       <imp:pager wdkAnswer="${wdkAnswer}" pager_id="top"/> 
	      </th>
	      <th style="text-align: right;white-space:nowrap;">
          <imp:addAttributes wdkAnswer="${wdkAnswer}" commandUrl="${commandUrl}"/>
	      </th>
	      <th style="text-align:right; white-space:nowrap; width:5%;">
	        &#160;
	      </th>
	    </tr>
    </table>
    <!--        END OF PAGING TOP BAR         -->

    <!-- content of current page -->
    <c:set var="sortingAttrNames" value="${wdkAnswer.sortingAttributeNames}"/>
    <c:set var="sortingAttrOrders" value="${wdkAnswer.sortingAttributeOrders}"/>

    <!--        RESULTS          -->
    <div class="Results_Div flexigrid">
      <div class="bDiv">
        <div class="bDivBox">
          <table id="groups" class="Results_Table" width="100%" border="0" cellpadding="3" cellspacing="0" step="${wdkStep.stepId}">
            <tbody class="rootBody">
              <c:set var="i" value="0"/>
              <c:forEach items="${answerRecords}" var="record">
                <c:set var="rowClass" value="${i % 2 eq 0 ? 'lines' : 'linesalt'}"/>
                <c:set var="tables" value="${record.tables}" />
                <tr class="${rowClass}">
                  <c:set value="${record.primaryKey}" var="primaryKey"/>
								  <c:set var="pkValues" value="${primaryKey.values}"/>
								  <c:set var="recordLinkKeys" value=""/>
								  <c:forEach items="${pkValues}" var="pkValue">
								    <c:set var="recordLinkKeys" value="${recordLinkKeys}&amp;${pkValue.key}=${pkValue.value}"/>
								  </c:forEach>
                  <c:set var="keywords" value="${record.attributes['keywords']}"/>
                  <c:set var="descriptions" value="${record.attributes['descriptions']}"/>
								  <td width="100">
								    <a href="${pageContext.request.contextPath}/showRecord.do?name=${rcName}${recordLinkKeys}">${primaryKey}</a>
								  </td>
								
								  <!-- load the taxon count -->
								  <td id="${primaryKey}" class="group">
                    <div class="attr-keyword-freq">
                       <label>Keywords:</label>
                       <c:forEach items="${tables['KeywordFrequency'].iterator}" var="row" varStatus="loop">
                         <span class="keyword" title="frequency: ${row['frequency']}" 
                           data-frequency="${row['frequency']}">${row['keyword']}<c:if test="${not loop.last}">; </c:if>
                         </span>
                       </c:forEach>
                      <c:if test="${keywords eq ''}">
                        <span class="keyword" data-frequency="0">n/a</span>
                      </c:if>
                    </div>
                      <div class="attr-descriptions">
                       <label>Pfam Domains:</label>
                       <c:forEach items="${tables['DomainFrequency'].iterator}" var="row" varStatus="loop">
                         <span class="keyword" title="frequency: ${row['frequency']}" 
                           data-frequency="${row['frequency']}">${row['keyword']}<c:if test="${not loop.last}">; </c:if>
                         </span>
                       </c:forEach>
                      <c:if test="${descriptions eq ''}">
                        <span class="keyword" data-frequency="0">n/a</span>
                      </c:if>
                    </div>
								    <div class="count-data">
								      <c:forEach items="${tables['TaxonCounts'].iterator}" var="row">
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
    <!--        END OF RESULTS          -->

    <!--        PAGING BOTTOM BAR         -->
    <table width="100%" border="0" cellpadding="3" cellspacing="0">
	    <tr class="subheaderrow">
	      <th style="text-align:left;white-space:nowrap;"> 
	        <imp:pager wdkAnswer="${wdkAnswer}" pager_id="bottom"/> 
	      </th>
	      <th style="text-align:right; white-space:nowrap;">
		      &#160;
	      </th>
	      <th style="text-align:right; white-space:nowrap; width:5%;">
	        &#160;
	      </th>
	    </tr>
    </table>
    <!--        END OF PAGING BOTTOM BAR         -->
    
  </pg:pager>
</jsp:root>
