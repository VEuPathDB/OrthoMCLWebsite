#!/usr/bin/perl -w

use strict;
use lib "../cgi-lib";

use OrthoMclWeb;

my $webapp = OrthoMclWeb->new();
$webapp->run();
