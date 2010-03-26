use strict;
use warnings;
use ExtUtils::MakeMaker;

WriteMakefile(
    NAME                => 'KiokuX::Visualize::AsGraph',
    AUTHOR              => q{Nuba Princigalli <nuba@cpan.org>},
    VERSION_FROM        => 'lib/KiokuX/Visualize/AsGraph.pm',
    ABSTRACT_FROM       => 'lib/KiokuX/Visualize/AsGraph.pm',
    ($ExtUtils::MakeMaker::VERSION >= 6.3002
      ? ('LICENSE'=> 'perl')
      : ()),
    PL_FILES            => {},
    PREREQ_PM => {
        'Test::More' => 0,
        'KiokuDB' => 0,
        'GraphViz' => 0,
    },
    dist                => { COMPRESS => 'gzip -9f', SUFFIX => 'gz', },
    clean               => { FILES => 'KiokuX-AsGraph-*' },
);
