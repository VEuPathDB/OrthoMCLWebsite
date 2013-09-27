<?xml version="1.0" encoding="UTF-8"?>
<jsp:root version="2.0"
    xmlns:jsp="http://java.sun.com/JSP/Page"
    xmlns:c="http://java.sun.com/jsp/jstl/core"
    xmlns:imp="urn:jsptagdir:/WEB-INF/tags/imp">
  <jsp:directive.page contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"/>

  <imp:pageFrame refer="proteome" title="Upload your own Proteome" bufferContent="true">
    <div class="prot-upload">
      <c:choose>
        <c:when test="${requestScope.isServiceAvailable}">
  
          <script type="text/javascript" src="${pageContext.request.contextPath}/wdk/js/lib/jquery.form.js"><jsp:text /></script>
          <script type="text/javascript" src="${pageContext.request.contextPath}/wdkCustomization/js/proteome.js"><jsp:text /></script>
      
          <!-- BEGIN CONTENT -->
      
          <div id="proteome-result" style="display:none;"><jsp:text/></div>
      
          <h2 align="center">Assign your proteins to OrthoMCL Groups</h2>
          <p>
            Use this tool to provisionally assign the proteins in a genome to
            OrthoMCL Groups.  Upload your genome's proteins as a FASTA file.
          </p>
          <p>
            The process usually takes between 6 to 24 hours, but up to 72, depending upon server load and job size.
            You will receive mail when your results are ready, and can retrieve them for up to 48 hours from then.
          </p>
	  <p><b>Please Note:</b> This service has occasional delays and/or down time. We appreciate your patience when this happens.  The service is computationally expensive and runs on an external compute cluster which sometimes has wait times or disruptions that are out of our control.  If you have not gotten results after 72 hours please feel free to contact us.
	    </p>

          <div id="upload-form">
            <form id="proteome" action="/cgi-bin/orthomclProteomeSvcUpload.cgi" method="post" enctype="multipart/form-data">
              <input type="hidden" name="result_url_base" value="${requestScope.resultBaseUrl}"/>
              <table>
                <tr>
                  <td>Sequence file to Upload: </td>
                  <td><input id="seq_file" type="file" name="seq_file" required="true"/></td>
                </tr>
                <tr>
                  <td>Your Email Address: </td>
                  <td><input id="email" type="text" name="email" required="true" size="33" maxlength="255"/></td>
                </tr>
                <tr>
                  <td>Job Name(optional): </td>
                  <td><input id="job_name" type="text" name="job_name" size="33" maxlength="100"/></td>
                </tr>
                <tr>
                  <td colspan="2" align="center"><input type="submit" name="Submit" value="Upload"/></td>
                </tr>
              </table>
            </form>
          </div>
          <br/>
          <h3>Details</h3>
          <p>
            <strong>Input:</strong> Your proteins in FASTA format.
          </p>
          <p>
            <strong>Output:</strong> A .zip file containing the following text files:
          </p>

<div class="indent3"><pre>
orthomclResults/
  orthologGroups    # a map between your proteins and OrthoMCL groups. Tab 
                      delimited.  Columns: your_protein, orthomcl_group, 
                      seq_id_of_best_hit, evalue_mantissa, evalue_exponent,
                      percent_identity, percent_match
  paralogPairs      # reciprocal best hits among those proteins in your genome
                    # that were not mapped to OrthoMCL groups, as described
                    # below in the Algorithms section
  paralogGroups     # the proteins in paralogPairs clustered into groups by
                    # the mcl program, as described below in the Algorithms
                    # section
</pre></div>
          <p><strong>Documentation:</strong></p>
          <p>
            Instructions on how to use this service are freely available in
            <a href="http://onlinelibrary.wiley.com/doi/10.1002/0471250953.bi0612s35/full">
            Unit 6.12 of the Current Protocols of Bioinformatics.</a>
          </p>
          <p><strong>Algorithm</strong></p>
          <p>
            Please refer to the <a href="https://docs.google.com/document/d/1RB-SqCjBmcpNq-YbOYdFxotHGuU7RK_wqxqDAMjyP_w/pub">
            OrthoMCL Algorithm Document</a> for details about how OrthoMCL-DB is created.
            <ul>
              <li>BLASTP of your proteins against self and against OrthoMCL proteins.  Cutoff of e-5, and 50% match.</li>
              <li>For proteins that have an above-threshold match: assign the group from the best matching OrthoMCL protein.  If the best OrthoMCL protein does not have a group, assign NO_GROUP.</li>
              <li>For remaining proteins: use the InParalog algorithm described in the <a href="https://docs.google.com/document/d/1RB-SqCjBmcpNq-YbOYdFxotHGuU7RK_wqxqDAMjyP_w/pub">OrthoMCL Algorithm Document</a> to find potential paralog pairs.</li>
              <li>Submit those pairs to the <a href="http://www.micans.org/mcl/">MCL</a> program (see the <a href="https://docs.google.com/document/d/1RB-SqCjBmcpNq-YbOYdFxotHGuU7RK_wqxqDAMjyP_w/pub">OrthoMCL Algorithm Document</a>).</li>
            </ul>
          </p>
      
          <!-- END CONTENT -->
        
        </c:when>
        <c:otherwise>
          <h2>Service Not Available</h2>
          <p>
            The proteome upload service is not currently available.  Please try again later.
          </p>
        </c:otherwise>
      </c:choose>
    </div>
  </imp:pageFrame>
</jsp:root>
