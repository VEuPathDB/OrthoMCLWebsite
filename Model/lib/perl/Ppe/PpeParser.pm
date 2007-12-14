my $grammar = "
exp:  exp AND exp
|     exp OR  exp
|     '(' exp ')'
|     comparison
;

comparison:   claxons COMPARITOR RESULT;

claxons:      claxon more_claxons ;

more_claxons: '+' claxons | ;

claxon:       TAXON | CLADE ;
";

sub _Lexer {
    my $P = shift;

    my @Rv;

    my $yyd = $P->{YYData};

    while (length $yyd->{INPUT} > 0) {

       if (s/^([a-z]{3})//) {
          @Rv = ('TAXON', $1);
       }

    }

    return @Rv;
} 

sub parsePpe {
  
}
