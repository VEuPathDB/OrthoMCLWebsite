<?xml version="1.0" encoding="UTF-8"?>
<jsp:root version="2.0"
    xmlns:jsp="http://java.sun.com/JSP/Page"
    xmlns:c="http://java.sun.com/jsp/jstl/core"
    xmlns:html="http://jakarta.apache.org/struts/tags-html"
    xmlns:imp="urn:jsptagdir:/WEB-INF/tags/imp">
  <jsp:directive.page contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"/>

  <c:set var="wdkQuestion" value="${requestScope.wdkQuestion}"/>

  <!-- load the taxon info -->
  <c:set var="helperQuestions" value="${wdkModel.questionSetsMap['HelperQuestions']}"/>
  <c:set var="helperQuestion" value="${helperQuestions.questionsMap['ByDefault']}"/>
  <jsp:setProperty name="helperQuestion" property="user" value="${wdkUser}"/>
  <c:set var="helperRecords" value="${helperQuestion.answerValue.records}"/>
  <c:forEach items="${helperRecords}" var="item">
    <c:set var="helperRecord" value="${item}"/>
  </c:forEach>
  <c:set var="taxons" value="${helperRecord.tables['Taxons']}"/>

  <div id="taxons" style="display:none">
    <c:forEach items="${taxons}" var="row">
      <div class="taxon" taxon-id="${row['taxon_id']}"
           parent="${row['parent_id']}" abbrev="${row['abbreviation']}" 
           leaf="${row['is_species']}" index="${row['sort_index']}"
           common-name="${row['common_name']}">${row['name']}</div>
    </c:forEach>
  </div>

  <div class="content-pane notcollapsible">
    <p>
      Find Ortholog Groups that have a particular phyletic pattern, i.e., that include or exclude taxa or species that you specify.
    </p>

    <br/>

    <p>
    The search is controlled by the Phyletic Pattern Expression (PPE) shown in the text box. Use either the text box or the graphical tree display, or both, to specify your pattern.  The graphical tree display is a friendly way to generate a pattern expression.  You can always edit the expression directly.  For PPE help see the bottom of this page.
    </p>

    <br/>

    <p>
      In the graphical tree display:
      <ul class="cirbulletlist" style="padding-top:0.4em; padding-left:0.6em">
      <li>Click on -/+ to show or hide subtaxa and species.</li>
      <li>Click on the <img border="0" src="${pageContext.request.contextPath}/wdkCustomization/images/dc.gif"/> icon to specify which taxa or species to include or exclude in the profile.</li>
      <li>Refer to the legend below to understand other icons.</li>
       </ul>
    </p>
  </div>

  <!-- show error messages, if any -->
  <div class="usererror">
    <imp:errors/>
  </div>

  <div id="phyletic-search" class="params">
    <div class="expression">
      <input type="hidden" value="${wdkQuestion.fullName}" name="questionFullName"/>
      Expression:
      <html:text property="value(phyletic_expression)" styleId="query_top" size="100" onchange="changePPE(true)"/>
      <input type="submit" value="Get Answer" name="questionSubmit"/>
    </div>
    <div id="phyletic-legend">
      <b>Key:</b> <img border="0" src="${pageContext.request.contextPath}/wdkCustomization/images/dc.gif"/> =no constraints
      | <img border="0" src="${pageContext.request.contextPath}/wdkCustomization/images/yes.gif"/> =must be in group
      | <img border="0" src="${pageContext.request.contextPath}/wdkCustomization/images/maybe.gif"/> =at least one subtaxon must be in group
      | <img border="0" src="${pageContext.request.contextPath}/wdkCustomization/images/no.gif"/> =must not be in group
      | <img border="0" src="${pageContext.request.contextPath}/wdkCustomization/images/unk.gif"/> =mixture of constraints
    </div>
    <div id="phyletic-tree">
    </div>
    <div class="expression">
      Expression:
      <html:text property="value(phyletic_expression)" styleId="query_bottom" size="100" onchange="changePPE(false)"/>
    </div>
  </div>

  <script type="text/javascript">
  
      var taxons = { };
      
      <c:forEach items="${taxons}" var="row">
        <c:set var="taxonId" value="${row['taxon_id']}"/>
        <c:set var="name" value="${row['name']}"/>
        <c:set var="commonName" value="${row['common_name']}"/>
        <c:set var="parentId" value="${row['parent_id']}"/>
        <c:set var="abbreviation" value="${row['abbreviation']}"/>
        <c:set var="sortIndex" value="${row['sort_index']}"/>
        <c:set var="isSpecies" value="${row['is_species']}"/>

        taxons["${taxonId}"] = {
          id: "${taxonId}",
          parent_id: "${parentId}",
          abbrev: "${abbreviation}",
          name: "${name}",
          common_name: "${commonName}",
          state: 'dc',
          is_species: (${isSpecies} == 0) ? false : true,
          index: ${sortIndex},
          children: new Array()
        };
      </c:forEach>

      initial();
  </script>
</jsp:root>
