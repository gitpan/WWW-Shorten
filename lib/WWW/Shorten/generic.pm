package WWW::Shorten::generic;

use 5.006;
use strict;
use warnings;

our ($VERSION) = q$Revision: 1.1 $ =~ /^ Revision: \s+ (\S+) \s+ $/x;

use LWP;
use Carp;

my $ua;

sub ua
{
    my $self = shift;
    return $ua if defined $ua; 
    my $v = $self->VERSION();
    $ua = LWP::UserAgent->new(
	env_proxy => 1,
	timeout => 30,
	agent => "$self/$v",
	requests_redirectable => [],
    );
    return $ua;
}

1;
