package WWW::Shorten::MakeAShorterLink;

use 5.006;
use strict;
use warnings;

use base qw( WWW::Shorten::generic Exporter );
our @EXPORT = qw(makeashorterlink makealongerlink);
our $VERSION = '1.31';

use Carp;

# Preloaded methods go here.
sub makeashorterlink ($)
{
  my $masl = 'http://www.makeashorterlink.com/index.php';
  my $url = shift or croak 'No URL passed to makeashorterlink';
  my $ua = __PACKAGE__->ua();

  my $resp = $ua->post($masl,
                       [ url => $url ]);

  return unless $resp->is_success;

  if ($resp->content =~ m!Your shorter link is: <a href="(.*)">!) {
    return $1;
  }
}

sub makealongerlink ($)
{
  my $masl_url = shift 
    or croak 'No MASL key / URL passed to makealongerlink';
  my $ua = __PACKAGE__->ua();

  $masl_url = "http://www.makeashorterlink.com/?$masl_url"
    unless $masl_url =~ m!^http://!i;

  my $resp = $ua->get($masl_url);

  return undef unless $resp->is_success;

  return undef 
    if $resp->content =~ m!That doesn\'t look like a Make A Shorter Link key.!;

  if ($resp->content =~ m!<meta HTTP-EQUIV="Refresh" CONTENT="5\; URL=(.*)"!i) {
    return $1;
  }
}

1;

__END__
# Below is stub documentation for your module. You better edit it!

=head1 NAME

WWW::Shorten::MakeAShorterLink - Perl interface to makeashorterlink.com

=head1 SYNOPSIS

  use WWW::Shorten::MakeAShorterLink;

  use WWW::Shorten 'MakeAShorterLink';

  $short_url = makeashorterlink($long_url);

  $long_url  = makealongerlink($short_url);

=head1 DESCRIPTION

A Perl interface to the web site makeashorterlink.com (MASL to its
friends). MASL simply maintains a database of long URLs, each of which
has a unique identifier.

The function C<makeashorterlink> will call the MASL web site passing it 
your long URL and will return the shorter MASL version.

The function C<makealongerlink> does the reverse. C<makealongerlink>
will accept as an argument either the full MASL URL or just the MASL
identifier.

If anything goes wrong, then either function will return C<undef>.

For more information, see L<WWW::Shorten>.


=head2 EXPORT

makeashorterlink, makealongerlink

=head1 BUGS

Please report bugs at <bug-www-shorten@rt.cpan.org>
or via the web interface at L<http://rt.cpan.org>

=head1 AUTHOR

Dave Cross <dave@dave.org.uk>
Subtle modifications by Iain Truskett <spoon@cpan.org>
Original LWP hacking by Alex Page <grimoire@corinne.cpio.org>
C<makealongerlink> idea by Simon Batistoni <simon@hitherto.net>

=head1 SEE ALSO

L<WWW::Shorten>, L<perl>, L<http://makeashorterlink.com/>

=cut
