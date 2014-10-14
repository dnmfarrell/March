package March::Game;
use warnings;
use strict;

my $instance;

sub instance
{
    $instance = $instance ? $instance : bless {}, shift;
}

sub phase {}

sub collision_check { 0 }

=head2 config

Returns a hashref of config options.

=cut

sub config { { } }

1;
