use Test::More tests => 4;

BEGIN { use_ok WWW::Shorten, 'TinyURL' };

is (
    makeashorterlink('http://dave.org.uk/scripts/webged-1.02.tar.gz'),
    'http://tinyurl.com/17kb',
    'make it shorter'
);

is (
    makealongerlink('http://tinyurl.com/17kb'),
    'http://dave.org.uk/scripts/webged-1.02.tar.gz',
    'make it longer'
);

is (
    makealongerlink('17kb'),
    'http://dave.org.uk/scripts/webged-1.02.tar.gz',
    'make it longer by Id',
);
