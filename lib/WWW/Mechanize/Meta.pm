package WWW::Mechanize::Meta;

use warnings;
use strict;
use Data::Dumper;
use HTML::HeadParser;

use base 'WWW::Mechanize';

=head1 NAME

WWW::Mechanize::Meta - Adds HEAD tag parsing to WWW::Mechanize

=head1 VERSION

Version 0.02

=cut

our $VERSION = '0.02';

=head1 SYNOPSIS

    use WWW::Mechanize::Meta;

    my $mech = WWW::Mechanize::Meta->new();
    my @css=$mech->link('stylesheet');
    foreach (@css){
	print "$_->{href}\n";
    }
    

=head1 METHODS

=head2 link( [$type] )

Returns link tag with attribure rel = $type. If no attribute $type given, returns all link tags.

=cut

sub link {
    my $self=shift;
    my $type=shift;
    my @links;
    foreach my $link ($self->{head}->header('link')){
#FIXME	this is bad
	my @params=split '; ',$link;
	my $src=((shift @params)=~m/<(.*)>/);
	my %params=map{m/(.*)=\"([^\"]*)\"/} @params;
	$params{href}=$src;
	push @links,\%params if !$type || $params{rel} eq $type;
    };
    return @links;
    
}

=head2 headtag

Returns raw header object

=cut

sub headtag{
    my $self=shift;
    return $self->{head};
}

=head1 INTERNAL METHODS

=head2 new

=cut

sub new{
    my $class=shift;
    my $self=$class->SUPER::new(@_);
    $self->{headparser}=HTML::HeadParser->new();
    return $self;
}

=head2 update_html

=cut

sub update_html{
    my $self=shift;
    my $html=shift;
    $self->SUPER::update_html($html);
#    warn $html;
    if ($self->is_html){
	$self->{headparser}->parse($self->content);
	$self->{head}=$self->{headparser}->header;
    } else {
	$self->{head}=undef;
	$self->{link}=undef;
    }
    return;
}

=head2 _parse_head

=cut

sub _parse_head{
    my $self=shift;
    return unless $self->is_html;
    require HTML::HeadParser;
    my $p = HTML::HeadParser->new;
    $p->parse($self->content);
}

=head1 AUTHOR

Andrey Kostenko, C<< <andrey@kostenko.name> >>

=head1 BUGS

Please report any bugs or feature requests to
C<bug-www-mechanize-meta at rt.cpan.org>, or through the web interface at
L<http://rt.cpan.org/NoAuth/ReportBug.html?Queue=WWW-Mechanize-Meta>.
I will be notified, and then you'll automatically be notified of progress on
your bug as I make changes.

=head1 SUPPORT

You can find documentation for this module with the perldoc command.

    perldoc WWW::Mechanize::Meta

You can also look for information at:

=over 4

=item * AnnoCPAN: Annotated CPAN documentation

L<http://annocpan.org/dist/WWW-Mechanize-Meta>

=item * CPAN Ratings

L<http://cpanratings.perl.org/d/WWW-Mechanize-Meta>

=item * RT: CPAN's request tracker

L<http://rt.cpan.org/NoAuth/Bugs.html?Dist=WWW-Mechanize-Meta>

=item * Search CPAN

L<http://search.cpan.org/dist/WWW-Mechanize-Meta>

=back

=head1 ACKNOWLEDGEMENTS

=head1 COPYRIGHT & LICENSE

Copyright 2007 Andrey Kostenko, all rights reserved.

This program is free software; you can redistribute it and/or modify it
under the same terms as Perl itself.

=cut

1; # End of WWW::Mechanize::Meta
