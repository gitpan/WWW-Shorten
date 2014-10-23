# $Id: _dead.pm,v 1.91 2005/09/03 15:24:15 dave Exp $
package WWW::Shorten::_dead;

use strict;
use warnings;

our $VERSION = sprintf "%d.%02d", '$Revision: 1.91 $ ' =~ /(\d+)\.(\d+)/;
die <<'EOF';

This WWW::Shorten service is inactive.
Please use a different one.

EOF

1;

=head1 NAME

WWW::Shorten::_dead - Where dead link-shortening services got

=head1 SYNOPSIS

  # No appropriate synopsis

=head1 DESCRIPTION

This is just a module that we use for link-shortening services that
we used to support but which no longer exist.
