package WWW::Shorten::ShortLink;
use 5.006;
use strict;
use warnings;

use base qw( WWW::Shorten::generic Exporter );
our @EXPORT = qw( makeashorterlink makealongerlink );
our $VERSION = "1.82";

use Carp;
use URI;

sub makeashorterlink ($)
{
    my $url = shift or croak 'No URL passed to makeashorterlink';
    my $ua = __PACKAGE__->ua();
    my $resp = $ua->post( 'http://shortlink.us/', {
	    doit => 1,
	    link => $url,
	});
    return unless $resp->is_success;
    if ($resp->content =~ m, (\Qhttp://shortlink.us/\E\d+) ,xi) {
	return lc $1;
    }
    return;
}

sub makealongerlink ($)
{
    my $sl_url = shift or croak 'No sl key / URL passed to makealongerlink';
    my $ua = __PACKAGE__->ua();
    $sl_url = lc $sl_url;

    $sl_url =~ s{ ^\Qhttp://shortlink.us/\E \?? }{}x;
    $sl_url = "http://shortlink.us/$sl_url" unless $sl_url =~ m!^http://!i;

    my $resp = $ua->get($sl_url);
    return undef unless $resp->is_redirect;
    my $url = $resp->header('Location');
    return $url;
}

1;

__END__


=head1 NAME

WWW::Shorten::ShortLink - Perl interface to shortlink.us

=head1 SYNOPSIS

  use WWW::Shorten::ShortLink;

  use WWW::Shorten 'ShortLink';

  $short_url = makeashorterlink($long_url);

  $long_url  = makealongerlink($short_url);

=head1 DESCRIPTION

A Perl interface to the web site shortlink.us, a site that maintains
a database of long URLs, each of which has a unique identifier.

The function C<makeashorterlink> will call the ShortLink web site passing it
your long URL and will return the shorter ShortLink version.

The function C<makealongerlink> does the reverse. C<makealongerlink>
will accept as an argument either the full ShortLink URL or just the
ShortLink identifier.

If anything goes wrong, then either function will return C<undef>.

=head2 EXPORT

makeashorterlink, makealongerlink

=head1 BUGS, REQUESTS, COMMENTS

Please report any requests, suggestions or bugs via the system at
L<http://rt.cpan.org/>, or email E<lt>bug-WWW-Shorten@rt.cpan.orgE<gt>.
This makes it much easier for me to track things and thus means
your problem is less likely to be neglected.

=head1 AUTHOR

Iain Truskett <spoon@cpan.org>

=head1 SEE ALSO

L<WWW::Shorten>, L<perl>, L<http://shortlink.us/>

=cut
