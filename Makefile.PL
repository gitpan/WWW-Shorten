use ExtUtils::MakeMaker;
WriteMakefile(
    NAME		=> 'WWW::Shorten',
    VERSION_FROM	=> 'lib/WWW/Shorten.pm',
    PREREQ_PM => {
		'URI' => '1.23',
		'LWP::UserAgent' => '2.003',
		'LWP' => '5.69',
		'Test::More' => '0.47',
	    },
    ($] >= 5.005 ?
      (ABSTRACT_FROM => 'lib/WWW/Shorten.pm',
      AUTHOR     => 'Iain Truskett <spoon@cpan.org>') : ()),
    ( eval($ExtUtils::MakeMaker::VERSION) >= 6.10 ?
	( NO_META => 1, ) : ()),
);
