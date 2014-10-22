use warnings;
package March;

use 5.020;
use Carp;
use feature 'signatures';
no warnings 'experimental';

# ABSTRACT: A 2d logical game engine for turn based games written in Perl

=head2 start

Starts the game loop, updating the game every iteration.

=cut

sub start ($game, $interface = undef, $gfx = undef, $sfx = undef)
{
    croak 'start() requires a March::Game object' unless $game->isa('March::Game');

    while ($game->continue)
    {
        $interface->update if $interface;
        $game->update;
        $gfx->update if $gfx;
        $sfx->update if $sfx;
    }
    $game;
}

1;
