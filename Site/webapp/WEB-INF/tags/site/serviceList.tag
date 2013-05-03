<?xml version="1.0" encoding="UTF-8"?>
<jsp:root version="2.0"
    xmlns:jsp="http://java.sun.com/JSP/Page"
    xmlns:c="http://java.sun.com/jsp/jstl/core"
    xmlns:html="http://jakarta.apache.org/struts/tags-html"
    xmlns:imp="urn:jsptagdir:/WEB-INF/tags/imp">

  <!-- serviceList.jsp -->

  <!-- get wdkModel saved in application scope -->
  <c:set var="wdkModel" value="${applicationScope.wdkModel}"/>

  <!-- url base (in leiu of `c:url') -->
  <c:set var="urlBase" value="${pageContext.request.contextPath}"/>

  <!-- get wdkModel name to display as page header -->
  <c:set value="${wdkModel.displayName}" var="wdkModelDispName"/>
  <imp:pageFrame title="${wdkModelDispName}" bufferContent="true">

    <c:set var="margin" value="15px"/>

    <!-- display wdkModel introduction text -->
    <h1>Searches via Web Services</h1>
    <br/>
    ${wdkModelDispName} provides programmatic access to
    <a href="${urlBase}/queries_tools.jsp">its searches</a>,
    via <a href="http://www.ics.uci.edu/~fielding/pubs/dissertation/top.htm">
      <b>REST</b></a> Web Services. 
    The result of a web service request is a list of records (genes, ESTs, etc)
    in either <a href="http://www.w3.org/XML/">XML</a> or
    <a href="http://json.org/">JSON</a> format. 
    REST services can be executed in a browser by typing a specific URL. 

    <br/>
    <br/>

    For example, this URL: <br/>
    <span style="position:relative;left:${margin};font-size:110%">
      <a href="${baseUrl}/webservices/GroupQuestions/BySequenceCount.xml?sequence_count_min=100&amp;sequence_count_max=102&amp;o-fields=group_name,ec_numbers">
        http://${wdkModelDispName}.org/webservices/GroupQuestions/BySequenceCount.xml?
        <br/>sequence_count_min=100&amp;
        <br/>sequence_count_max=102&amp;
        <br/>o-fields=group_name,ec_numbers</a>
    </span>

    <br/>
    <br/>
    Corresponds to this request: 
    <br/>
    <span style="font-style:italic;font-weight:bold;position:relative;left:${margin};">
      Find all groups that have a sequence count between 100 and 102. 
      <br/>For each group ID in the result, return its group name and EC numbers.
      <br/>Provide the result in an XML document.
    </span>

    <br/>
    <br/>
    <br/>

    <hr/>

    <h2>WADLs: how to generate web service URLs</h2>
    Click on a search below to access its <a href="http://www.w3.org/Submission/wadl/">WADL</a>
    (Web Application Description Language). 

    <br/>

    <span style="position:relative;left:${margin};">
      <ul class="cirbulletlist">
        <li>A WADL is an XML document that describes in detail how to form a URL
          to call the search as a web service request. For more details go to
          <a style="font-size:120%;font-weight:bold" href="#moreWADL">How to read a WADL</a>
          at the bottom of this page.
        </li>
        <li>Note: some browsers (e.g.: Safari) do not know how to render an XML
          file properly (you will see a page full of terms with no structure).
        </li>
        <li>To construct the URL in the example above, you would check the
          <a href="/webservices/GroupQuestions/BySequenceCount.wadl">Number of Sequences</a>
          WADL located below under <b>Group Statistics</b>
        </li>
      </ul>
    </span>

    <br/>

    <c:if test="${wdkModelDispName eq 'EuPathDB'}">
      <i>(Note: The parameter "o-tables" is not available from EuPathDB.)</i>
    </c:if>

    <!-- show all questionSets in model, driven by categories as in menubar -->
    <ul id="webservices-list">
      <imp:searchCategoriesAll from="webservices" />
    </ul>

    <br/>
    <hr/>
    <br/>

    <a name="moreWADL"><jsp:text/></a>
    <h2>How to read a WADL</h2>

    <ul>
      <li>(1) What is the name and purpose of the search.
        <span style="position:relative;left:${margin};">
          <br/>Under <span style="font-style:italic;font-weight:bold">&amp;lt;method name=....&amp;gt;</span>
          <br/>In our example: <span style="font-style:italic;font-weight:bold">
            &amp;lt;doc title="description"&amp;gt;Find groups whose .....
            Sequence counts are ......&amp;lt;/doc&amp;gt;</span>
        </span>
        <br/>
      </li>

      <li>(2) What is the service URL. 
        <span style="position:relative;left:${margin};">
          <br/>Under <span style="font-style:italic;font-weight:bold">&amp;lt;resource path=....&amp;gt;</span>. 
          <br/>It includes an extension that indicates the format requested for the result (XML or JSON).
          <br/>In our example: <span style="font-style:italic;color: blue">
            http://${wdkModelDispName}.org/webservices/GroupQuestions/BySequenceCount.xml</span>
        </span>
        <br/>
      </li>

      <li>(3) How to constrain your search.
        <span style="position:relative;left:${margin};">
          <br/>Under <span style="font-style:italic;font-weight:bold"> &amp;lt;param name=.....&amp;gt;</span>. 
          <br/>If a default value is provided under &amp;lt;doc title="default"&amp;gt;.....&amp;lt;/doc&amp;gt;,
          then providing the parameter is optional.
          <br/>In our example: <span style="font-style:italic;color: blue">
            sequence_count_min=100, sequence_count_max=102</span>.
        </span>
        <br/>
      </li>

      <li>(4) What to return for each ID in the result.
        <span style="position:relative;left:${margin};">
          <br/>Under <span style="font-style:italic;font-weight:bold"> &amp;lt;param name=.....&amp;gt;</span> too.
          <br/>These are the same for all searches of a given record type
          (e.g., for all group searches). Output-fields are single-valued
          attributes while output-tables are multi-valued (array).
          <br/>In our example: <span style="font-style:italic;color: blue">
            o-fields=group_name,ec_numbers&amp;o-tables=EcNumber</span>
        </span>
      </li>
    </ul>
  </imp:pageFrame>
</jsp:root>
