package OrthoMCLWebsite::Model::Ppe::Other;

use OrthoMCLWebsite::Model::Ppe::Comparison;

@ISA = qw( OrthoMCLWebsite::Model::Ppe::Comparison );

use strict;

sub new {
    my ($class,
	$comparator, # '=', '<', '>', '>=', '<='
	$value,      # numeric value 
	$proteinOrTaxonFlag) # 'P' or 'T'
	= @_;

    my $self = {};

    bless($self, $class);
    $self->{comparator} = $comparator;
    $self->{value} = $value;
    return $self;
}

sub setTaxa {
    my ($self, $taxa) = @_;
    $self->{taxa} = $taxa;
}

1;
