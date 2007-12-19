package OrthoMCLWebsite::Model::Ppe::ColumnManager;

use strict;


sub new {
    my ($class, $dbh) = @_;

    my $self = {};

    bless($self, $class);
    $self->{dbh} = $dbh;
    return $self;
}

# we have an ordered list of three letter abbreviations.
# use it to generate a column name for a particular taxon
# each taxon gets two columns, one for protein count, one for taxon count.
# to get column number, double the index.  if taxon count desired, add 1.
sub getColumnName {
    my ($self, $taxonAbbrev, $proteinOrTaxonFlag) = @_;

    return "column" . $self->getValidTaxonAbbrevs()->{$taxonAbbrev} * 2
	+ ($proteinOrTaxonFlag eq 'T'? 1 : 0);
}

sub checkTaxonAbbrev {
    my ($self, $taxonAbbrev) = @_;

    return 1 if getValidTaxonAbbrevs()->{$taxonAbbrev};
}

# return hash of valid taxon abbrevs.  key -> abbrev, value -> order
sub getValidTaxonAbbrevs {
    my ($self) = @_;

    if (!$self->{validTaxonAbbrevs}) {
      $self->{validTaxonAbbrevs} = {};
      my $sql = "
select three_letter_abbrev
from apidb.orthomcltaxon
order by three_letter_abbrev
";
      my $stmt = $self->{dbh}->prepare($sql);
      my $orderedTaxonAbbrevs;
      my $validTaxonAbbrevs;
      my $order = 1;
      while (my $row = $stmt->fetchRowHashRef()) {
	$self->{validTaxonAbbrevs}->{$row->{three_letter_abbrev}} = $order++;
      }
    }
    return $self->{validTaxonAbbrevs};
}

1;
