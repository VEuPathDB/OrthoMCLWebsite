<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="imp" tagdir="/WEB-INF/tags/imp" %>
<%@ taglib prefix="imp" tagdir="/WEB-INF/tags/imp" %>

<c:set var="project" value="${applicationScope.wdkModel.displayName}" />

<script>
$(function() {
  $( "#sidebar" ).accordion({
    navigation: true,
  });
});
</script>


<div id="sidebar">
  <h3><a href="#data-summary">Data Summary</a></h3>
  <div>
    <ul>
   	    <li><a href="<c:url value='/getDataSummary.do?summary=data'/>"><span>Data Sources</span></a></li>
 	    <li><a href="<c:url value='/getDataSummary.do?summary=release'/>"><span>Release Summary</span></a></li>
     </ul>
  </div>

  <h3><a href="#news">News</a></h3>
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