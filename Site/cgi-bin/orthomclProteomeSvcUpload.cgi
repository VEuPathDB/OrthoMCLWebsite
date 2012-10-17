#!/usr/bin/perl -w

use strict;
use lib "../cgi-lib";

use ProteomeSvcUpload;

my $webapp = ProteomeSvcUpload->new();
$webapp->run();
