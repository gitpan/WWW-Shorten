use Test::More tests => 5;

BEGIN { use_ok WWW::Shorten::Metamark };

my $url = 'http://dellah.org/';
my $short = makeashorterlink( $url );
ok((defined $short), 'Reasonable response');
like ( $short => qr{^http://xrl\.us/\w+$}, 'make it shorter' );

diag "Short = [$short]";
is ( makealongerlink( $short ) => $url, 'make it longer' );

my ($rs) = $short =~ m# / (\w+) $ #x;
diag "Really short = [$rs]";
is ( makealongerlink($rs) => $url, 'make it longer by Id' );
