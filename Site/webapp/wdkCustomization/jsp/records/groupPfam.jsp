<%@ taglib prefix="site" tagdir="/WEB-INF/tags/site" %>
<%@ taglib prefix="wdk" tagdir="/WEB-INF/tags/wdk" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="w" uri="http://www.servletsuite.com/servlets/wraptag" %>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>

<!-- get wdkRecord from proper scope -->
<c:set value="${requestScope.wdkRecord}" var="wdkRecord"/>

<c:set var="proteins" value="${wdkRecord.tables['ProteinPFams']}" />
<c:set var="domains" value="${wdkRecord.tables['PFams']}" />

<%-- generate domain colors --%>
<c:set var="domainCount" value="${fn:length(domains)}" />
<c:set var="maxLength" value="${wdkRecord.attributes['max_length']}" />


<script type="text/javascript">
$(initializePfams);
</script>


<h3>List of Domains (present in this group)</h3>
<table id="domains" count="${domainCount}">
  <tr>
    <th>Accession</th>
    <th>Name</th>
    <th>Description</th>
    <th>Legend</th>
  </tr>
  <c:set var="odd" value="${true}" />
  <c:forEach items="${domains}" var="domain">
    <c:set var="rowClass" value="${odd ? 'rowLight' : 'rowMedium'}" />
    <c:set var="odd" value="${!odd}" />
    <tr id="${domain['primary_identifier']}" class="domain ${rowClass}" >
      <td>${domain["primary_identifier"]}</td>
      <td>${domain["secondary_identifier"]}</td>
      <td>${domain["remark"]}</td>
      <td><div class="legend"> </div></td>
    </tr>
  </c:forEach>
</table>


<h3>List of Protein Domain Architectures</h3>
<table id="proteins" maxLength="${maxLength}" width="100%">
  <tr>
    <th>Accession</th>
    <th>Length</th>
    <th id="ruler" width="100%"></th>
  </tr>

  <c:set var="odd" value="${true}" />
  <c:set var="previous_id" value="${''}" />
  <c:forEach items="${proteins}" var="row">
    <c:set var="source_id" value="${row['source_id'].value}" />
    <c:if test="${previous_id != source_id}">
      <c:if test="${previous_id != ''}"></div></td></tr></c:if>
      <c:set var="previous_id" value="${source_id}" />
      <c:set var="rowClass" value="${odd ? 'rowLight' : 'rowMedium'}" />
      <c:set var="odd" value="${!odd}" />
      <tr class="protein ${rowClass}">
        <td class="source-id">
          <a href="<c:url value='/showRecord.do?name=SequenceRecordClasses.SequenceRecordClass&source_id=${source_id}' />">${source_id}</a>
        </td>
        <td class="length">${row['length']}</td>
        <td>
          <div class="domains">
            <div class="protein-graph"> </div>
    </c:if>
    <div class="domain" id="${row['primary_identifier']}" start="${row['start_min']}" end="${row['end_max']}">
      <div></div>
    </div>
  </c:forEach>
  <c:if test="${previous_id != ''}">
  <div></td></tr>
</c:if>
</table>


<%--
  my $length_max=$length_data[0];
  my $dom_height=14;
  my $spacer_height=15;
  my $margin_x = 10;
  my $margin_y = 40;
    my $scale_factor=0.7;
    my $tick_step=50; # generally 50 is used, but when $length_max is too big, ...
      if ($length_max>=2000) {
        $tick_step = int($length_max/2000)*100;
      }
  if ($length_max>1000) {
    $scale_factor = $scale_factor*(1000/$length_max);
  }
  my $size_x = $length_max*$scale_factor+2*$margin_x;
  my $size_y = $margin_y + $dom_height + $spacer_height;
    my $pos_y = $margin_y + $spacer_height + $dom_height/2;

    # Fetch sequences
    $query_sequence_by_groupid->execute($orthogroup_id);

    my @sequence_ids;
    my %domains_seen;
    while (my @sequence_data = $query_sequence_by_groupid->fetchrow_array()) {
  push(@sequence_ids,$sequence_data[0]);
  my %sequence;
  #my @sequence_ids;
  #my %domains_seen;
  $sequence{SEQUENCE_ACCESSION}=$sequence_data[1];
  $sequence{SEQUENCE_TAXON}=$sequence_data[4];
  $sequence{SEQUENCE_LINK}=$config->{basehref} . "/cgi-bin/OrthoMclWeb.cgi?rm=sequence&accession=".$sequence{SEQUENCE_ACCESSION}."&t
axon=".$sequence{SEQUENCE_TAXON};
  $sequence{SEQUENCE_LENGTH}=$sequence_data[3];

  my $sequence_image=$config->{basehref} . "/cgi-bin/OrthoMclWeb.cgi?rm=drawProtein&margin_x=$margin_x&scale_factor=$scale_factor&po
s_y=$pos_y&size_x=$size_x&size_y=$size_y&dom_height=$dom_height&length=$sequence_data[3]&length_max=$length_max&tick_step=$tick_step
&margin_y=$margin_y&spacer_height=$spacer_height";
--%>



