package WWW::Shorten::TinyURL;

use 5.006;
use strict;
use warnings;

use base qw( WWW::Shorten::generic Exporter );
our @EXPORT = qw( makeashorterlink makealongerlink );
our $VERSION = '1.53';

use Carp;

sub makeashorterlink ($)
{
    my $url = shift or croak 'No URL passed to makeashorterlink';
    my $ua = __PACKAGE__->ua();
    my $tinyurl = 'http://tinyurl.com/api-create.php';
    my $resp = $ua->post($tinyurl, [
	url => $url,
	source => "PerlAPI-$VERSION",
	]);
    return undef unless $resp->is_success;
    my $content = $resp->content;
    return undef if $content =~ /Error/;
    if ($resp->content =~ m!(\Qhttp://tinyurl.com/\E\w+)!x) {
	return $1;
    }
    return;
}

sub makealongerlink ($)
{
    my $tinyurl_url = shift 
	or croak 'No TinyURL key / URL passed to makealongerlink';
    my $ua = __PACKAGE__->ua();

    $tinyurl_url = "http://tinyurl.com/$tinyurl_url"
    unless $tinyurl_url =~ m!^http://!i;

    my $resp = $ua->get($tinyurl_url);

    return undef unless $resp->is_redirect;
    my $url = $resp->header('Location');
    return $url;

}

1;

__END__
# Below is stub documentation for your module. You better edit it!

=head1 NAME

WWW::Shorten::TinyURL - Perl interface to tinyurl.com

=head1 SYNOPSIS

  use WWW::Shorten::TinyURL;
  use WWW::Shorten 'TinyURL';

  $short_url = makeashorterlink($long_url);

  $long_url  = makealongerlink($short_url);

=head1 DESCRIPTION

A Perl interface to the web site tinyurl.com.  TinyURL simply maintains
a database of long URLs, each of which has a unique identifier.

The function C<makeashorterlink> will call the TinyURL web site passing
it your long URL and will return the shorter TinyURL version.

The function C<makealongerlink> does the reverse. C<makealongerlink>
will accept as an argument either the full TinyURL URL or just the
TinyURL identifier.

If anything goes wrong, then either function will return C<undef>.

=head2 EXPORT

makeashorterlink, makealongerlink

=head1 BUGS, REQUESTS, COMMENTS

Please report any requests, suggestions or bugs via the system at
L<http://rt.cpan.org/>, or email E<lt>bug-WWW-Shorten@rt.cpan.orgE<gt>.
This makes it much easier for me to track things and thus means
your problem is less likely to be neglected.

=head1 THANKS

Thanks to Kevin Gilbertson (Gilby) for information on the TinyURL API
interface.

=head1 AUTHOR

Iain Truskett <spoon@cpan.org>

Based on WWW::MakeAShorterLink by Dave Cross <dave@dave.org.uk>

=head1 SEE ALSO

L<WWW::Shorten>, L<perl>, L<http://tinyurl.com/>

=cut
