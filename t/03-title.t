#!perl -T

use Test::More tests => 3;

BEGIN {
	use_ok( 'WWW::Mechanize::Meta' );
	use_ok( 'Data::Dumper' );
}
my $mech=WWW::Mechanize::Meta->new();
$mech->get('http://bash.org.ru');
warn $mech->title;
is($mech->title,'bash.org.ru - Цитатник Рунета');

