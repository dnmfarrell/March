package March::Game;
use warnings;
use strict;
use AnyMQ;
use feature 'signatures';
no warnings 'experimental';

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


=head2 publish

Publishes a L<March::Msg> object to the C<March::Game> queue.

=cut

sub publish ($self, $msg)
{
    AnyMQ->topic(__PACKAGE__)->publish($msg);
}

1;
