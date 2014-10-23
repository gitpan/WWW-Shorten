package WWW::Shorten::SmLnk;
our $VERSION = sprintf "%d.%02d", '$Revision: 1.89 $ ' =~ /(\d+)\.(\d+)/;
require WWW::Shorten::_dead;

0;

__END__

=head1 NAME

WWW::Shorten::SmLnk - Perl interface to SmLnk.com

=head1 SYNOPSIS

    # No appropriate synopsis

=head1 DESCRIPTION

A Perl interface to the web service SmLnk.com. 

Unfortunately, this service became inactive at some point between 1.88
and 1.91, so this module will merely give you an error if you try to use
it. Feel free to pick a different L<service|WWW::Shorten>.

=head1 SUPPORT, LICENCE, THANKS and SUCH

See the main L<WWW::Shorten> docs.

=head1 AUTHOR

Dave Cross <dave@dave.org.uk> (previously Iain Truskett <spoon@cpan.org>)

=head1 SEE ALSO

L<WWW::Shorten>, L<perl>, L<http://smlnk.com/>

=cut
