use ExtUtils::MakeMaker;
# See lib/ExtUtils/MakeMaker.pm for details of how to influence
# the contents of the Makefile that is written.
WriteMakefile(
    'NAME'		=> 'WWW::Shorten',
    'VERSION_FROM'	=> 'lib/WWW/Shorten.pm', # finds $VERSION
    'PREREQ_PM'		=> {
	'LWP::UserAgent' => 0,
	'Test::More' => 0,
    }, # e.g., Module::Name => 1.1
    ($] >= 5.005 ?    ## Add these new keywords supported since 5.005
      ( AUTHOR     => 'Iain Truskett <spoon@cpan.org>') : ()),
);
