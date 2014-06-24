<?xml version="1.0" encoding="UTF-8"?>
<jsp:root version="2.0"
    xmlns:jsp="http://java.sun.com/JSP/Page"
    xmlns:c="http://java.sun.com/jsp/jstl/core"
    xmlns:imp="urn:jsptagdir:/WEB-INF/tags/imp"
	xmlns:svg="http://www.w3.org/2000/svg">
  <jsp:directive.page contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"/>

  <c:set var="layout" value="${requestScope.layout}" />

  <!-- ORTHO data summary -->
  <imp:pageFrame refer="data-source" title="${layout.groupName} Cluster Graph">

  <svg width="800px" height="800px">
    <c:forEach items="${layout.edges}" var="edge">
      <line class="edge ${edge.type}" x1="${edge.nodeA.x}" y1="${edge.nodeA.y}" x2="${edge.nodeB.x}" y2="${edge.nodeB.y}"
	        data-type="${edge.type}" data-evalue="${edge.evalue}" data-query="${edge.queryId}" data-subject="${edge.subjectId}" />
    </c:forEach>
	
	<c:forEach items="${layout.nodes}" var="node">
	  <c:set var="gene" value="${node.gene}" />
	  <circle id="${gene.sourceId}" class="node ${gene.taxon.abbrev}" cx="${node.x}" cy="${node.y}" r="10" />
	</c:forEach>
  </svg>

  </imp:pageFrame>

</jsp:root>
