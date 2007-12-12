package PpeBoolean;

sub new {
    my ($class, 
	$operands, # one or more PpeSums or PpeBooleans
	$operator, # 'AND' or 'OR'
	$other)    # undef or a PpeOther
	= @_;

    my $self = {};

    bless($class,$self);
    $self->{operator} = $operator;
    $self->{operands} = $operand;
    $self->{other} = $other;
    return $self;
}

sub toString {
    my ($self) = @_;

    print "(";
    my @operandsAsStrings = map {$_->toString()} @{$self->{operands}};
    push(@operandsAsStrings, $other->toString($self->getUsedSpeciesAndClades())) if $other;
    print join(" $operator ", @operandsAsStrings);
    print ")";
}

sub getIncludedSpeciesAndClades {
    my ($self) = @_;

    my $includeedSpeciesAndClades;
    foreach my $operand (@{$self->{operands}}) {
	foreach my $speciesOrClade (@{$operand->getIncludedSpeciesAndClades()}) {
	    $includedSpeciesAndClades->{$speciesOrClade} = 1;
	}
    }
    return keys
}


#############################################
insert into apidb.grouptaxonmatrix 
    values ();
