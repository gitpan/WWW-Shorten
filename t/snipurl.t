use Test::More tests => 4;

BEGIN { use_ok WWW::Shorten::SnipURL };

is (
    makeashorterlink('http://dave.org.uk/scripts/webged-1.02.tar.gz'),
    'http://snipurl.com/3ww',
    'make it shorter'
);

is (
    makealongerlink('http://snipurl.com/3ww'),
    'http://dave.org.uk/scripts/webged-1.02.tar.gz',
    'make it longer'
);

is (
    makealongerlink('3ww'),
    'http://dave.org.uk/scripts/webged-1.02.tar.gz',
    'make it longer by Id',
);
