package Ppe::Boolean;

sub new {
    my ($class, 
	$head, # a Comparison, OtherComparison or Boolean
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


# this is made complicated by needing to handle OTHER
# to do so, we 
sub toString {
    my ($self) = @_;

    my $s = $self->{head}->toString();
    $s = "($s)" if ref($self->{head}) eq 'Boolean';

    if ($self->{tail}) {
	$s = "$s $self->{type} " . $self->{tail}->toString();
    }
    return $s;
}

sub toSqlString {
    my ($self) = @_;
    $self->toString();
}

# call getOtherAndTaxa 
# if Other found then set its taxa w/ the taxa list
sub setOtherTaxa {
    my ($self) = @_;

    my ($taxa,$other) = $self->getOtherAndTaxa();
    $other->setTaxa($taxa) if $other;
}

# recurse through my peer boolean elements and collect the list of
# all taxa.  also find the Other if any
# (if more than one Other, 
sub getOtherAndTaxa {
    my ($self) = @_;

    my ($headTaxa, $tailTaxa, $other);
    if (ref($self->{head}) eq 'OtherComparison') {
	$other = $self->{head};
    } else {
	($headTaxa) = $self->{head}->getOtherAndTaxa();
    }

    if (ref($self->{head}) eq 'Boolean') {
	$self->{head}->setOtherTaxa();
    }

    if ($tail) {
	my $other2;
	($tailTaxa, $other2) = $self->{tail}->getOtherAndTaxa();
	$other = $other2 unless $other;
    }

    return (&hashUnion($tailTaxa, $headTaxa), $other);
}

sub hashUnion {
    my ($hash1, $hash2) = @_;

    my $hash3;
    foreach my $key (keys($hash1)) {
	$hash3->{key} = 0 unless $hash3->{key};
	$hash3->{key} += $hash1->{key};
    }
    foreach my $key (keys($hash2)) {
	$hash3->{key} = 0 unless $hash3->{key};
	$hash3->{key} += $hash2->{key};
    }
    return $hash3;
}

