package WWW::Shorten::SnipURL;

use 5.006;
use strict;
use warnings;

use base qw( WWW::Shorten::generic Exporter );
our @EXPORT = qw(makeashorterlink makealongerlink);
our $VERSION = '1.52';

use Carp;

sub makeashorterlink ($;%)
{
    my $url = shift or croak 'No URL passed to makeashorterlink';
    my $ua = __PACKAGE__->ua();
    my ($nick,$pass) = @_;
    my $snipurl = 'http://snipurl.com/';
    my $resp = $ua->post($snipurl, [
	link => $url,
	alias => (defined $nick ? $nick : ''),
	protected_key => (defined $pass ? $pass : ''),
	]);
    return unless $resp->is_success;
    if ($resp->content =~ m!
	<a \s+ href=['"] ([^'"]+) ['"][^>]*>
	(\Qhttp://snipurl.com/\E\w+)
	</a>
	!xm) {
	return $1;
    }
    return undef;
}

sub makealongerlink ($)
{
    my $snipurl_url = shift 
	or croak 'No SnipURL key / URL passed to makealongerlink';
    my $ua = __PACKAGE__->ua();

    $snipurl_url = "http://snipurl.com/$snipurl_url"
    unless $snipurl_url =~ m!^http://!i;

    my $resp = $ua->get($snipurl_url);

    return undef unless $resp->is_redirect;
    my $url = $resp->header('Location');
    {
	$resp = $ua->get($url);
	return $url unless $resp->is_redirect;
	$url = $resp->header('Location');
    }
    return $url;

}

1;

__END__
# Below is stub documentation for your module. You better edit it!

=head1 NAME

WWW::Shorten::SnipURL - Perl interface to SnipURL.com

=head1 SYNOPSIS

  use WWW::Shorten::SnipURL;

  use WWW::Shorten 'SnipURL';

  $short_url = makeashorterlink($long_url);

  $long_url  = makealongerlink($short_url);

=head1 DESCRIPTION

A Perl interface to the web service SnipURL.com. SnipURL maintains a
database of long URLs, each of which has a unique identifier or
nickname. For more features, please visit http://snipurl.com/features

The function C<makeashorterlink> will call the SnipURL web site passing it
your long URL and will return the shorter SnipURL version. If used in a
list context, then it will return both the Snip URL and the password.

The function C<makealongerlink> does the reverse. C<makealongerlink>
will accept as an argument either the full Snip URL or just the
SnipURL identifier.

If anything goes wrong, then either function will return C<undef>.

=head2 EXPORT

makeashorterlink, makealongerlink

=head1 BUGS

Please report bugs at <bug-www-shorten@rt.cpan.org>
or via the web interface at L<http://rt.cpan.org>

=head1 THANKS

Shashank Tripathi <shank@shank.com> for providing both
SnipURL.com and advice on the module.

=head1 AUTHOR

Iain Truskett <spoon@cpan.org>

Based on WWW::MakeAShorterLink by Dave Cross <dave@dave.org.uk>

=head1 SEE ALSO

L<WWW::Shorten>, L<perl>, L<http://snipurl.com/>

=cut
