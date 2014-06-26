<?xml version="1.0" encoding="UTF-8"?>
<jsp:root version="2.0"
    xmlns:jsp="http://java.sun.com/JSP/Page"
    xmlns:c="http://java.sun.com/jsp/jstl/core"
    xmlns:imp="urn:jsptagdir:/WEB-INF/tags/imp"
	xmlns:svg="http://www.w3.org/2000/svg">
  <jsp:directive.page contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"/>

  <c:set var="layout" value="${requestScope.layout}" />

  <div class="group-layout">

    <div class="layout-data">
      <div class="nodes">
        <c:forEach items="${layout.nodes}" var="node">
          <c:set var="gene" value="${node.gene}" />
          <span class="gene" id="${node.index}" data-sourceId="${gene.sourceId}" data-taxon="${gene.taxon.abbrev}">
            ${gene.description}
          </span>
        </c:forEach>
      </div>
      <div class="edges">
        <c:forEach items="${layout.edges}" var="edge">
          <span class="score" id="${edge.nodeA.index}-${edge.nodeB.index}"
                data-evalue="${edge.evalue}" data-query="${edge.nodeA.index}" data-subject="${edge.nodeB.index}" />
        </c:forEach>
      </div>
    </div>

    <svg class="canvas" width="${layout.size}px" height="${layout.size}px" viewBox="0 0 ${layout.size} ${layout.size}">
      <rect class="background" x="0" y="0" width="${layout.size}" height="${layout.size}"/>

      <c:forEach items="${layout.edgesByType}" var="edgeGroup">
        <g class="edges ${edgeGroup.key}">
          <c:forEach items="${edgeGroup.value}" var="edge">
            <line class="edge" id="${edge.nodeA.index}-${edge.nodeB.index}" 
                  x1="${edge.nodeA.x}" y1="${edge.nodeA.y}" x2="${edge.nodeB.x}" y2="${edge.nodeB.y}" />
          </c:forEach>
        </g>
      </c:forEach>
	
      <c:forEach items="${layout.nodesByTaxon}" var="nodeGroup">
        <g class="nodes ${nodeGroup.key}">
          <c:forEach items="${nodeGroup.value}" var="node">
            <c:set var="gene" value="${node.gene}" />
            <circle id="${node.index}" class="node ${gene.taxon.abbrev}" cx="${node.x}" cy="${node.y}" r="6" />
          </c:forEach>
        </g>
      </c:forEach>

    </svg>

  </div>

</jsp:root>
