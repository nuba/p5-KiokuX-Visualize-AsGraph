#!perl -T

use Test::More tests => 1;

BEGIN {
    use_ok( 'KiokuX::AsGraph' ) || print "Bail out!
";
}

diag( "Testing KiokuX::AsGraph $KiokuX::AsGraph::VERSION, Perl $], $^X" );
