use Test::More tests => 4;

BEGIN { use_ok WWW::Shorten, 'QuickOnes' };

is (
    makeashorterlink('http://dave.org.uk/scripts/webged-1.02.tar.gz'),
    'http://quickones.org/?271',
    'make it shorter'
);

is (
    makealongerlink('http://quickones.org/?271'),
    'http://dave.org.uk/scripts/webged-1.02.tar.gz',
    'make it longer'
);

is (
    makealongerlink('271'),
    'http://dave.org.uk/scripts/webged-1.02.tar.gz',
    'make it longer by Id',
);
