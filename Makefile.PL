use ExtUtils::MakeMaker;
WriteMakefile(
    NAME                => 'WWW::Shorten',
    VERSION_FROM        => 'lib/WWW/Shorten.pm',
    PREREQ_PM => {
                'LWP' => '5.69',
                'LWP::Protocol::http' => '0',
                'LWP::UserAgent' => '2.003',
                'URI' => '1.25',
                'Test::More' => '0.47',
            },
    ($] >= 5.005 ?
      (ABSTRACT_FROM => '',
      AUTHOR     => 'Iain Truskett <spoon@cpan.org>') : ()),
    ( eval($ExtUtils::MakeMaker::VERSION) >= 6.10 ?
        ( NO_META => 1, ) : ()),
);
