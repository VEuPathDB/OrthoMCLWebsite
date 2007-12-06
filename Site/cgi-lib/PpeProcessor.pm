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

sub parseCladeTreeFile() {
    my ($cladeTreeFile) = @_;

    open(FILE, $cladeTreeFile) || die "couldn't open cladeTreeFile '$cladeTreeFile'\n";
    my $handle = ;
    my $clade = {};
    my $indent = 0;
    &descendCladeTreeFile($handle, $tree, $indent)
}

sub descendCladeTreeFile() {
    my ($handle, $clade, $indent) = @_;

    my $line = $handle->nextLine();
    if ($line =~ /([A-Z][A-Z][A-Z])/) {  # new clade
	
	$clade->();
    } elsif ($line =~ /([a-z][a-z][a-z])/) {
    } else {
	die "invalid input line\n";
    }
}
