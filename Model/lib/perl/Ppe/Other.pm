package OrthoMCLWebsite::Model::Ppe::Other;

@ISA = (OrthoMCLWebsite::Model::Ppe::Comparison);

use strict;

sub new {
    my ($class, 
	$comparator, # '=', '<', '>', '>=', '<='
	$value,      # numeric value 
	$proteinOrTaxonFlag # 'P' or 'T'
	= @_;

    my $self = {};

    bless($class,$self);
    $self->{comparator} = $relation;
    $self->{value} = $value;
    return $self;
}

sub setTaxa {
    my ($self, $taxa) = @_;
    $self->{taxa} = $taxa;
}

