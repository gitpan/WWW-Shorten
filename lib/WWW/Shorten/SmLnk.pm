package WWW::Shorten::SmLnk;

use 5.006;
use strict;
use warnings;

use base qw( WWW::Shorten::generic Exporter );
our @EXPORT = qw(makeashorterlink makealongerlink);
our $VERSION = "1.81";

use Carp;

sub makeashorterlink ($;%)
{
    my $url = shift or croak 'No URL passed to makeashorterlink';
    my $ua = __PACKAGE__->ua();
    my ($nick,$pass) = @_;
    my $smlnk = 'http://www.smlnk.com/index.php';
    my $resp = $ua->post($smlnk, [
	'url000' => $url,
	]);
    return unless $resp->is_success;
    if ($resp->content =~ m!
	<a \s+ href=['"] ([^'"]+)  ['"][^>]*>
	(\Qhttp://smlnk.com/?\E\w+)
	</a>
	!x) {
	return $1;
    }
    return;
}

sub makealongerlink ($)
{
    my $smlnk_url = shift 
	or croak 'No SmLnk key / URL passed to makealongerlink';
    my $ua = __PACKAGE__->ua();

    $smlnk_url = "http://smlnk.com/?$smlnk_url"
    unless $smlnk_url =~ m!^http://!i;

    my $resp = $ua->get($smlnk_url);

    if ( my $refresh = $resp->header('Refresh') )
    {
	return $1 if $refresh =~ m/; URL=(.*)$/;
    }
    return undef;

}

1;

__END__
# Below is stub documentation for your module. You better edit it!

=head1 NAME

WWW::Shorten::SmLnk - Perl interface to SmLnk.com

=head1 SYNOPSIS

  use WWW::Shorten::SmLnk;

  use WWW::Shorten 'SmLnk';

  $short_url = makeashorterlink($long_url);

  $long_url  = makealongerlink($short_url);

=head1 DESCRIPTION

A Perl interface to the web service SmLnk.com. SmLnk maintains a
database of long URLs, each of which has a unique identifier or
nickname.

The function C<makeashorterlink> will call the SmLnk web site passing it
your long URL and will return the shorter SmLnk version.

The function C<makealongerlink> does the reverse. C<makealongerlink>
will accept as an argument either the full SmLnk URL or just the SmLnk
identifier.

If anything goes wrong, then either function will return C<undef>.

=head2 EXPORT

makeashorterlink, makealongerlink

=head1 BUGS, REQUESTS, COMMENTS

Please report any requests, suggestions or bugs via the system at
L<http://rt.cpan.org/>, or email E<lt>bug-WWW-Shorten@rt.cpan.orgE<gt>.
This makes it much easier for me to track things and thus means
your problem is less likely to be neglected.

=head1 THANKS

Jon and William (jon and wjr at smlnk.com respectively) for providing
SmLnk.com.

=head1 AUTHOR

Iain Truskett <spoon@cpan.org>

Based on WWW::MakeAShorterLink by Dave Cross <dave@dave.org.uk>

=head1 SEE ALSO

L<WWW::Shorten>, L<perl>, L<http://smlnk.com/>

=cut
