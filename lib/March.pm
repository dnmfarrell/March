use strict;
use warnings;
package March;

use 5.020;
use March::Log;
use List::Util 'any';

# ABSTRACT: A 2d logical game engine for turn based games written in Perl


sub start ()
{
    # configuration
    my $log = March::Log->instance();
	$log->msg_print('Starting up');

    # begin game loop
    while (1)
    {
        $log
        last if $log->msg_exists('Game::End');
    }
	$log->msg_print('Game ending');
	
	$log->msg_print('Shutting down');
}

1;

=head2 DESCRIPTION

This is an experiment - a 2d logical game engine for turn based games written in Perl

=cut
__END__
game_prep
turns, phases, actor actions
game_cleanup