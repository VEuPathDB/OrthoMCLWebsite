<%@ taglib prefix="imp" tagdir="/WEB-INF/tags/imp" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="w" uri="http://www.servletsuite.com/servlets/wraptag" %>
<%@ taglib prefix="html" uri="http://jakarta.apache.org/struts/tags-html" %>
<%@ taglib prefix="random" uri="http://jakarta.apache.org/taglibs/random-1.0" %><%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>

<%-- TRANSPARENT PNGS for IE6 --%>
<%--  <script defer type="text/javascript" src="/assets/js/pngfix.js"></script>   --%>

<%-- get wdkModel saved in application scope --%>
<c:set var="wdkModel" value="${applicationScope.wdkModel}"/>
<c:set var="questionSets" value="${wdkModel.questionSetsMap}"/>

<%-- GROUP --%>
<c:set var="groupSet" value="${questionSets['GroupQuestions']}"/>
<c:set var="groupQuestion" value="${groupSet.questionsMap['ByAccession']}"/>
<c:set var="groupNameParam" value="${groupQuestion.paramsMap['group_name']}"/>

<table id="quick-search">
<tr>
<td id="group-quicksearch">
  <form method="get" action="<c:url value='/processQuestionSetsFlat.do' />">
    <input type="hidden" name="questionFullName" value="${groupQuestion.fullName}"/>
    <input type="hidden" name="questionSubmit" value="Get Answer"/>
    <label>
      <b><a href="<c:url value='/showQuestion.do?questionFullName=${GroupQuestions.ByNameList}'/>"
            title="Enter a Group name. Use * as a wildcard (to obtain more than one). Click to enter multiple Group names"
            >Group name:</a></b>
    </label>
    <input type="text" class="search-box" name="value(${groupNameParam.name})" value="${groupNameParam.default}" />
    <input name="go" value="go" type="image" src="<c:url value='/wdkCustomization/images/mag_glass.png' />"
           alt="Click to search" width="23" height="23" class="img_align_middle" />
  </form>
</td>


<%-- SEQUENCE --%>
<c:set var="sequenceSet" value="${questionSets['SequenceQuestions']}"/>
<c:set var="sequenceQuestion" value="${sequenceSet.questionsMap['ByAccession']}"/>
<c:set var="sourceIdParam" value="${sequenceQuestion.paramsMap['accession']}"/>

<td id="sequence-quicksearch">
  <form method="get" action="<c:url value='/processQuestionSetsFlat.do' />">
    <input type="hidden" name="questionFullName" value="${sequenceQuestion.fullName}"/>
    <input type="hidden" name="questionSubmit" value="Get Answer"/>
    <label>
      <b><a href="<c:url value='/showQuestion.do?questionFullName=${SequenceQuestions.ByIdList}'/>"
            title="Enter a Gene source id. Use * as a wildcard (to obtain more than one). Click to enter multiple source ids."
            >Sequence id:</a></b>
    </label>
    <input type="text" class="search-box" name="value(${sourceIdParam.name})" value="${sourceIdParam.default}" />
    <input name="go" value="go" type="image" src="<c:url value='/wdkCustomization/images/mag_glass.png' />"
           alt="Click to search" width="23" height="23" class="img_align_middle" />
  </form>
</td>
</tr>
</table>

