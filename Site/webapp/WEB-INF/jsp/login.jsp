<?xml version="1.0" encoding="UTF-8"?>
<jsp:root version="2.0"
    xmlns:jsp="http://java.sun.com/JSP/Page"
    xmlns:imp="urn:jsptagdir:/WEB-INF/tags/imp">
  <jsp:directive.page contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"/>
  <imp:pageFrame title="${wdkModel.displayName} :: Login" refer="login">
    <div class="user-form-frame">
      <table width="500" class="user-form-table">
        <tr>
          <th>Account Login</th>
        </tr>
		    <tr>
		      <td>
			      <b>Login</b> so you can:<br/>
			      <ul>
			        <li>Keep your strategies (unsaved and saved) from session to session</li>
			        <li>Comment on genes and sequences</li>
			        <li>Set site preferences</li>
			      </ul>
			    </td>
		    </tr>
		  </table>
		  <imp:loginForm showError="true" showCancel="false"/>
		</div>
  </imp:pageFrame>
</jsp:root>
