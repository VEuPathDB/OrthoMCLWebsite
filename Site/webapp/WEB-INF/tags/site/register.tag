<?xml version="1.0" encoding="UTF-8"?>
<jsp:root version="2.0"
    xmlns:jsp="http://java.sun.com/JSP/Page"
    xmlns:c="http://java.sun.com/jsp/jstl/core"
    xmlns:imp="urn:jsptagdir:/WEB-INF/tags/imp">

  <style type="text/css">
    .blockUI {   min-width: 750px; }

    p#regConf {
      font-weight: bold;
      font-size: 120%;
      color: green;
      margin: 10px 0 30px;
    }
  </style>

  <div class="user-form-frame">

		  <!-- display the success information if the user registered successfully -->
		  <c:choose>
		    <c:when test="${requestScope.registerSucceed ne null}">
		      <h1>You have registered successfully.</h1>
		      <p id="regConf">We have sent you an email with a temporary password.<br></br>
		         Please log in within the next week (to avoid having this registration purged).
          </p>
		    </c:when>
		    <c:otherwise>

	        <br/>
          <!-- registration form -->
  
        <form name="registerForm" method="post" action="processRegister.do" >
					<div style="text-align:center">
						<b>IMPORTANT:</b> If you already registered in another site<br/>
						(AmoebaDB, EuPathDB, CryptoDB ,GiardiaDB, MicrosporidiaDB, OrthoMCL, PiroplasmaDB, PlasmoDB, ToxoDB, TrichDB or TriTrypDB)<br/>
						you do NOT need to register again.
					</div><br/>
		      <table width="650" class="user-form-table">
		          <c:choose>
		            <c:when test="${wdkUser ne null and wdkUser.guest ne true}">
		              <tr>
		                <td colspan="2">
		                  <p>You are logged in.</p>
		                  <p>To change your password or profile go <a href="${pageContext.request.contextPath}/showProfile.do">here</a>.</p>
		                </td>
		              </tr>
		            </c:when>
		            <c:otherwise>
		              <!-- check if there's an error message to display -->
							    <c:if test="${requestScope.registerError ne null}">
							      <tr>
							        <td colspan="2">
							          <font color="red">${requestScope.registerError}</font>
							        </td>
							      </tr>
							    </c:if>
							    <tr>
							      <td align="right" width="50%" nowrap="nowrap"><font color="red">*</font> Email: </td>
							      <td align="left"><input type="text" name="email" value="${requestScope.email}" size="20"/></td>
							    </tr>
							    <tr>
							      <td align="right" width="50%" nowrap="nowrap"><font color="red">*</font> Confirm Email: </td>
							      <td align="left"><input type="text" name="confirmEmail" value="${requestScope.email}" size="20"/></td>
							    </tr>
							    <tr>
							      <td align="right" width="50%" nowrap="nowrap"><font color="red">*</font> First Name: </td>
							      <td align="left"><input type="text" name="firstName" value="${requestScope.firstName}" size="20"/></td>
							    </tr>
							    <tr>
							      <td align="right" width="50%" nowrap="nowrap">Middle Name: </td>
							      <td align="left"><input type="text" name="middleName" value="${requestScope.middleName}" size="20"/></td>
							    </tr>
							    <tr>
							      <td align="right" width="50%" nowrap="nowrap"><font color="red">*</font> Last Name: </td>
							      <td align="left"><input type="text" name="lastName" value="${requestScope.lastName}" size="20"/></td>
							    </tr>
							    <tr>
							      <td align="right" width="50%" nowrap="nowrap"><font color="red">*</font> Institution: </td>
							      <td align="left"><input type="text" name="organization" value="${requestScope.organization}" size="50"/></td>
							    </tr>
							    <tr>
							     
							    </tr>
							  </c:otherwise>
		          </c:choose>
		        </table>


				<div style="text-align:center">
          Send me email alerts about: 
					<br/>

        <c:choose>
           <c:when test="${requestScope.preference_global_email_amoebadb != null}">
              <input type="checkbox" name="preference_global_email_amoebadb" checked="yes"> AmoebaDB </input>
           </c:when>
           <c:otherwise>
              <input type="checkbox" name="preference_global_email_amoebadb"> AmoebaDB </input>
           </c:otherwise>
        </c:choose>
        <c:choose>
           <c:when test="${requestScope.preference_global_email_apidb != null}">
              <input type="checkbox" name="preference_global_email_apidb" checked="yes"> EuPathDB </input>
           </c:when>
           <c:otherwise>
              <input type="checkbox" name="preference_global_email_apidb"> EuPathDB </input>
           </c:otherwise>
        </c:choose>
        <c:choose>
           <c:when test="${requestScope.preference_global_email_cryptodb != null}">
              <input type="checkbox" name="preference_global_email_cryptodb" checked="yes"> CryptoDB </input>
           </c:when>
           <c:otherwise>
              <input type="checkbox" name="preference_global_email_cryptodb"> CryptoDB </input>
           </c:otherwise>
        </c:choose>
        <c:choose>
           <c:when test="${requestScope.preference_global_email_giardiadb != null}">
              <input type="checkbox" name="preference_global_email_giardiadb" checked="yes"> GiardiaDB </input>
           </c:when>
           <c:otherwise>
              <input type="checkbox" name="preference_global_email_giardiadb"> GiardiaDB </input>
           </c:otherwise>
        </c:choose>
        <c:choose>
           <c:when test="${requestScope.preference_global_email_microsporidiadb != null}">
              <input type="checkbox" name="preference_global_email_microsporidiadb" checked="yes"> MicrosporidiaDB </input>
           </c:when>
           <c:otherwise>
              <input type="checkbox" name="preference_global_email_microsporidiadb"> MicrosporidiaDB </input>
           </c:otherwise>
				</c:choose>
				<c:choose>
					 <c:when test="${requestScope.preference_global_email_piroplasmadb != null}">
              <input type="checkbox" name="preference_global_email_ortho" checked="yes"> OrthoMCL </input>
           </c:when>
           <c:otherwise>
              <input type="checkbox" name="preference_global_email_ortho"> OrthoMCL </input>
           </c:otherwise>
        </c:choose>
				<c:choose>
					 <c:when test="${requestScope.preference_global_email_piroplasmadb != null}">
              <input type="checkbox" name="preference_global_email_piroplasmadb" checked="yes"> PiroplasmaDB </input>
           </c:when>
           <c:otherwise>
              <input type="checkbox" name="preference_global_email_piroplasmadb"> PiroplasmaDB </input>
           </c:otherwise>
        </c:choose>
        <c:choose>
           <c:when test="${requestScope.preference_global_email_plasmodb != null}">
              <input type="checkbox" name="preference_global_email_plasmodb" checked="yes"> PlasmoDB </input>
           </c:when>
           <c:otherwise>
              <input type="checkbox" name="preference_global_email_plasmodb"> PlasmoDB </input>
           </c:otherwise>
        </c:choose>
        <c:choose>
           <c:when test="${requestScope.preference_global_email_toxodb != null}">
              <input type="checkbox" name="preference_global_email_toxodb" checked="yes"> ToxoDB </input>
           </c:when>
           <c:otherwise>
              <input type="checkbox" name="preference_global_email_toxodb"> ToxoDB </input>
           </c:otherwise>
        </c:choose>
        <c:choose>
           <c:when test="${requestScope.preference_global_email_trichdb != null}">
              <input type="checkbox" name="preference_global_email_trichdb" checked="yes"> TrichDB </input>
           </c:when>
           <c:otherwise>
              <input type="checkbox" name="preference_global_email_trichdb"> TrichDB </input>
           </c:otherwise>
        </c:choose>
        <c:choose>
           <c:when test="${requestScope.preference_global_email_tritrypdb != null}">
              <input type="checkbox" name="preference_global_email_tritrypdb" checked="yes"> TriTrypDB </input>
           </c:when>
           <c:otherwise>
              <input type="checkbox" name="preference_global_email_tritrypdb"> TriTrypDB </input>
           </c:otherwise>
        </c:choose>

					<br/><br/><input type="submit" name="registerButton" value="Register"   onclick="return validateFields();"/>

				</div>
		      </form>

				<br/>
				<div style="width:550px;border:1px  solid black;padding:5px;line-height:1.5em;margin-right:auto;margin-left:auto;">
						<p><b>Why register/subscribe?</b> So you can:</p>
						<div id="cirbulletlist">
							<ul>
								<li>Have your strategies back the next time you login</li>
								<li>Use your basket to store temporarily IDs of interest, and either save (in a step) or download the IDs</li>
								<li>Use your favorites to store IDs of permanent interest, for faster access to its record page</li>
								<li>Add a comment on genes and sequences</li>
								<li>Set site preferences, such as items per page displayed in the query result</li>
								<li>Opt to receive infrequent alerts (at most monthly), by selecting (above) from which EuPathDB sites</li>
							</ul>
						</div>
				</div>

		    </c:otherwise>
		  </c:choose>

		  <br/>

			<div style="width:550px;border:1px solid black;padding:5px;line-height:1.5em;margin-right:auto;margin-left:auto;">
				<div style="font-size:1.2em;">
					<b>EuPathDB Websites Privacy Policy</b> 
				</div>

				<table><tr>
						<td width="40%">
							<p><b>How we will use your email:</b> </p>
							<div id="cirbulletlist">
								<ul>
									<li>Confirm your subscription</li>
									<li>Send you infrequent alerts if you subscribe to receive them</li>
									<li>NOTHING ELSE.  We will not release the email list.</li>
								</ul>
							</div>
						</td>
						
						<td>
							<p><b>How we will use your name and institution:</b></p>
							<div id="cirbulletlist">
								<ul>
									<li>If you add a comment to a Gene or a Sequence, your name and institution will be displayed with the comment</li>
									<li>NOTHING ELSE.  We will not release your name or institution. </li> 
								</ul>
							</div>
						</td>
						
				</tr></table>
			</div> 

		</div> <!-- div align center -->


    <![CDATA[
      <script>
        (function($) {
          // spam prevention for register form
          wdk.util.addSpamTimestamp(document.registerForm);

          // enable submit button if form is rereshed after a submit
          // some browsers will cache the form state
          document.registerForm.registerButton.disabled = false;

          $(document.registerForm).submit(validateFields);

          function validateFields(e) {
              var email = document.registerForm.email.value;
              var pat = email.indexOf('@');
              var pdot = email.lastIndexOf('.');
              var len = email.length;

              if (email == '') {
                  alert('Please provide your email address.');
                  document.registerForm.email.focus();
                  return false;
              } else if (pat<=0 || pdot<pat || pat==len-1 || pdot==len-1) {
                  alert('The format of the email is invalid.');
                  document.registerForm.email.focus();
                  return false;
              } else if (email != document.registerForm.confirmEmail.value) {
                  alert('The emails do not match. Please enter it again.');
                  document.registerForm.email.focus();
                  return false;
              } else if (document.registerForm.firstName.value == "") {
                  alert('Please provide your first name.');
                  document.registerForm.firstName.focus();
                  return false;
              } else if (document.registerForm.lastName.value == "") {
                  alert('Please provide your last name.');
                  document.registerForm.lastName.focus();
                  return false;
              } else if (document.registerForm.organization.value == "") {
                  alert('Please provide the name of the organization you belong to.');
                  document.registerForm.organization.focus();
                  return false;
              } else {
                  document.registerForm.registerButton.disabled = true;
                  document.registerForm.submit();
                  return true;
              }
          }
        }(jQuery));
      </script>
    ]]>

</jsp:root>
