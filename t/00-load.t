#!perl -T

use Test::More tests => 1;

BEGIN {
    use_ok( 'KiokuX::Visualize::AsGraph' ) || print "Bail out!";
    use_ok( 'KiokuX::Visualize::AsGraph::GraphViz' ) || print "Bail out!";
}

diag( "Testing KiokuX::AsGraph $KiokuX::Visualize::AsGraph::VERSION, Perl $], $^X" );
