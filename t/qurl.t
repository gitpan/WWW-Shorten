use Test::More tests => 4;

BEGIN { use_ok WWW::Shorten::qURL };

my $url = 'http://search.cpan.org/~spoon/WWW-Yahoo-Groups-1.85/lib/WWW/Yahoo/Groups.pm';
my $code = 'g';
my $prefix = 'http://qurl.net/';

is (
    makeashorterlink($url),
    $prefix.$code,
    'make it shorter'
);

is (
    makealongerlink($prefix.$code),
    $url,
    'make it longer'
);

is (
    makealongerlink($code),
    $url,
    'make it longer by Id',
);
