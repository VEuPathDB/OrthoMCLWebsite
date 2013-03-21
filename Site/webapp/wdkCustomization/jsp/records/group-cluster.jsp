<?xml version="1.0" encoding="UTF-8"?>
<jsp:root version="2.0"
    xmlns:jsp="http://java.sun.com/JSP/Page"
    xmlns:c="http://java.sun.com/jsp/jstl/core"
    xmlns:imp="urn:jsptagdir:/WEB-INF/tags/imp">
  <jsp:directive.page contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"/>

  <c:set value="${requestScope.wdkRecord}" var="wdkRecord"/>
  <c:set var="groupName" value="${wdkRecord.attributes['group_name'].value}"/>
  <c:set var="memberCount" value="${wdkRecord.attributes['number_of_members'].value}"/>

  <link rel="stylesheet" type="text/css" href="${pageContext.request.contextPath}/wdkCustomization/css/svg.css"/>

  <h2>Interactive Cluster Graph</h2>

<c:choose>
  <c:when test="${memberCount > 500}">
    <p class="warning">The cluster graph is not available for this Ortholog group ${groupName}. 
       The graph is available for groups with 500 sequences or less only.</p>
  </c:when>

  <c:otherwise>
  <p>
    The following graph represents the clustering results of the proteins in 
    ortholog group ${groupName}. The interactive graph requires SVG support of
    your browser.
  </p>

  <br/>

  <ul>
    <li>
      Each dot represent a protein, and different proteins from the same 
      organism share the same color. Mouse over the dot to view the detail 
      information about the protein.
    </li>
    <li>
      Each line between two dots represent a blast score (above a fixed 
      threshold of 1e-5) between two protein sequences. Mouse over to view the
      detail information about the blast score.
    </li>
    <li>
      Red line means the two proteins linked by the line form an ortholog pair.
    </li>
    <li>
      Green line means the two proteins form an in-paralog pair.
    </li>
    <li>
      Yellow line means the two proteins form an co-ortholog pair.
    </li>
    <li>
      Gray line means the two protein sequences have a blast score, but don't
      form ortholog, in-paralog, nor co-ortholog pairs.
    </li>
    <li>
      Click on the legend of each line type to toggle on/off that type of lines
      on the graph.
    </li>
  </ul>

  <embed src="${pageContext.request.contextPath}/getSvgContent.do?group=${groupName}" width="1000" height="700" type="image/svg+xml"></embed>

  <hr/>

  <h2>Static Cluster Graph</h2>

  <p>
    The following graph represents the clustering result of the proteins in 
    ortholog group ${groupName}.
  </p>

  <br/>

  <ul>
    <li>
      Each dot represent a protein, and different proteins from the same 
      organism share the same color.
    </li>
    <li>
      Each line between two dots represent a blast score (above a fixed 
      threshold of 1e-5) between two protein sequences. The line color is
      weigthed by the blast score, and the better the score, the redder the
      color of the line, and the worse the score, the bluer the color.
    </li>
  </ul>

  <img src="${pageContext.request.contextPath}/getBiolayout.do?group=${groupName}"/>

  </c:otherwise>
</c:choose>

</jsp:root>
