package WWW::Shorten::Shorl;

use 5.006;
use strict;
use warnings;

require Exporter;

our @ISA = qw(Exporter);
our @EXPORT = qw(makeashorterlink makealongerlink);
our ($VERSION) = q$Revision: 1.1 $ =~ /^ Revision: \s+ (\S+) \s+ $/x;

use LWP;
use Carp;

sub makeashorterlink
{
    my $url = shift or croak 'No URL passed to makeashorterlink';
    my $ua = shift || LWP::UserAgent->new();;
    my $shorl = 'http://shorl.com/create.php';
    my $resp = $ua->post($shorl, [ url => $url ]);
    return unless $resp->is_success;
    if ($resp->content =~ m!
	\QShorl:\E
	\s+
	<a \s+ href=" /\w+  ">
	(\Qhttp://shorl.com/\E\w+)
	</a>
	<br>
	!x) {
	return $1;
    }
}

sub makealongerlink
{
    my $shorl_url = shift 
	or croak 'No Shorl key / URL passed to makealongerlink';
    my $ua = shift || LWP::UserAgent->new(requests_redirectable => []);

    $shorl_url = "http://shorl.com/$shorl_url"
    unless $shorl_url =~ m!^http://!i;

    my $resp = $ua->get($shorl_url);

    return undef unless $resp->is_redirect;
    my $url = $resp->header('Location');
    return $url;

}

1;

__END__
# Below is stub documentation for your module. You better edit it!

=head1 NAME

WWW::Shorten::Shorl - Perl interface to shorl.com

=head1 SYNOPSIS

  use WWW::Shorten::Shorl;

  use WWW::Shorten 'Shorl';

  $short_url = makeashorterlink($long_url);

  $long_url  = makealongerlink($short_url);

=head1 DESCRIPTION

A Perl interface to the web site shorl.com.  Shorl simply maintains
a database of long URLs, each of which has a unique identifier.

The function C<makeashorterlink> will call the Shorl web site passing
it your long URL and will return the shorter Shorl version.

The function C<makealongerlink> does the reverse. C<makealongerlink>
will accept as an argument either the full Shorl URL or just the
Shorl identifier.

If anything goes wrong, then either function will return C<undef>.

Note that Shorl, unlike TinyURL and MakeAShorterLink, returns a unique code for every submission.

=head2 EXPORT

makeashorterlink, makealongerlink

=head1 TODO

=over 4

=item *

Return the password somehow.

=back


=head1 AUTHOR

Iain Truskett <spoon@cpan.org>

Based on WWW::MakeAShorteRLink by Dave Cross <dave@dave.org.uk>

=head1 SEE ALSO

L<WWW::Shorten>, L<perl>, L<http://shorl.com/>

=cut
