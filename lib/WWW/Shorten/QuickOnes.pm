package WWW::Shorten::QuickOnes;

use 5.006;
use strict;
use warnings;

use base qw( WWW::Shorten::generic Exporter );
our @EXPORT = qw(makeashorterlink makealongerlink);
our $VERSION = '1.13';

use Carp;

sub makeashorterlink ($)
{
    my $url = shift or croak 'No URL passed to makeashorterlink';
    $url = "http://$url" unless $url =~ m! ^http:// !x;
    my $ua = __PACKAGE__->ua();
    my $quickones = 'http://quickones.org/n.php';
    my $resp = $ua->post($quickones, [ url => $url, ]);
    return unless $resp->is_success;
    if ($resp->content =~ m!
	# <br><br><a href=http://quickones.org/?270>http://quickones.org/?270</a>
	<a \s+ href=[^>]*>
	(\Qhttp://quickones.org/?\E\w+)
	</a>
	!x) {
	return $1;
    }
    return;
}

sub makealongerlink ($)
{
    my $quickones_url = shift 
	or croak 'No QuickOnes key / URL passed to makealongerlink';
    my $ua = __PACKAGE__->ua();

    $quickones_url = "http://quickones.org/?$quickones_url"
    unless $quickones_url =~ m!^http://!i;

    my $resp = $ua->get($quickones_url);

    return undef unless $resp->is_success;
    # Refresh: 5; URL=http://dave.org.uk/scripts/webged-1.02.tar.gz
    my $url = $resp->header('Refresh');
    $url =~ s/^.*?; URL=//;
    return $url;

}

1;

__END__

=head1 NAME

WWW::Shorten::QuickOnes - Perl interface to quickones.org

=head1 SYNOPSIS

  use WWW::Shorten::QuickOnes;

  use WWW::Shorten 'QuickOnes';

  $short_url = makeashorterlink($long_url);

  $long_url  = makealongerlink($short_url);

=head1 DESCRIPTION

A Perl interface to the web site quickones.org.  QuickOnes simply maintains
a database of long URLs, each of which has a unique identifier.

The function C<makeashorterlink> will call the QuickOnes web site passing it
your long URL and will return the shorter QuickOnes version.

The function C<makealongerlink> does the reverse. C<makealongerlink>
will accept as an argument either the full QuickOnes URL or just the
QuickOnes identifier.

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

Based on WWW::MakeAShorterLink by Dave Cross <dave@dave.org.uk>

=head1 SEE ALSO

L<WWW::Shorten>, L<perl>, L<http://quickones.org/>

=cut
