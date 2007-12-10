package PpeProcessor;

sub processPpe {
  my ($ppe) = @_;
  
  my $validTaxonAbbrevs = &getValidTaxonAbbrevs();
  my $ppe = &parsePpeExpression($ppeExpression, $validTaxonAbbrevs);
  my $whereClause = &convertPpeToSqlWhereClause($ppe, $cladeTree);
  my $sql = "
SELECT group_id
FROM PpeMatrixTable
$whereClause
ORDER BY group_id
";

}

sub createMatrixTable {
  return if matrixTableExists();

}

sub getValidTaxonAbbrevs {
    my () = @_;
    my $validTaxonAbbrevs;
    while (my $row = $stmt->fetchRowHashRef()) {
	$validTaxonAbbrevs{$row->{three_letter_abbrev}} = 1;
    }
    return $validTaxonAbbrevs;
}
