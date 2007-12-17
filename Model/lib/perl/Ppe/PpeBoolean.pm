package PpeExpression;

sub new {
    my ($class, 
	$head, # a Comparison, Other or Boolean
	$tail, # a recursive list of Booleans or undef
        $type) # 'AND' or 'OR'
	= @_;

    my $self = {};

    bless($class,$self);
    $self->{head} = $head;
    $self->{tail} = $tail;
    $self->{type} = $type;

    return $self;
}

sub toString {
    my ($self) = @_;

    print "(";
    my @operandsAsStrings = map {$_->toString()} @{$self->{operands}};
    push(@operandsAsStrings, $other->toString($self->getIncludedSpeciesAndClades())) if $other;
    print join(" $operator ", @operandsAsStrings);
    print ")";
}

sub toSqlString {
    my ($self) = @_;
    $self->toString();
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

