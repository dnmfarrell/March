use strict;
use warnings;
package March;

use 5.020;
use AnyMQ;
use feature 'signatures';
no warnings 'experimental';
use March::Game;

# ABSTRACT: A 2d logical game engine for turn based games written in Perl

sub start ()
{
    while (March::Game->instance->continue)
    {
        March::Game->instance->update;
    }
}

1;
