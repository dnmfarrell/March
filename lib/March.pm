use strict;
use warnings;
package March;

use 5.020;
use March::Log;

# ABSTRACT: A 2d web game engine, for turn based games written in Perl

sub start ()
{
    # configuration
    March::Log->instance()->log_msg('Starting up');

    # begin game loop
    while (1)
    {
        # Process input
        # Logical engine
        # Render, SFX
        last;
    }
    March::Log->instance()->log_msg('Shutting down');
}

1;

=head2 DESCRIPTION

This is an experiment - a 2d web game engine, for turn based games written in Perl

=cut

