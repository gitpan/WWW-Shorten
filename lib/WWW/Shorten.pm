package WWW::Shorten;

use 5.006;
use strict;
no strict 'refs';
use warnings;

use base qw( WWW::Shorten::generic );
our @EXPORT = qw(makeashorterlink makealongerlink);
our ($VERSION) = q$Revision: 1.7 $ =~ /^ Revision: \s+ (\S+) \s+ $/x;

use Carp;

my $style;

sub import
{
    my $class = shift;
    $style = shift;
    $style ||= 'MakeAShorterLink';
    eval {
	my $package = "${class}::${style}";
	$package =~ s/::/\//g;
	require "$package.pm";
    };
    die $@ if $@;
    my ($package) = caller;
    my @fns = @_ ? @_ : @EXPORT;
    foreach my $fn (@fns)
    {
	*{"${package}::${fn}"} = *{$fn};
    }
}

# Preloaded methods go here.
sub makeashorterlink ($;@)
{
    my $url = shift or croak 'No URL passed to makeashorterlink';
    return "WWW::Shorten::${style}::makeashorterlink"->($url, @_);
}

sub makealongerlink ($) {
    my $code = shift 
	or croak 'No key / URL passed to makealongerlink';
    return "WWW::Shorten::${style}::makealongerlink"->($code);
}

1;

__END__
# Below is stub documentation for your module. You better edit it!

=head1 NAME

WWW::Shorten - Abstract interface to URL shortening sites.

=head1 SYNOPSIS

  use WWW::Shorten 'MakeAShorterLink';
  use WWW::Shorten 'NotLong';
  use WWW::Shorten 'QuickOnes';
  use WWW::Shorten 'Shorl';
  use WWW::Shorten 'SnipURL';
  use WWW::Shorten 'TinyURL';

  # Individual modules have have their
  # own syntactic varations.

  # See the documentation for the particular
  # module you intend to use for details, trips
  # and traps.

  $short_url = makeashorterlink($long_url);

  $long_url  = makealongerlink($short_url);

=head1 ABSTRACT

A Perl interface to URL shortening sites. These sites maintain
databases of long URLs, each of which has a unique identifier.

=head1 DESCRIPTION

The function C<makeashorterlink> will call the relevant web site
passing it your long URL and will return the shorter version.

The function C<makealongerlink> does the reverse. C<makealongerlink>
will accept as an argument either the full shortened URL or just the
identifier.

If anything goes wrong, then either function will return C<undef>.

=head2 EXPORT

makeashorterlink, makealongerlink

=head1 THANKS

Dave Cross for L<WWW::MakeAShorterLink>

Alex Page for the original LWP hackig on which Dave based his code.

Simon Batistoni for giving the C<makealongerlink> idea to Dave.

Eric Hammond for writing the NotLong variant.

Shashank Tripathi for providing both SnipURL.com and advice on the
module.

Kevin Gilbertson (Gilby) supplied information on the TinyURL API interface.

=head1 BUGS

Please report bugs at <bug-www-shorten@rt.cpan.org>
or via the web interface at L<http://rt.cpan.org>

=head1 LICENSE AND COPYRIGHT

Copyright E<copy> Iain Truskett, 2002. All rights reserved.

This library is free software; you can redistribute it and/or modify
it under the same terms as Perl itself.

=head1 AUTHOR

Iain Truskett <spoon@cpan.org>

Based on WWW::MakeAShorterLink by Dave Cross <dave@dave.org.uk>

=head1 SEE ALSO

L<perl>

=cut
