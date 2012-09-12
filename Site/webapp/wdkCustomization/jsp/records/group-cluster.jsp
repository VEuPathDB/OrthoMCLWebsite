<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>
<%@ taglib prefix="pg" uri="http://jsptags.com/tags/navigation/pager" %>
<%@ taglib prefix="imp" tagdir="/WEB-INF/tags/imp" %>

<c:set value="${requestScope.wdkRecord}" var="wdkRecord"/>
<c:set var="groupName" value="${wdkRecord.attributes['group_name']}" />

<link rel="stylesheet" type="text/css" href="<c:url value='/wdkCustomization/css/svg.css' />">

<h2>Interactive Cluster Graph</h2>
<p>The following graph represents the clustering results of the proteins in 
   ortholog group ${groupName}. The interactive graph requires SVG support of
   your browser.</p>
<ul>
  <li>Each dot represent a protein, and different proteins from the same 
      organism share the same color. Mouse over the dot to view the detail 
      information about the protein.</li>
  <li>Each line between two dots represent a blast score (above a fixed 
      threshold of 1e-5) between two protein sequences. Mouse over to view the
      detail information about the blast score.</li>
  <li>Red line means the two proteins linked by the line form an ortholog pair.</li>
  <li>Green line means the two proteins form an in-paralog pair.</li>
  <li>Yellow line means the two proteins form an co-ortholog pair.</li>
  <li>Gray line means the two protein sequences have a blast score, but don't
      form ortholog, in-paralog, nor co-ortholog pairs.</li>
  <li>Click on the legend of each line type to toggle on/off that type of lines
      on the graph.</li>
</ul>

<embed src="http://jerric.orthomcl.org/orthomcl.jerric/getSvgContent.do?group=${groupName}"
       width="1000" height="700" type="image/svg+xml"></embed>


<hr />

<h2>Static Cluster Graph</h2>

<p>The following graph represents the clustering result of the proteins in 
   ortholog group #{groupName}.</p>
<ul>
  <li>Each dot represent a protein, and different proteins from the same 
      organism share the same color.</li>
  <li>Each line between two dots represent a blast score (above a fixed 
      threshold of 1e-5) between two protein sequences. The line color is
      weigthed by the blast score, and the better the score, the redder the
      color of the line, and the worse the score, the bluer the color. </li>
</ul>

<img src="<c:url value='/getBiolayout.do?group=${groupName}' />" />
