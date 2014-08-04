<?xml version="1.0" encoding="UTF-8"?>
<jsp:root version="2.0"
    xmlns:jsp="http://java.sun.com/JSP/Page"
    xmlns:c="http://java.sun.com/jsp/jstl/core"
    xmlns:fn="http://java.sun.com/jsp/jstl/functions"
    xmlns:imp="urn:jsptagdir:/WEB-INF/tags/imp"
	  xmlns:svg="http://www.w3.org/2000/svg">
  <jsp:directive.page contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"/>

  <c:set var="layout" value="${requestScope.layout}" />

<c:choose>
  <c:when test="${layout == null}">
    <div class="tip">Cluster graph is only available for groups with no more than 500 sequences.</div>
  </c:when>
  <c:otherwise> <!-- show layout -->

  <c:set var="group" value="${layout.group}" />
  <c:set var="taxons" value="${layout.taxons}" />
  <c:set var="ecNumbers" value="${group.ecNumbers}" />
  <c:set var="pfams" value="${group.PFamDomains}" />

  <div class="group-layout" data-controller="orthomcl.group.layout.init">

    <div class="data">

      <div class="taxons">
        <c:forEach items="${taxons}" var="taxon">
          <span class="taxon" id="${taxon.abbrev}" 
                data-color="${taxon.color}" data-group-color="${taxon.groupColor}"
                data-common-name="${taxon.commonName}" data-species="${taxon.species}"
                data-parent="${taxon.parent.abbrev}" data-sort-index="${taxon.sortIndex}"
                data-path="${taxon.path}" >
            ${taxon.name}
          </span>
        </c:forEach>
      </div>

      <div class="nodes">
        <c:forEach items="${layout.nodes}" var="node">
          <c:set var="gene" value="${node.gene}" />
          <div class="node" id="${node.index}" data-source-id="${gene.sourceId}" 
                data-taxon="${gene.taxon.abbrev}" data-length="${gene.length}" data-x="${node.x}" data-y="${node.y}">
            <span class="description">${gene.description}</span>
            <c:forEach items="${gene.ecNumbers}" var="code">
              <span class="ec-number" id="${ecNumbers[code].index}" />
            </c:forEach>
            <c:forEach items="${gene.PFamDomains}" var="item">
              <c:set var="accession" value="${item.key}" />
              <c:set var="location" value="${item.value}" />
              <span class="pfam" id="${pfams[accession].index}" 
                    data-start="${location[0]}" data-end="${location[1]}" data-length="${location[2]}" />
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
        <c:forEach items="${ecNumbers}" var="item">
          <c:set var="ecNumber" value="${item.value}" />
          <span class="ec-number" id="${ecNumber.index}" data-code="${ecNumber.code}" 
                data-color="${ecNumber.color}" data-count="${ecNumber.count}" />
        </c:forEach>
      </div>
      
      <div class="pfams">
        <c:forEach items="${pfams}" var="item">
          <c:set var="pfam" value="${item.value}" />
          <span class="pfam" id="${pfam.index}" data-accession="${pfam.accession}" 
                data-symbol="${pfam.symbol}"  data-color="${pfam.color}" data-count="${pfam.count}">
            ${pfam.description}
          </span>
        </c:forEach>
      </div>

    </div>


    <div class="notes accordion">
     <h3>Notes</h3>
     <div>
      <p>The above graph represents the clustering results of the proteins in ortholog group ${group.name}. The interactive graph re
quires SVG support of your browser.</p>

      <ul>
        <li>Each dot represent a protein, and different proteins from the same organism share the same color. Mouse over the dot to
view the detail information about the protein.</li>
        <li>Each line between two dots represent a blast score (above a fixed threshold of 1e-5) between two protein sequences. Mous
e over to view the detail information about the blast score.</li>
        <li>Red line means the two proteins linked by the line form an ortholog pair.</li>
        <li>Green line means the two proteins form an in-paralog pair.</li>
        <li>Blue line means the two proteins form an co-ortholog pair.</li>
        <li>Gray line means the two protein sequences have a blast score, but don't form ortholog, in-paralog, nor co-ortholog pairs
.</li>
        <li>Click on the legend of each line type to toggle on/off that type of lines on the graph.</li>
      </ul>
     </div>
    </div>


    <div class="controls">

      <div class="edge-control accordion">
        <h3>Edge Options</h3>
        <div>
           
          <fieldset class="type-control control-section">
            <legend>Edge Type</legend>
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
              <div class="edge-legend Normal"> </div> Other Similarities
            </div>
          </fieldset>
          
          <fieldset class="score-control control-section">
            <legend>E-Value Cutoff</legend>
            <div>
              Max E-Value:  
              <b> 1E<input type="text" class="evalue-exp" value="${layout.maxEvalueExp}"/></b>
            </div>
            <div class="evalue slider" 
                 data-min-exp="${layout.minEvalueExp}" data-max-exp="${layout.maxEvalueExp}"> </div>
          </fieldset>
        </div>
      </div>

      <div class="node-control accordion">
        <h3>Node Options</h3>
        <div>
          <fieldset class="control-section">
            <legend>Show Nodes By</legend>

            <input name="node-display" class="node-display" type="radio" value="taxon" checked="checked" />
             Taxa
            <c:choose>
              <c:when test="${fn:length(ecNumbers) == 0}">
                <input name="node-display" class="node-display" type="radio" value="ec-number" disabled="disabled" />
              </c:when>
              <c:otherwise>
                <input name="node-display" class="node-display" type="radio" value="ec-number" /> 
              </c:otherwise>
            </c:choose> 
            EC Numbers
            <c:choose>
              <c:when test="${fn:length(pfams) == 0}">
                <input name="node-display" class="node-display" type="radio" value="pfam" disabled="disabled" />
              </c:when>
              <c:otherwise>
                <input name="node-display" class="node-display" type="radio" value="pfam" /> 
              </c:otherwise>
            </c:choose> 
            PFam Domains
          </fieldset>

          <div class="taxon-control control-section">
            <div class="tip">Mouse over a taxon legend to highlight sequences of that taxon.</div>
            <c:forEach items="${layout.taxonCounts}" var="entity">
              <c:set var="taxon" value="${entity.key}" />
              <div class="taxon taxon-id" id="${taxon.abbrev}">
                <div class="taxon-legend" style="background:${taxon.color};border-color:${taxon.groupColor}"> </div>
                ${taxon.abbrev} (${entity.value})
              </div>
            </c:forEach>
          </div>
          
          <div class="ec-number-control control-section">
            <div class="tip">The EC Numbers are rendered in a pie chart for each gene.</div>
            <c:forEach items="${ecNumbers}" var="item">
              <c:set var="ecNumber" value="${item.value}" />
              <div class="ec-number" id="${ecNumber.index}">
                <div class="ec-number-legend" style="background:${ecNumber.color};"> </div>
                ${ecNumber.code} (${ecNumber.count})
              </div>
            </c:forEach>
          </div>
          
          <div class="pfam-control control-section">
            <div class="tip">The PFam Domains are rendered in a pie chart for each gene.</div>
            <c:forEach items="${pfams}" var="item">
              <c:set var="pfam" value="${item.value}" />
              <div class="pfam" id="${pfam.index}" title="${pfam.description}">
                <div class="pfam-legend" style="background:${pfam.color};"> </div>
                ${pfam.accession} (${pfam.count})
              </div>
            </c:forEach>
          </div>
        </div>
      </div>

    </div> <!-- end of .controls div -->
    

    <svg class="canvas" width="${layout.size}px" height="${layout.size}px" 
             viewBox="0 0 ${layout.size} ${layout.size}">

      <rect class="background" x="0" y="0" width="${layout.size}" height="${layout.size}"/>

      <g class="edges">
        <c:forEach items="${layout.edges}" var="edge">
          <line id="e${edge.nodeA.index}-${edge.nodeB.index}" 
                class="edge e${edge.nodeA.index}-${edge.nodeB.index} ${edge.type}"
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

      <g class="ec-numbers"></g>

      <g class="pfams"></g>

      <g class="labels"></g>

    </svg>

    
    <!-- need an id here in order for .highlight selector to override the defaults -->
    <div class="nodes-info tabs">
      <ul>
        <li><a href="#node-list">Sequence List</a></li>
        <li><a href="#node-detail">Node Detail</a></li>
      </ul>

      <div id="node-list" class="node-list">
        <table class="data-table">
          <thead>
            <tr>
              <th>Accession</th>
              <th>Taxon</th>
              <th>Length</th>
              <th>Description</th>
            </tr>
          </thead>
          <tbody>
            <c:forEach items="${layout.nodes}" var="node">
              <c:set var="gene" value="${node.gene}" />
              <tr class="node" data-index="${node.index}">
                <td>
                  <c:url var="geneUrl" 
                         value="/showRecord.do?name=SequenceRecordClasses.SequenceRecordClass&amp;full_id=${gene.sourceId}" />
                  <a href="${geneUrl}">${gene.sourceId}</a>
                </td>
                <c:set var="taxon" value="${gene.taxon}" />
                <td class="taxon-id" id="${taxon.abbrev}">${taxon.abbrev}</td>
                <td>${gene.length}</td>
                <td>${gene.description}</td>
              </tr>
            </c:forEach>
          </tbody>
        </table>
      </div>

      <div id="node-detail" class="node-detail">
        <div class="source-id caption empty">Click a node to see details.</div>
        <div class="gene-info info-section accordion">
          <h3>Sequence Information</h3>
          <div>
            <table>
              <tr>
                <c:url var="geneUrlTemplate" 
                       value="/showRecord.do?name=SequenceRecordClasses.SequenceRecordClass&amp;full_id=" />
                <th>Source ID:</th><td class="source-id" data-url="${geneUrlTemplate}"></td>
                <th>Length:</th><td class="length"></td>
              </tr>
              <tr>
                <th>Organism:</th><td class="taxon-name"></td>
                <th>Taxon:</th><td class="taxon-id"></td>
              </tr>
              <tr>
                <th>Description:</th><td class="description" colspan="3"></td>
              </tr>
            </table>
          </div>
        </div>

        <div class="edge-info info-section accordion">
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

        <div class="pfam-info info-section accordion">
          <h3>PFam Domains</h3>
          <div>
            <table class="pfams data-table">
              <thead>
                <th>Accession</th>
                <th>Symbol</th>
                <th>Start</th>
                <th>End</th>
                <th>Length</th>
              </thead>
              <tbody>
              </tbody>
            </table>
          </div>
        </div>

        <div class="ec-number-info info-section accordion">
          <h3>EC Numbers</h3>
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

      </div> <!-- end of .node-detail -->
  
    </div> <!-- end of tabs -->

  </div>

  </c:otherwise> <!-- End of show layout -->
</c:choose>
  
</jsp:root>
