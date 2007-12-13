package OrthoMCLWebsite::Model::Ppe:PpeProcessor;

@ISA = qw( ApiCommonWebsite::View::CgiApp );

use strict;
use ApiCommonWebsite::View::CgiApp;

sub run {
  my ($self, $cgi) = @_;

  my $dbh = $self->getQueryHandle($cgi);

  print $cgi->header('text/plain');

  $self->processParams($cgi, $dbh);

  $self->processPpe();

  exit();
}

sub processPpe {
  my ($self, $ppeExpression, $cladeTreeFile) = @_;

  my $validTaxonAbbrevs = &getValidTaxonAbbrevs();
  my $ppe = &parsePpeExpression($ppeExpression, $validTaxonAbbrevs);
  my $whereClause = &parsePpe($ppe, $cladeTree);
  my $sql = "
SELECT group_id
FROM PpeMatrixTable
$whereClause
ORDER BY group_id
";

}

sub getCladeTree {
  my ($cladeTreeFile) = @_;

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
