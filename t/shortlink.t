use Test::More tests => 4;

BEGIN { use_ok WWW::Shorten::ShortLink };

my $re = qr{^ \Qhttp://shortlink.us/\E (\d+) $ }x;

diag "WWW::Shorten::ShortLink ".WWW::Shorten::ShortLink->VERSION();

{
    my $url = 'http://rubybooks.dellah.org/';
    my $code = 644;
    my $short = makeashorterlink($url);

    diag "<$url> => [$code] => <$short>";
    ok ( ( defined $short and $short =~ $re and $1 eq $code ),
	"make it shorter"
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
