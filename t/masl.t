use Test::More tests => 4;

BEGIN { use_ok WWW::Shorten::MakeAShorterLink };

is (
    makeashorterlink('http://dave.org.uk/scripts/webged-1.02.tar.gz'),
    'http://makeashorterlink.com/?M328231A1',
    'make it shorter'
);

is (
    makealongerlink('http://makeashorterlink.com/?M328231A1'),
    'http://dave.org.uk/scripts/webged-1.02.tar.gz',
    'make it longer'
);

is (
    makealongerlink('M328231A1'),
    'http://dave.org.uk/scripts/webged-1.02.tar.gz',
    'make it longer by Id',
);
