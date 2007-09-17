#!perl -T

use Test::More tests => 4;

BEGIN {
	use_ok( 'WWW::Mechanize::Meta' );
	use_ok( 'Data::Dumper' );
}
my $mech=WWW::Mechanize::Meta->new();
$mech->get('http://search.cpan.org');
my @rss=$mech->link('alternate');
ok(@rss);
like($rss[0]->{href},qr~\Qhttp://search.cpan.org/\E~);
