use Test::More tests => 6;

BEGIN { use_ok WWW::Shorten::NotLong };

my $notlong = makeashorterlink('http://dave.org.uk/scripts/webged-1.02.tar.gz');
my $re = qr!^ \Qhttp://\E ([\w]+) \Q.notlong.com\E/? $ !x;

diag "WWW::Shorten::NotLong ".WWW::Shorten::NotLong->VERSION();

diag "notlong = $notlong";

ok ((defined $notlong and $notlong =~ $re),
    'make it shorter'
);

my $code = $1;

diag "\$code = $code";

is (
    makealongerlink($notlong),
    'http://dave.org.uk/scripts/webged-1.02.tar.gz',
    'make it longer'
);

is (
    makealongerlink($code),
    'http://dave.org.uk/scripts/webged-1.02.tar.gz',
    'make it longer by Id',
);


my ($notlong, $password) = makeashorterlink('http://books.dellah.org/');

ok ( (defined $notlong and $notlong =~ $re
	and defined $password and $password =~ m!^ [a-z]+ $ !x),
    "make it shorter, get password [$notlong, $password]"
);

#TODO: {
{
    #local $TODO = "Works, but need to generate unique code";
    $code = "spoon${code}x";
    $code = substr($code, -10);
    my ($notlong, $password) = makeashorterlink('http://books.dellah.org/', nickname => $code);

    diag "[$code => $notlong, $password]";
    ok ( ( defined $notlong and $notlong =~ $re
		and $1 eq $code
		and defined $password and $password =~ m!^ [a-z]+ $ !x),
	"make it shorter, with given code, and get password"
    );
}
