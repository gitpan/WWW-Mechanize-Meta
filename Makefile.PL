use strict;
use warnings;
use ExtUtils::MakeMaker;

WriteMakefile(
    NAME                => 'WWW::Mechanize::Meta',
    AUTHOR              => 'Andrey Kostenko <andrey@kostenko.name>',
    VERSION_FROM        => 'lib/WWW/Mechanize/Meta.pm',
    ABSTRACT_FROM       => 'lib/WWW/Mechanize/Meta.pm',
    PL_FILES            => {},
    PREREQ_PM => {
        'Test::More' => 0,
	'WWW::Mechanize' => 1.20,
    },
    dist                => { COMPRESS => 'gzip -9f', SUFFIX => 'gz', },
    clean               => { FILES => 'WWW-Mechanize-Meta-*' },
);
