<%@ taglib prefix="imp" tagdir="/WEB-INF/tags/imp" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="html" uri="http://jakarta.apache.org/struts/tags-html" %>

<imp:header title="OrthoMCL" refer="home" />
<imp:sidebar />

  <div id="search-bubbles">
    <ul>

      <imp:searchCategories /> <%-- wdk: generates two <li>, one bubble per category --%>
      
      <li><a title="Tools">Tools</a>
        <ul>
          <li><a href="<c:url value='/showQuestion.do?questionFullName=SequenceQuestions.ByBlast'/>">BLAST</a></li>
          <li><a href="<c:url value='/proteomeUpload.do'/>">Assign proteins to groups</a></li>
        </ul>
      </li>
    </ul>
  </div>

<imp:footer/>
