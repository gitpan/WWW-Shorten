package WWW::Shorten::qURL;

use 5.006;
use strict;
use warnings;

use base qw( WWW::Shorten::generic Exporter );
our @EXPORT = qw(makeashorterlink makealongerlink);
our $VERSION = "1.83";

use Carp;

sub makeashorterlink ($;%)
{
    my $url = shift or croak 'No URL passed to makeashorterlink';
    my $ua = __PACKAGE__->ua();
    my $resp = $ua->post( 'http://qurl.net/' , [
        url => $url,
        action => 'Create qURL',
        ],
    );
    return unless $resp->is_success;
    if ($resp->content =~ m!
	qURL: \s+
        \Q<a href="\E
        ( \Qhttp://qurl.net/\E \w+ )
        \Q">http://qurl.net/\E\w+\Q</a>\E
	!xs) {
	return $1;
    }
    return;
}

sub makealongerlink ($)
{
    my $code = shift
	or croak 'No qURL nickname/URL passed to makealongerlink';
    my $ua = __PACKAGE__->ua();

    $code = "http://qurl.net/$code/" unless $code =~ m!^http://!i;

    my $resp = $ua->get($code);

    if ( my $refresh = $resp->header('Refresh') )
    {
	return $1 if $refresh =~ m/; URL=(.*)$/;
    }
    return;
}

1;

__END__
# Below is stub documentation for your module. You better edit it!

=head1 NAME

WWW::Shorten::qURL - Perl interface to qURL.net

=head1 SYNOPSIS

  use WWW::Shorten 'qURL';

  $short_url = makeashorterlink($long_url);
  $short_url = makeashorterlink($long_url, nickname => $nickname);
  ($short_url,$password) = makeashorterlink($long_url);
  ($short_url,$password) = makeashorterlink($long_url, nickname => $nickname);

  $long_url  = makealongerlink($short_url);
  $long_url  = makealongerlink($nickname);

=head1 DESCRIPTION

A Perl interface to the web site qURL.net.  qURL.net simply maintains
a database of long URLs, each of which has a unique identifier.

The function C<makeashorterlink> will call the qURL.net web site passing it
your long URL and will return the shorter (qURL) version.

The function C<makealongerlink> does the reverse. C<makealongerlink>
will accept as an argument either the full qURL URL or just the
qURL identifier/nickname.

If anything goes wrong, then either function will return C<undef>.

Multiple submissions of the same URL will result in the same code being
returned.

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

L<WWW::Shorten>, L<perl>, L<http://qurl.net/>

=cut
