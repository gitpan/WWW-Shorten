use Test::More tests => 4;

BEGIN { use_ok WWW::Shorten::EkDk };

my $re = qr{^ \Qhttp://redir\E(?:ect)\Q.ek.dk/\E (.*) $ }x;

diag "WWW::Shorten::EkDk ".WWW::Shorten::EkDk->VERSION();

{
    my $code = "spoon$$".time;
    my $url = 'http://books.dellah.org/';
    my $short = makeashorterlink($url => $code );

    diag "[$code] => <$short>";
    ok ( ( defined $short and $short =~ $re
		and $1 eq $code ),
	"make it shorter, with given code"
    );

    {
	my $out = makealongerlink( $short );
	is $out => $url, "makealongerlink (from full url)";
    }
    {
	my $out = makealongerlink( $code );
	is $out => $url, "makealongerlink (from code)";
    }
}
