#!/usr/bin/perl -w
use strict;
use Module::Build 0.11;

my $m = Module::Build->new(
    dist_name => 'WWW-Shorten',
    dist_version => '1.5.1',
    license => 'perl',

    requires => {
	'LWP::UserAgent' => 2.001,
	'LWP'            => 5.65,
	'URI'            => 1.22,
	'WWW::Mechanize' => 0.31,
	'perl'		 => '5.6.0',
    },
    build_requires => {
	'Test::More'      => 0.47,
	'Test::Signature' => 1.02,
    },

    verbose => 1,
);

$m->create_build_script;
