#!/usr/bin/perl -w
use strict;
use Module::Build 0.14;

my $m = Module::Build->new(
    dist_name => 'WWW-Shorten',
    dist_version => '1.5.8',
    license => 'perl',

    requires => {
	'LWP::UserAgent' => 2.001,
	'LWP'            => 5.69,
	'URI'            => 1.23,
	'perl'           => '5.6.0',
    },
    build_requires => {
	'Test::More'      => 0.47,
	'Test::Signature' => 1.03,
	'Test::Pod'       => 0.95,
    },

    verbose => 1,
);

$m->create_build_script;
