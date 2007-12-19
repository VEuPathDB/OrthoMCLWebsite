package OrthoMCLWebsite::Model::Ppe::Processor;

@ISA = qw( ApiCommonWebsite::View::CgiApp );

use strict;
use ApiCommonWebsite::View::CgiApp;
use OrthoMCLWebsite::Model::Ppe::ColumnManager;
use OrthoMCLWebsite::Model::Ppe::Parser;

sub run {
  my ($self, $cgi) = @_;

  print $cgi->header('text/plain');

  my $expression = $cgi->param('expression');
  &error("missing 'expression' param") unless $expression;
  my $groupIds = $self->processPpe($expression);

  exit();
}

sub processPpe {
  my ($self, $ppeExpression) = @_;

  my $dbh = $self->getQueryHandle();
  my $columnMgr = OrthoMCLWebsite::Model::Ppe::ColumnManager->new($dbh);
  my $boolean = $self->parsePpeExpression($ppeExpression);
  my $whereClause = $boolean->toSqlString($columnMgr);
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

sub parsePpeExpression {
    my($self, $expression) = @_;
    
    my $parser = OrthoMCLWebsite::Model::Ppe::Parser->new();
    $expression = "abc + def = 4";
    $parser->YYData()->{INPUT} = $expression;
    return $parser->YYParse(yylex => \&OrthoMCLWebsite::Model::Ppe::Parser::Lexer,
			    yyerror => \&OrthoMCLWebsite::Model::Ppe::Parser::Error,
			    yydebug => 0x1f);
}

sub error {
  my ($msg) = @_;

  print "ERROR: $msg\n\n";
  exit(1);
}


