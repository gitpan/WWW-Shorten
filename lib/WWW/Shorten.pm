package WWW::Shorten;

use 5.006;
use strict;
no strict 'refs';
use warnings;

use base qw( WWW::Shorten::generic );
our @EXPORT = qw(makeashorterlink makealongerlink);
our $VERSION = '1.72';

use Carp;

my $style;

sub import
{
    my $class = shift;
    $style = shift;
    $style ||= 'MakeAShorterLink';
    my $package = "${class}::${style}";
    eval {
	my $file = $package;
	$file =~ s/::/\//g;
	require "$file.pm";
    };
    croak $@ if $@;
    $package->import( @_ );
}

sub makeashorterlink ($;@)
{
    my $url = shift or croak 'No URL passed to makeashorterlink';
    return "WWW::Shorten::${style}::makeashorterlink"->($url, @_);
}

sub makealongerlink ($) {
    my $code = shift 
	or croak 'No key / URL passed to makealongerlink';
    return "WWW::Shorten::${style}::makealongerlink"->($code);
}

1;

__END__
# Below is stub documentation for your module. You better edit it!

=head1 NAME

WWW::Shorten - Abstract interface to URL shortening sites.

=head1 SYNOPSIS

  use WWW::Shorten 'EkDk';
  use WWW::Shorten 'Fcol';
  use WWW::Shorten 'MakeAShorterLink';
  use WWW::Shorten 'Metamark';
  use WWW::Shorten 'NotLong';
  use WWW::Shorten 'QuickOnes';
  use WWW::Shorten 'Shorl';
  use WWW::Shorten 'SmLnk';
  use WWW::Shorten 'SnipURL';
  use WWW::Shorten 'TinyURL';

  # Individual modules have have their
  # own syntactic varations.

  # See the documentation for the particular
  # module you intend to use for details, trips
  # and traps.

  $short_url = makeashorterlink($long_url);

  $long_url  = makealongerlink($short_url);

  # If you don't like the function names:
  use WWW::Shorten 'SnipURL', ':short';
  $short_url = short_link( $long_url );
  $long_url = long_link( $short_url );

=head1 ABSTRACT

A Perl interface to URL shortening sites. These sites maintain
databases of long URLs, each of which has a unique identifier.

=head1 DESCRIPTION

The function C<makeashorterlink> will call the relevant web site
passing it your long URL and will return the shorter version.

The function C<makealongerlink> does the reverse. C<makealongerlink>
will accept as an argument either the full shortened URL or just the
identifier.

If anything goes wrong, then either function will return C<undef>.

=head2 EXPORT

makeashorterlink, makealongerlink

Or, if you specify C<:short> on the import line, you instead
get C<short_link> and C<long_link>. If you explicitly want the
default set, use C<:default>.

=head1 COMMAND LINE PROGRAM

A very simple program called F<shorten> is supplied in the
distribution's F<bin> folder. This program takes a URL and
gives you a shortened version of it.

=head1 THANKS

Dave Cross for L<WWW::MakeAShorterLink>

Alex Page for the original LWP hacking on which Dave based his code.

Simon Batistoni for giving the C<makealongerlink> idea to Dave.

Eric Hammond for writing the NotLong variant.

Shashank Tripathi for providing both SnipURL.com and advice on the
module.

Kevin Gilbertson (Gilby) supplied information on the TinyURL API interface.

Matt Felsen (mattf) wanted shorter function names.

=head1 BUGS

Please report bugs at <bug-www-shorten@rt.cpan.org>
or via the web interface at L<http://rt.cpan.org>

=head1 LICENSE AND COPYRIGHT

Copyright E<copy> Iain Truskett, 2002-03. All rights reserved.

This library is free software; you can redistribute it and/or modify
it under the same terms as Perl itself.

=head1 AUTHOR

Iain Truskett <spoon@cpan.org>

Based on WWW::MakeAShorterLink by Dave Cross <dave@dave.org.uk>

=head1 SEE ALSO

L<perl>

=cut
