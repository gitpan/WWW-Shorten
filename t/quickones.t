use Test::More tests => 4;

BEGIN { use_ok WWW::Shorten::QuickOnes };

my $url = 'http://perl.dellah.org/WWW-Shorten-1.5.2.tar.gz';
my $code = '319';
my $prefix = 'http://quickones.org/?';

is ( makeashorterlink($url), $prefix.$code, 'make it shorter');
is ( makealongerlink($prefix.$code), $url, 'make it longer');
is ( makealongerlink($code), $url, 'make it longer by Id',);
