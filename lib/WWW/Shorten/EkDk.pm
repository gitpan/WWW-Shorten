package WWW::Shorten::EkDk;

use 5.006;
use strict;
use warnings;

use base qw( WWW::Shorten::generic Exporter );
our @EXPORT = qw(makeashorterlink makealongerlink);
our $VERSION = '1.11';

use Carp;
use URI;

sub makeashorterlink ($$)
{
    my $url = shift or croak 'No URL passed to makeashorterlink';
    my $name = shift or croak 'No name passed to makeashorterlink';
    my $ua = __PACKAGE__->ua();
    my $uri = URI->new('http://add.redir.ek.dk/');
    $uri->query_form(
	url => $url,
	name => $name,
    );
    my $resp = $ua->get( $uri );
    return unless $resp->is_success;
    if ($resp->content =~ m!
	"(\Qhttp://redirect.ek.dk/\E[^"]+)"
	!x) {
	return $1;
    }
}

sub makealongerlink ($)
{
    my $ekdk_url = shift 
	or croak 'No ekdk key / URL passed to makealongerlink';
    my $ua = __PACKAGE__->ua();

    $ekdk_url =~ s{ ^\Qhttp://redir.ek.dk/\E \?? }{}x;
    $ekdk_url = "http://redir.ek.dk/$ekdk_url"
    unless $ekdk_url =~ m!^http://!i;

    my $resp = $ua->get($ekdk_url);
    return undef unless $resp->is_redirect;
    my $url = $resp->header('Location');
    return $url;

}

1;

__END__

=head1 NAME

WWW::Shorten::EkDk - Perl interface to add.redir.ek.dk

=head1 SYNOPSIS

  use WWW::Shorten::EkDk;

  use WWW::Shorten 'EkDk';

  $short_url = makeashorterlink($long_url);

  $long_url  = makealongerlink($short_url);

=head1 DESCRIPTION

A Perl interface to the web site add.redir.ek.dk. EkDk simply maintains
a database of long URLs, each of which has a unique identifier. The
website permits you to specify an email address as well, but this API
doesn't (yet).

The function C<makeashorterlink> will call the EkDk web site passing it
your long URL and will return the shorter EkDk version. Unlike many of
the other services, EkDk will return an error if the name has been
previously defined, even if it was defined with the same URL.

The function C<makealongerlink> does the reverse. C<makealongerlink>
will accept as an argument either the full EkDk URL or just the
EkDk identifier.

If anything goes wrong, then either function will return C<undef>.

=head2 EXPORT

makeashorterlink, makealongerlink

=head1 BUGS

Please report bugs at <bug-www-shorten@rt.cpan.org>
or via the web interface at L<http://rt.cpan.org>

=head1 AUTHOR

Iain Truskett <spoon@cpan.org>

Based on WWW::MakeAShorterLink by Dave Cross <dave@dave.org.uk>

=head1 SEE ALSO

L<WWW::Shorten>, L<perl>, L<http://add.redir.ek.dk/>

=cut