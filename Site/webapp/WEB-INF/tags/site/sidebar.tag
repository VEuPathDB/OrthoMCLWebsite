<?xml version="1.0" encoding="UTF-8"?>
<jsp:root version="2.0"
    xmlns:jsp="http://java.sun.com/JSP/Page"
    xmlns:c="http://java.sun.com/jsp/jstl/core">

  <c:set var="wdkModel" value="${applicationScope.wdkModel}"/>
  <c:set var="project" value="${wdkModel.displayName}"/>
  <c:set var="wdkUser" value="${sessionScope.wdkUser}"/>

	<!-- load help record and taxon info -->
	<c:set var="helperQuestion" value="${wdkModel.questionSetsMap['HelperQuestions'].questionsMap['ByDefault']}"/>
	
  <!-- must set user on question before retrieving answer value -->	
	<jsp:setProperty name="helperQuestion" property="user" value="${wdkUser}"/>
	
	<!-- compile records and obtain statistics -->
	<c:forEach items="${helperQuestion.answerValue.records}" var="item">
	  <c:set var="helperRecord" value="${item}"/>
	</c:forEach>
	<c:set var="organism_count" value="${helperRecord.attributes['organism_count']}"/>
	<c:set var="protein_count" value="${helperRecord.attributes['protein_count']}"/>
	<c:set var="group_count" value="${helperRecord.attributes['group_count']}"/>

  <span class="onload-function" data-function="Setup.configureSidebar"><jsp:text/></span>

	<div id="sidebar">
	  <h3>
		  <img src="/assets/images/${project}/menu_lft1.png" alt="" width="208" height="12"/>
	    <a class="heading" id="stats" href="#">Data Summary</a>
	  </h3>
	  <div>
	    <ul>
	      <li><a href="${pageContext.request.contextPath}/getDataSummary.do?summary=data">Genomes: <b>${organism_count}</b></a></li>
	      <li>Protein Sequences: <b>${protein_count}</b></li>
	      <li>Ortholog Groups: <b>${group_count}</b></li>
	    </ul>
	  </div>
	
	  <h3>
	    <img src="/assets/images/${project}/menu_lft1.png" alt="" width="208" height="12"/>
	    <a class="heading" href="#">News</a>
	  </h3>
	  <div>
	    <ul>
	      <li><a href="/showDataSummary.do?data=orgamism">Show Organism Summary</a></li>
	      <li><a href="/showDataSummary.do?data=protein">Show Protein Summary</a></li>
	    </ul>
	  </div>
	
	  <h3><a href="#community">Community Resources</a></h3>
	  <div>
	    <ul>
	      <li><a href="/showDataSummary.do?data=orgamism">Show Organism Summary</a></li>
	      <li><a href="/showDataSummary.do?data=protein">Show Protein Summary</a></li>
	    </ul>
	  </div>
	
	  <h3><a href="#tutorials">Web Tutorials</a></h3>
	  <div> 
	    <ul>
	      <li><a href="/showDataSummary.do?data=orgamism">Show Organism Summary</a></li>
	      <li><a href="/showDataSummary.do?data=protein">Show Protein Summary</a></li>
	    </ul>
	  </div>
	
	  <h3><a href="#help">Information and Help</a></h3>
	  <div> 
	    <ul>
	      <li><a href="/showDataSummary.do?data=orgamism">Show Organism Summary</a></li>
	      <li><a href="/showDataSummary.do?data=protein">Show Protein Summary</a></li>
	    </ul>
	  </div>
	</div>

</jsp:root>
