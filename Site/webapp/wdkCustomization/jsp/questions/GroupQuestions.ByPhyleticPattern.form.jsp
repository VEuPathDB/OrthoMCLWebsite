<%@ taglib prefix="imp" tagdir="/WEB-INF/tags/imp" %>
<%@ taglib prefix="imp" tagdir="/WEB-INF/tags/imp" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="html" uri="http://jakarta.apache.org/struts/tags-html" %>
<%@ taglib prefix="bean" uri="http://jakarta.apache.org/struts/tags-bean" %>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>


<c:set var="wdkQuestion" value="${requestScope.wdkQuestion}"/>

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

<p>Use this query to find groups that have a particular phyletic pattern, i.e., that include or exclude taxa or species that you specify.</p>
<p>Click on +/- to show or hide subtaxa and species.</p>
<p>Click on the <img border=0 src="wdkCustomization/images/dc.gif"> icon to specify which taxa or species to include or exclude in the profile.  This fills in the text
 box with an equivalent <a href="cgi-bin/OrthoMclWeb.cgi?rm=groupQueryForm&type=ppexpression">PPE grammar</a> expression.  To refine the query, edit t
he expression in the text box as needed, following the PPE grammar as described on the <a href="cgi-bin/OrthoMclWeb.cgi?rm=groupQueryForm&type=ppexpre
ssion">Advanced Phyletic Pattern Query</a> page. Hit <b>Execute Phyletic Query</b> to run the query.</p>

<!-- show error messages, if any -->
<div class='usererror'><api:errors/></div>

<div id="phyletic-search" class="params">
<div class="expression">
  <input type="hidden" value="${wdkQuestion.fullName}" name="questionFullName" />
  Expression:
  <html:text property="value(phyletic_expression)" styleId="query_top" size="100" 
       onchange="changePPE(true)" />
  <input type="submit" value="Get Answer" name="questionSubmit" />
</div>
<div id="phyletic-legend">
    <b>Key:</b> <img border=0 src="wdkCustomization/images/dc.gif"> =no constraints
    | <img border=0 src="wdkCustomization/images/yes.gif"> =must be in group
    | <img border=0 src="wdkCustomization/images/no.gif"> =must not be in group
    | <img border=0 src="wdkCustomization/images/maybe.gif"> =at least one subtaxon must be in group
    | <img border=0 src="wdkCustomization/images/unk.gif"> =mixture of constraints
</div>
<div id="phyletic-tree">
 
</div>
<div class="expression">
  Expression:
  <html:text property="value(phyletic_expression)" styleId="query_bottom" size="100" 
       onchange="changePPE(false)" />
</div>
</div><%-- END OF PARAMS DIV --%>


<script type="text/javascript">

var taxons = { };

<c:forEach items="${taxons}" var="row">
  <c:set var="taxonId" value="${row['taxon_id']}" />
  <c:set var="name" value="${row['name']}" />
  <c:set var="commonName" value="${row['common_name']}" />
  <c:set var="parentId" value="${row['parent_id']}" />
  <c:set var="abbreviation" value="${row['abbreviation']}" />
  <c:set var="sortIndex" value="${row['sort_index']}" />
  <c:set var="isSpecies" value="${row['is_species']}" />

  taxons["${taxonId}"] = { id:"${taxonId}",
    parent_id:"${parentId}",
    abbrev:"${abbreviation}",
    name:"${name}",
    common_name: "${commonName}",
    state:0,
    is_species: (${isSpecies} == 0) ? false : true,
    index: ${sortIndex},
    children: new Array() };
</c:forEach>

initial();

</script>
<noscript>
Ack, this form won't work at all without JavaScript support!
</noscript>

