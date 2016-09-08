<?xml version="1.0" encoding="UTF-8"?>
<jsp:root version="2.0"
    xmlns:jsp="http://java.sun.com/JSP/Page"
    xmlns:c="http://java.sun.com/jsp/jstl/core"
    xmlns:imp="urn:jsptagdir:/WEB-INF/tags/imp">
  <jsp:directive.page contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"/>
  <c:set var="global" value="${wdkUser.globalPreferences}"/>
  <imp:pageFrame bufferContent="false" title="${wdkModel.displayName} :: Update User Profile" refer="profile">
    <div class="user-form-frame">  
      <!-- show error messages, if any -->
      <imp:errors/>
      
      <!-- display the success information, if the user registered successfully -->
      <c:if test="${requestScope.profileSucceed ne null}">
        <p><font color="blue">Your profile has been updated successfully.</font></p>
      </c:if>

      <form name="profileForm" method="post" action="processProfile.do">
        <table width="650" border="0" class="user-form-table">
          <tr>
            <th colspan="2"> User Profile </th>
          </tr>
          <c:choose>
            <c:when test="${wdkUser eq null or wdkUser.guest eq true}">
              <tr>
                <td colspan="2">Please login to view or update your profile.</td>
              </tr>
            </c:when>
            <c:otherwise>
              <!-- check if there is an error message to display -->
              <c:if test="${requestScope.profileError ne null}">
                <tr>
                  <td colspan="2">
                    <font color="red">${requestScope.profileError}</font>
                  </td>
                </tr>
              </c:if>
              <tr>
                <td colspan="2" align="center">
                   <a href="${pageContext.request.contextPath}/showPassword.do">
                     <img border="0" src="${pageContext.request.contextPath}/images/change_pwd.gif"/>
                   </a>
                </td>
              </tr>
              
              <tr>
                <td align="right" width="50%" nowrap="nowrap"><font color="red">*</font> Email: </td>
                <td align="left"><input type="email" required="true" name="email" value="${wdkUser.email}" size="20"/></td>
              </tr>
              <tr>
                <td align="right" width="50%" nowrap="nowrap"><font color="red">*</font> Re-type email: </td>
                <td align="left"><input type="email" required="true" name="confirmEmail" value="${wdkUser.email}" size="20"/></td>
              </tr>
              <tr>
                <td colspan="2" align="left"><hr/><b>User Information:</b></td>
              </tr>
              <tr>
                <td align="right" width="50%" nowrap="nowrap"><font color="red">*</font> First Name: </td>
                <td align="left"><input type="text" required="true" name="firstName" value="${wdkUser.firstName}" size="20"/></td>
              </tr>
              <tr>
                <td align="right" width="50%" nowrap="nowrap">Middle Name: </td>
                <td align="left"><input type="text" name="middleName" value="${wdkUser.middleName}" size="20"/></td>
              </tr>
              <tr>
                <td align="right" width="50%" nowrap="nowrap"><font color="red">*</font> Last Name:</td>
                <td align="left"><input type="text" required="true" name="lastName" value="${wdkUser.lastName}" size="20"/></td>
              </tr>
              <tr>
                <td align="right" width="50%" nowrap="nowrap"><font color="red">*</font> Institution:</td>
                <td align="left"><input type="text" required="true" name="organization" value="${wdkUser.organization}" size="50"/></td>
              </tr>
              <tr>
                <td colspan="2" align="left"><hr/><b>Preferences:</b></td>
              </tr>
              <tr>
                <td align="right">Items in the query result page:</td>
                <td>
                  <c:set var="selectedItemCount" value="${global['preference_global_items_per_page']}"/>
                  <c:set var="itemsPerPageList" value="5,10,20,50,100"/>
                  <select name="preference_global_items_per_page">
                    <c:forTokens items="${itemsPerPageList}" delims="," var="itemsPerPage">
                      <c:if test="${itemsPerPage eq selectedItemCount}">
                        <option value="${itemsPerPage}" selected="selected">${itemsPerPage}</option>
                      </c:if>
                      <c:if test="${itemsPerPage ne selectedItemCount}">
                        <option value="${itemsPerPage}">${itemsPerPage}</option>
                      </c:if>
                    </c:forTokens>
                  </select>
                </td>
              </tr>
              <tr>
                <td colspan="2" align="center">
                  <input type="image" src="${pageContext.request.contextPath}/images/update_profile.gif"/>
                </td>
              </tr>
            </c:otherwise>
          </c:choose>
        </table>
      </form>
    </div>
    <script>
      void function init() {
        var form = document.forms.profileForm;
        var email = form.email;
        var confirmEmail = form.confirmEmail;
        email.addEventListener('change', validateEmail);
        confirmEmail.addEventListener('change', validateEmail);

        function validateEmail() {
          if (email.value != confirmEmail.value) {
            confirmEmail.setCustomValidity('Email addresses do not match.');
          }
          else {
            confirmEmail.setCustomValidity('');
          }
        }
      }();
    </script>
  </imp:pageFrame>
</jsp:root>
