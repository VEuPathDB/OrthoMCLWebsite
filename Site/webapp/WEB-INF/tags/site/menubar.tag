<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="site" tagdir="/WEB-INF/tags/site" %>
<%@ taglib prefix="wdk" tagdir="/WEB-INF/tags/wdk" %>

<%@ attribute name="refer" 
              type="java.lang.String"
              required="false" 
              description="Page calling this tag"
%>

<div id="menu">
  <ul class="menu">
    <%-- home page --%>
    <c:set var="current" value="${(refer == 'home') ? 'current' : ''}" />
    <li class="${current}"><a href="<c:url value='/' />" title='Return to OrthoMCL home page'><span>Home</span></a></li>

    <%-- search categories --%>
    <c:set var="current" value="${(refer == 'question') ? 'current' : ''}" />
    <li class="${current}"><a class="parent" title="Start a new search strategy."><span>New Search</span></a>
      <div><wdk:searchCategories /></div>
    </li>

    <%-- strategies --%>
    <c:set var="current" value="${(refer == 'summary') ? 'current' : ''}" />
    <li class="${current}"><a class="parent" href="<c:url value='/showApplication.do'/>" title="Access your Search Strategies Workspace"><span>My Strategies</span></a>
      <div><ul>
        <li><a href="<c:url value='/showApplication.do?tag=opened'/>" title="Show your currently open strategies"><span>Opened Strategies</span></a></li>
        <li><a href="<c:url value='/showApplication.do?tag=all'/>" title="Show all you strategies"><span>All Strategies</span></a></li>
      </ul></div>
    </li>

    <%-- strategies --%>
    <c:set var="current" value="${(refer == 'basket') ? 'current' : ''}" />
    <li class="${current}"><a href="<c:url value='/showApplication.doi?tab=basket'/>" title="Access your baskets"><span>My Baskets</span></a></li>

    <%-- tools --%>
    <c:set var="current" value="${(refer == 'tool') ? 'current' : ''}" />
    <li class="${current}"><a class="parent" title="Access online tools provided by OrthoMCL"><span>Tools</span></a>
      <div><ul>
        <li><a href="<c:url value='/blast'/>" title="Run BLAST against the proteins in OrthoMCL"><span>BLAST</span></a></li>
        <li><a href="<c:url value='/proteomeUpload'/>" title="Show all you strategies"><span>Analyze your Proteome data</span></a></li>
      </ul></div>
    </li>

    <%-- data source --%>
    <c:set var="current" value="${(refer == 'data-source') ? 'current' : ''}" />
    <li class="${current}"><a class="parent" title="Data summary"><span>Data Summary</span></a>
      <div><ul>
        <li><a href="<c:url value='/showSummary.do'/>" title="Organism summary"><span>Organism Summary</span></a></li>
        <li><a href="<c:url value='/showSummary.do'/>" title="Protein summary"><span>Protein Summary</span></a></li>
      </ul></div>
    </li>

    <%-- download --%>
    <c:set var="current" value="${(refer == 'data-source') ? 'current' : ''}" />
    <li class="${current}"><a class="parent" title="Downloads"><span>Downloads</span></a>
      <div><ul>
        <li><a href="<c:url value='/downloadData.do'/>" title="Download data for current build"><span>Download Data</span></a></li>
        <li><a href="<c:url value='/downloadTool.do'/>" title="Download the OrthoMCL software to run it by your own"><span>Download Software</span></a></li>
      </ul></div>
    </li>

    <%-- community --%>
    <c:set var="current" value="${(refer == 'community') ? 'current' : ''}" />
    <li class="${current}"><a class="parent" title="Community"><span>Data Summary</span></a>
      <div><ul>
        <li><a href="http://twitter.com" title="Follow us on Twitter"><span>Twitter</span></a></li>
        <li><a href="http://www.facebook.com" title="Follow us on Facebook"><span>Facebook</span></a></li>
      </ul></div>
    </li>
  </ul>
  <a href="http://apycom.com/" style="display:none">jQuery Menu by Apycom</a>
</div> <%-- end of menu DIV --%>
