# $Id: V3.pm,v 1.90 2004/10/30 12:52:01 dave Exp $

=head1 NAME

WWW::Shorten::V3 - Perl interface to v3.net

=head1 SYNOPSIS

  use WWW::Shorten 'V3';

  $short_url = makeashorterlink($long_url);

  $long_url  = makealongerlink($short_url);
  $long_url  = makealongerlink($nickname);

=head1 DESCRIPTION

A Perl interface to the web site v3.net.  v3.net simply maintains
a database of long URLs, each of which has a unique identifier.

=cut

package WWW::Shorten::V3;

use 5.006;
use strict;
use warnings;

use base qw( WWW::Shorten::generic Exporter );
our @EXPORT = qw(makeashorterlink makealongerlink);
our $VERSION = sprintf "%d.%02d", '$Revision: 1.90 $ ' =~ /(\d+)\.(\d+)/;

use Carp;

=head1 Functions

=head2 makeashorterlink

The function C<makeashorterlink> will call the v3.net web site passing it
your long URL and will return the shorter (V3) version.

Multiple submissions of the same URL will result in different codes
being returned.

=cut

sub makeashorterlink ($)
{
    my $url = shift or croak 'No URL passed to makeashorterlink';
    my $ua = __PACKAGE__->ua();

    my $resp = $ua->post( 'http://makeurl.v3.net/' , [
        shorten => $url,
        ],
    );
    return unless $resp->is_success;
    if ($resp->content =~ m!
        href="(http://\d+\.v3\.net/)"
        [^>]+>
        http://\d+\.v3\.net</a>
	!xs) {
	return $1;
    }
    return;
}

=head2 makealongerlink

The function C<makealongerlink> does the reverse. C<makealongerlink>
will accept as an argument either the full V3 URL or just the
V3 identifier/nickname.

If anything goes wrong, then either function will return C<undef>.

=cut

sub makealongerlink ($)
{
    my $code = shift
	or croak 'No v3 nickname/URL passed to makealongerlink';
    my $ua = __PACKAGE__->ua();

    $code = "http://$code.v3.net/" unless $code =~ m!^http://!i;

    my $resp = $ua->get($code);
    return unless $resp->is_redirect;
    my $url = $resp->header('Location');
    return $url;
}

1;

__END__

=head2 EXPORT

makeashorterlink, makealongerlink

=head1 SUPPORT, LICENCE, THANKS and SUCH

See the main L<WWW::Shorten> docs.

=head1 AUTHOR

Iain Truskett <spoon@cpan.org>

=head1 SEE ALSO

L<WWW::Shorten>, L<perl>, L<http://v3.net/>

=cut
