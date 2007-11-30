package PpeProcessor;

sub processPpe {
  my ($ppe) = @_;

  my $cladeTree = getCladeTree();
  &createMatrixTable($cladeTree);
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
