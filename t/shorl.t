use Test::More tests => 5;

BEGIN { use_ok WWW::Shorten::Shorl };

my $shorl = makeashorterlink('http://dave.org.uk/scripts/webged-1.02.tar.gz');

ok ( defined $shorl and $shorl =~ m!^ \Qhttp://shorl.com/\E ([a-z]+) $ !x,
    'make it shorter'
);

my $code = $1;

is (
    makealongerlink($shorl),
    'http://dave.org.uk/scripts/webged-1.02.tar.gz',
    'make it longer'
);

is (
    makealongerlink($code),
    'http://dave.org.uk/scripts/webged-1.02.tar.gz',
    'make it longer by Id',
);


my ($shorl, $password) = makeashorterlink('http://ouroboros.anu.edu.au/books/');

ok ( (defined $shorl and $shorl =~ m!^ \Qhttp://shorl.com/\E ([a-z]+) $ !x
	and defined $password and $password =~ m!^ [a-z]+ $ !x),
    "make it shorter, get password [$shorl, $password]"
);

