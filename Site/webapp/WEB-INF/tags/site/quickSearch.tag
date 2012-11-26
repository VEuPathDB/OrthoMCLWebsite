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


<script type="text/javascript">
  $(function() { assignTooltips('.head-search-tip'); });
</script>

<table id="quick-search">
  <tr>

    <%-- GROUP --%>
    <c:set var="groupSet" value="${questionSets['GroupQuestions']}"/>
    <c:set var="groupQuestion" value="${groupSet.questionsMap['ByTextSearch']}"/>
    <c:set var="groupTextExpressionParam" value="${groupQuestion.paramsMap['text_expression']}"/>
    <c:set var="groupWdkRecordTypeParam" value="${groupQuestion.paramsMap['wdk_record_type']}"/>
    <c:set var="groupTextFieldsParam" value="${groupQuestion.paramsMap['text_fields']}"/>
    <c:set var="groupDetailTableParam" value="${groupQuestion.paramsMap['detail_table']}"/>
    <c:set var="groupPrimaryKeyColumnParam" value="${groupQuestion.paramsMap['primary_key_column']}"/>
    <c:set var="groupProjectIdParam" value="${groupQuestion.paramsMap['project_id']}"/>

    <td id="group-quicksearch">
      <form method="get" action="<c:url value='/processQuestionSetsFlat.do' />">
        <span class="head-search-tip"
            title="Use * as a wildcard, as in *inase, kin*se, kinas*. Do not use AND, OR. Use quotation marks to find an exact phrase. Click on 'Group Text Search' to access the advanced group search page.">
          <input type="hidden" name="questionFullName" value="${groupQuestion.fullName}"/>
          <input type="hidden" name="questionSubmit" value="Get Answer"/>
          <input type="hidden" name="value(${groupWdkRecordTypeParam.name})"
              value="${groupWdkRecordTypeParam.default}" />
          <input type="hidden" name="array(${groupTextFieldsParam.name})"
              value="PFam domain names and descriptions" />
          <input type="hidden" name="array(${groupTextFieldsParam.name})"
              value="Sequence IDs descriptions and taxa" />
          <input type="hidden" name="value(${groupDetailTableParam.name})"
              value="${groupDetailTableParam.default}" />
          <input type="hidden" name="value(${groupPrimaryKeyColumnParam.name})"
              value="${groupPrimaryKeyColumnParam.default}" />
          <input type="hidden" name="value(${groupProjectIdParam.name})" value="OrthoMCL" />
          <label>
            <b><a href="${pageContext.request.contextPath}/showQuestion.do?questionFullName=GroupQuestions.ByTextSearch">Group Text Search:</a></b>
          </label>
          <input type="text" class="search-box" name="value(${groupTextExpressionParam.name})"
              value="${groupTextExpressionParam.default}" />
          <input name="go" value="go" type="image"
              src="${pageContext.request.contextPath}/wdkCustomization/images/mag_glass.png"
              alt="Click to search" width="23" height="23" class="img_align_middle" />
        </span>
      </form>
    </td>

    <%-- SEQUENCE --%>
    <c:set var="sequenceSet" value="${questionSets['SequenceQuestions']}"/>
    <c:set var="sequenceQuestion" value="${sequenceSet.questionsMap['ByTextSearch']}"/>
    <c:set var="sequenceTextExpressionParam" value="${sequenceQuestion.paramsMap['text_expression']}"/>
    <c:set var="sequenceWdkRecordTypeParam" value="${sequenceQuestion.paramsMap['wdk_record_type']}"/>
    <c:set var="sequenceTextFieldsParam" value="${sequenceQuestion.paramsMap['text_fields']}"/>
    <c:set var="sequenceDetailTableParam" value="${sequenceQuestion.paramsMap['detail_table']}"/>
    <c:set var="sequencePrimaryKeyColumnParam" value="${sequenceQuestion.paramsMap['primary_key_column']}"/>
    <c:set var="sequenceProjectIdParam" value="${sequenceQuestion.paramsMap['project_id']}"/>

    <td id="sequence-quicksearch">
      <form method="get" action="<c:url value='/processQuestionSetsFlat.do' />">
        <span class="head-search-tip"
            title="Use * as a wildcard, as in *inase, kin*se, kinas*. Do not use AND, OR. Use quotation marks to find an exact phrase. Click on 'Sequence Text Search' to access the advanced sequence search page.">
          <input type="hidden" name="questionFullName" value="${sequenceQuestion.fullName}"/>
          <input type="hidden" name="questionSubmit" value="Get Answer"/>
          <input type="hidden" name="value(${sequenceWdkRecordTypeParam.name})"
              value="${sequenceWdkRecordTypeParam.default}" />
          <input type="hidden" name="array(${sequenceTextFieldsParam.name})"
              value="Product" />
          <input type="hidden" name="array(${sequenceTextFieldsParam.name})"
              value="PFam domain names and descriptions" />
          <input type="hidden" name="array(${sequenceTextFieldsParam.name})"
              value="Taxon" />
          <input type="hidden" name="array(${sequenceTextFieldsParam.name})"
              value="Old OrthoMCL groups (from previous releases)" />
          <input type="hidden" name="value(${sequenceDetailTableParam.name})"
              value="${sequenceDetailTableParam.default}" />
          <input type="hidden" name="value(${sequencePrimaryKeyColumnParam.name})"
              value="${sequencePrimaryKeyColumnParam.default}" />
          <input type="hidden" name="value(${sequenceProjectIdParam.name})" value="OrthoMCL" />
          <label>
            <b><a href="${pageContext.request.contextPath}/showQuestion.do?questionFullName=SequenceQuestions.ByTextSearch">Sequence Text Search:</a></b>
          </label>
          <input type="text" class="search-box" name="value(${sequenceTextExpressionParam.name})" value="${sequenceTextExpressionParam.default}" />
          <input name="go" value="go" type="image" src="${pageContext.request.contextPath}/wdkCustomization/images/mag_glass.png"
                 alt="Click to search" width="23" height="23" class="img_align_middle" />
        </span>
      </form>
    </td>
  </tr>
</table>
