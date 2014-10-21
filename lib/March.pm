use warnings;
package March;

use 5.020;
use March::Game;
use feature 'signatures';
no warnings 'experimental';

# ABSTRACT: A 2d logical game engine for turn based games written in Perl

=head2 start

Starts the game loop, updating the game every iteration.

=cut

sub start ()
{
    my $game = March::Game->instance;

    while ($game->continue)
    {
        $game->update;
    }
    $game;
}

1;
