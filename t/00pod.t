use strict;
use warnings;
use vars qw( @files );

BEGIN {
    @files = qw(
	Shorten.pm
	Shorten/EkDk.pm
	Shorten/Fcol.pm
	Shorten/MakeAShorterLink.pm
	Shorten/NotLong.pm
	Shorten/QuickOnes.pm
	Shorten/Shorl.pm
	Shorten/SmLnk.pm
	Shorten/SnipURL.pm
	Shorten/TinyURL.pm
	Shorten/generic.pm
	Shorten/Metamark.pm
	Shorten/TinyClick.pm
    );
}
use Test::More tests => scalar @files;
use Test::Pod;

chdir(-d "lib/WWW" ? "lib/WWW" : "../lib/WWW");

pod_file_ok( $_, "Valid POD file: $_" ) for @files;
