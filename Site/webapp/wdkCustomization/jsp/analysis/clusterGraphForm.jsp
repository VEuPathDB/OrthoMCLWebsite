<?xml version="1.0" encoding="UTF-8"?>
<jsp:root version="2.0"
    xmlns:jsp="http://java.sun.com/JSP/Page"
    xmlns:c="http://java.sun.com/jsp/jstl/core"
    xmlns:fn="http://java.sun.com/jsp/jstl/functions">
  <jsp:directive.page contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"/>
  <html>
    <body>
      <div class="ui-helper-clearfix">
        <div style="text-align:center">
          <c:choose>
            <c:when test="${viewModel.hasLayout}">
              <form>
                <div>
                  Depending on the size of the results and the server load, 
                  it might take up to 6 minutes to analyze the sequence cluster. 
                  Please wait.
                </div>
                <div style="text-align:center">
                  <input type="submit" value="Submit"/>
                </div>
              </form>
            </c:when>
            <c:otherwise>
              <div class="tip">
                Cluster graph is only available for sequence search results 
                with no more than ${viewModel.maxSize} sequences.
              </div>
            </c:otherwise>
          </c:choose>
        </div>
      </div>
    </body>
  </html>
</jsp:root>
