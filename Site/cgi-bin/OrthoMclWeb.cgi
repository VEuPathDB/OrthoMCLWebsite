#!/usr/bin/perl -Tw

use strict;
use lib "../cgi-lib";

use OrthoMclWeb;

my $webapp = OrthoMclWeb->new();
$webapp->run();
