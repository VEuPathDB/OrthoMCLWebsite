<%@ taglib prefix="site" tagdir="/WEB-INF/tags/site" %>
<%@ taglib prefix="wdk" tagdir="/WEB-INF/tags/wdk" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="w" uri="http://www.servletsuite.com/servlets/wraptag" %>

<!-- get wdkRecord from proper scope -->
<c:set value="${requestScope.wdkRecord}" var="wdkRecord"/>

<c:set var="max_length" value="${wdkRecord.attributes['max_length'].value}" />
<c:set var="proteins" value="${wdkRecord.tables['Proteins']}" />
<c:set var="PFamDomains" value="${wdkRecord.tables['PFamDomains']}" />

<c:set var="dom_height" value="${14}" />
<c:set var="spacer_height" value="${15}" />
<c:set var="margin_x" value="${10}" />
<c:set var="margin_y" value="${40}" />
<c:set var="scale_factor" value="${0.7}" />
<c:set var="tick_step" value="${50}" />

<c:if test="${max_length >= 2000}">
  <c:set var="tick_step" value="${max_length / 20}" />
</c:if>
<c:if test="${max_length > 1000}">
  <c:set var="scale_factor" value="${scale_factor * (1000 / max_length)}" />
</c:if>

<c:set var="size_x" value="${max_length * scale_factor + 2 * margin_x}" />
<c:set var="size_y" value="${margin_y + dom_height + spacer_height}" />
<c:set var="pos_y" value="${margin_y + dom_height / 2 + spacer_height}" />

<table>
  <tr>
    <th>Accession</th>
    <th>Length</th>
    <th>Pfam Domain Architecture</th>
  </tr>

<c:set var="odd" value="${true}" />
<c:forEach items="${proteins}" var="row">
  <c:set var="source_id" value="${row['source_id']}" />
  <c:set var="length" value="${row['length']}" />
  <c:set var="rowClass"><c:choose><c:when test="${odd}">rowLight</c:when><c:otherwise>rowMedium</c:otherwise></c:choose></c:set>
  <tr>
    <td>${source_id}</td>
    <td>${length}</td>
    <td>
      <%-- the hard-coded url need to removed after the drawing code is refactored into an independent package. --%>
      <img src="http://orthomcl.org/cgi-bin/OrthoMclWeb.cgi?rm=drawProtein&margin_x=${margin_x}&scale_factor=${scale_factor}&pos_y=${pos_y}&size_x=${size_x}&size_y=${size_y}&dom_height=${dom_height}&length=${length}&length_max=${max_length}&tick_step=${tick_step}&margin_y=${margin_y}&spacer_height=${spacer_height}" />
    </td>
  </tr>
</c:forEach>
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



