package OrthoMCLWebsite::Model::Ppe:PpeProcessor;

@ISA = qw( ApiCommonWebsite::View::CgiApp );

use strict;
use ApiCommonWebsite::View::CgiApp;
use OrthoMCLWebsite::Model::Ppe::PpeColumnManager;

sub run {
  my ($self, $cgi) = @_;

  print $cgi->header('text/plain');

  my $groupIds = $self->processPpe($cgi->param('expression'));

  exit();
}


sub processPpe {
  my ($self, $ppeExpression) = @_;

  my $dbh = $self->getQueryHandle();
  my $columnMgr = OrthoMCLWebsite::Model::Ppe::PpeColumnManager->new($dbh);
  my $ppe = $self->parsePpeExpression($ppeExpression, $columnMgr);
  my $whereClause = $ppe->printToSql($columnMgr);
  my $sql = "
SELECT group_id
FROM PpeMatrixTable
WHERE $whereClause
ORDER BY group_id
";
  my $stmt = $dbh->prepare($sql);
  $stmt->execute();
  my $groupIds;
  while (my $id = $stmt->fetchRowArray) {
      push(@$groupIds, $id);
  }
  return $groupIds;
}

