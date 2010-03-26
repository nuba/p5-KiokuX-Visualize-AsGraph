#!/home/nuba/perl/5.10.1/bin/perl

use strict;
use warnings;

use FindBin qw($Bin);
use lib "$Bin/../lib";

use KiokuDB;

use KiokuX::Visualize::AsGraph;
use KiokuX::Visualize::AsGraph::GraphViz;

my $dir = KiokuDB->connect(
  "dbi:SQLite:dbname=kiokudb_tutorial.sqlite", 
);

my $backend = $dir->backend;

my $scan = KiokuX::Visualize::AsGraph->new(
    backend => $backend,
);

open (my $fh, ">kiokudb_asgraph_graphviz.png");
print $fh $scan->results->graphviz->as_png;
close $fh;

open ($fh, ">kiokudb_asgraph_graphviz.svg");
print $fh $scan->results->graphviz->as_svg;
close $fh;

open ($fh, ">kiokudb_asgraph_graphviz.dot");
print $fh $scan->results->graphviz->as_canon;
close $fh;

sleep 1;

