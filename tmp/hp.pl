#!/usr/bin/perl
use HTML::HeadParser;
use Data::Dumper;
use HTTP::Headers;
use LWP::Simple;
$h = HTTP::Headers->new;
$p = HTML::HeadParser->new($h);
$p->parse(get 'http://walk2web.com');
die Dumper $p->header;