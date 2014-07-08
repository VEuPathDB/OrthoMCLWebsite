<?xml version="1.0" encoding="UTF-8"?>
<jsp:root version="2.0"
    xmlns:jsp="http://java.sun.com/JSP/Page"
    xmlns:c="http://java.sun.com/jsp/jstl/core"
    xmlns:fn="http://java.sun.com/jsp/jstl/functions"
    xmlns:imp="urn:jsptagdir:/WEB-INF/tags/imp"
	  xmlns:svg="http://www.w3.org/2000/svg">
  <jsp:directive.page contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"/>

  <c:set var="layout" value="${requestScope.layout}" />
  <c:set var="group" value="${layout.group}" />
  <c:set var="taxons" value="${layout.taxons}" />

  <div class="group-layout" data-controller="orthomcl.group.layout.init">

    <div class="data">

      <div class="taxons">
        <c:forEach items="${taxons}" var="taxon">
          <span class="taxon" id="${taxon.abbrev}" 
                data-color="${taxon.color}" data-group-color="${taxon.groupColor}"
                data-common-name="${taxon.commonName}" data-species="${taxon.species}"
                data-parent="${taxon.parent.abbrev}" data-sort-index="${taxon.sortIndex}" >
            ${taxon.name}
          </span>
        </c:forEach>
      </div>

      <div class="nodes">
        <c:forEach items="${layout.nodes}" var="node">
          <c:set var="gene" value="${node.gene}" />
          <div class="node" id="${node.index}" data-source-id="${gene.sourceId}" 
                data-taxon="${gene.taxon.abbrev}" data-length="${gene.length}" data-x="${node.x}" data-y="${node.y}">
            <span class="description">${gene.description}</description>
            <c:forEach items="${gene.ecNumbers}" var="ecNumber">
              <span class="ec-number" id="${ecNumber}" />
            </c:forEach>
          </div>
        </c:forEach>
      </div>

      <div class="edges">
        <c:forEach items="${layout.edges}" var="edge">
          <span class="edge" id="${edge.nodeA.index}-${edge.nodeB.index}"
                data-type="${edge.type.code}" data-evalue="${edge.evalue}" 
                data-query="${edge.nodeA.index}" data-subject="${edge.nodeB.index}"
                data-score="${edge.scoreFormatted}" data-color="${edge.color}" />
        </c:forEach>
      </div>
      
      <div class="ec-numbers">
        <c:forEach items="${group.ecNumbers}" var="item">
          <c:set var="ecNumber" value="${item.value}" />
          <span class="ec-number" id="${ecNumber.code}" data-index="${ecNumber.index}" 
                data-color="${ecNumber.color}" data-count="${ecNumber.count}" />
        </c:forEach>
      </div>

    </div>

    <div class="controls accordion">
      <h3>Legend &amp; Options</h3>

      <div>

        <fieldset class="edge-control">
          <legend>Edges</legend>
          <div>
            Display edges By: 
            <input name="edge-display" class="edge-display" type="radio" value="type" checked="checked" /> Types
            <input name="edge-display" class="edge-display" type="radio" value="score" /> Blast scores
          </div>
          
          <div class="type-control control-section">
            <div class="edge-type">
              <input type="checkbox" value="Ortholog" checked="checked" /> 
              <div class="edge-legend Ortholog"> </div> Ortholog
            </div>
            <div class="edge-type">
              <input type="checkbox" value="Coortholog" checked="checked" />
              <div class="edge-legend Coortholog"> </div> Coortholog
            </div>
            <div class="edge-type">
              <input type="checkbox" value="Inparalog" checked="checked" /> 
              <div class="edge-legend Inparalog"> </div> Inparalog
            </div>
            <div class="edge-type">
              <input type="checkbox" value="Normal" /> 
              <div class="edge-legend Normal"> </div> Normal
            </div>
          </div>
          
          <div class="score-control control-section">
            E-Value cutoff: <b>1E<input type="text" class="evalue-exp" value="${layout.maxEvalueExp}"/></b> 
            <div class="evalue slider" 
                 data-min-exp="${layout.minEvalueExp}" data-max-exp="${layout.maxEvalueExp}"> </div>
            <div class="tip">Edges are colored by evalue; red represents high scores, blue for low scores.</div>
          </div>
          
        </fieldset>

        <fieldset class="node-control">
          <legend>Nodes</legend>
          <div>Display nodes by:
            <input name="node-display" class="node-display" type="radio" value="taxon" checked="checked" /> Taxons
            <c:set var="ecNumberDisabled"><c:if test="${(fn:length(group.ecNumbers) == 0}">disabled="disabled"</c:if></c:set>
            <input name="node-display" class="node-display" type="radio" value="ec-number" ${ecNumberDisabled} /> EC Numbers
            <c:set var="pfamDisabled">disabled="disabled"</c:set>
            <input name="node-display" class="node-display" type="radio" value="pfam" ${pfamDisabled} /> EC Numbers
          </div>

          <div class="taxon-control control-section">
            <div class="tip">Mouse over a taxon legend to highlight sequences of that taxon.</div>
            <c:forEach items="${layout.taxonCounts}" var="entity">
              <c:set var="taxon" value="${entity.key}" />
              <c:set var="taxonInfo" value="${taxon.name}" />
              <c:if test="${taxon.commonName != null}">
                <c:set var="taxonInfo" value="${taxonInfo} (${taxon.commonName})" />
              </c:if>
              <div class="taxon" id="${taxon.abbrev}" title="${taxonInfo}">
                <div class="taxon-legend" style="background:${taxon.color};border-color:${taxon.groupColor}"> </div>
                ${taxon.abbrev} (${entity.value})
              </div>
            </c:forEach>
          </div>
          
          <div class="ec-number-control control-section">
            <div class="tip">Mouse over a EC Number legend to highlight sequences of that ec number.</div>
            <c:forEach items="${group.ecNumbers}" var="item">
              <c:set var="ecNumber" value="${item.value}" />
              <div class="ec-number" id="${ecNumber.code}">
                <div class="ec-number-legend" style="background:${ecNumber.color};"> </div>
                ${ecNumber.code} (${ecNumber.count})
              </div>
            </c:forEach>
          </div>
         
        </fieldset>

      </div>

    </div> <!-- end of .controls div -->

    <!-- need an id here in order for .highlight selector to override the defaults -->
    <fieldset id="node-detail" class="node-detail">
      <legend>Sequence Detail</legend>
      <div class="non-content tip">Click a sequence node on the layout to see its details here.</div>

      <div class="content">
        <div class="source-id caption"></div>
        <div class="gene-info accordion">
          <h3>Sequence Information</h3>
          <div>
            <table>
              <tr>
                <th>Source ID:</th><td class="source-id"></td>
                <th>Length:</th><td class="length"></td>
              </tr>
              <tr>
                <th>Organism:</th><td class="taxon-name"></td>
                <th>Code:</th><td class="taxon-id"></td>
              </tr>
              <tr>
                <th>Description:</th><td class="description" colspan="3"></td>
              </tr>
            </table>
          </div>
        </div>

        <div class="edge-info accordion">
          <h3>BLAST Scores</h3>
          <div>
            <table class="blast-scores data-table">
              <thead>
                <th>Subject</th>
                <th>Type</th>
                <th>Evalue</th>
              </thead>
              <tbody>
              </tbody>
            </table>
            <div class="tip">Mouse over each row to highlight BLAST scores (edges).</div>
          </div>
        </div>

        <div class="pfam-info accordion">
          <h3>PFam Domains</h3>
          <div>
            Coming soon.
          </div>
        </div>

        <div class="ec-number-info accordion">
          <h3>ECNumbers</h3>
          <div>
            <table class="ec-numbers data-table">
              <thead>
                <th>EC Number</th>
              </thead>
              <tbody>
              </tbody>
            </table>
          </div>
        </div>

      </div> <!-- end of .content -->
    </fieldset> <!-- end of .node-detail -->


    <svg class="canvas" width="${layout.size}px" height="${layout.size}px" 
	     viewBox="0 0 ${layout.size} ${layout.size}">
      <rect class="background" x="0" y="0" width="${layout.size}" height="${layout.size}"/>

      <g class="edges">
        <c:forEach items="${layout.edges}" var="edge">
          <line id="e${edge.nodeA.index}-${edge.nodeB.index}" class="edge e${edge.nodeA.index}-${edge.nodeB.index}"
                x1="${edge.nodeA.x}" y1="${edge.nodeA.y}" 
                x2="${edge.nodeB.x}" y2="${edge.nodeB.y}" />
        </c:forEach>
      </g>
	
      <g class="nodes">
        <c:forEach items="${layout.nodes}" var="node">
          <c:set var="gene" value="${node.gene}" />
            <circle id="n${node.index}" class="node n${node.index} ${gene.taxon.abbrev}"
                    cx="${node.x}" cy="${node.y}" r="4" />
        </c:forEach>
      </g>

      <g class="ec-numbers">

      </g>

      <g class="pfams">

      </g>

      <g class="labels"></g>

    </svg>

  </div>

</jsp:root>
