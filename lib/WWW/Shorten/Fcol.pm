package WWW::Shorten::Fcol;

use 5.006;
use strict;
use warnings;

use base qw( WWW::Shorten::generic Exporter );
our @EXPORT = qw(makeashorterlink makealongerlink);
our $VERSION = '1.22';

use Carp;
use URI;

sub makeashorterlink ($)
{
    my $url = shift or croak 'No URL passed to makeashorterlink';
    my $ua = __PACKAGE__->ua();
    my $uri = URI->new('http://fcol.org/add');
    $uri->query_form(
	url => $url,
	life => 7,
    );
    my $resp  = $ua->get( $uri );
    return unless $resp->is_success;
    if ($resp->content =~ m!
	(\Qhttp://fcol.org/?\E\w+)
	!x) {
	return $1;
    }
    return;
}

sub makealongerlink ($)
{
    my $fcol_url = shift 
	or croak 'No FCOL key / URL passed to makealongerlink';
    my $ua = __PACKAGE__->ua();

    $fcol_url =~ s{ ^\Qhttp://fcol.org/\E \?? }{}x;
    $fcol_url = "http://fcol.org/$fcol_url"
    unless $fcol_url =~ m!^http://!i;

    my $resp = $ua->get($fcol_url);
    return undef unless $resp->is_redirect;
    my $url = $resp->header('Location');
    return $url;

}

1;

__END__

=head1 NAME

WWW::Shorten::Fcol - Perl interface to fcol.org

=head1 SYNOPSIS

  use WWW::Shorten::Fcol;

  use WWW::Shorten 'Fcol';

  $short_url = makeashorterlink($long_url);

  $long_url  = makealongerlink($short_url);

=head1 DESCRIPTION

A Perl interface to the web site fcol.org.  Fcol simply maintains
a database of long URLs, each of which has a unique identifier.
Fcol will expire unused URLs after a configurable period. This module
just sets the expiry to 7 days.

The function C<makeashorterlink> will call the Fcol web site passing it
your long URL and will return the shorter Fcol version.

The function C<makealongerlink> does the reverse. C<makealongerlink>
will accept as an argument either the full Fcol URL or just the
Fcol identifier.

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

L<WWW::Shorten>, L<perl>, L<http://fcol.org/>

=cut
