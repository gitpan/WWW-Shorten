use Test::More tests => 5;

BEGIN { use_ok WWW::Shorten::Fcol };

my $url = 'http://perl.dellah.org/WWW-Shorten-1.5.2.tar.gz';
my $short = makeashorterlink( $url );
ok((defined $short), 'Reasonable response');
like ( $short => qr{http://fcol\.org/\??..}, 'make it shorter' );

diag "Short = [$short]";
is ( makealongerlink( $short ) => $url, 'make it longer' );

my ($rs) = $short =~ /\? (.*) $/x;
diag "Really short = [$rs]";
is ( makealongerlink($rs) => $url, 'make it longer by Id' );