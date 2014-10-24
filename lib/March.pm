use warnings;
package March;

use 5.020;
use Carp;
use feature 'signatures';
no warnings 'experimental';
use March::Manager;
use March::Msg;
use AnyMQ;

# ABSTRACT: A 2d logical game engine for turn based games written in Perl

=head2 start

Starts the game loop, updating the game every iteration.

=cut

sub start ()
{
    my $pid;

    for (0..1)
    {
        $pid = fork;
        unless ($pid)
        {
            my $mgr = March::Manager->new;
            $mgr->start;
            exit(0);
        }
        else 
        {
            last;
        }
    }
    if ($pid)
    {
        sleep(5);
        say "Parent publishing messages";
        AnyMQ->topic('March::Message::Queue')->publish(March::Msg->new('March::Game::Start', 'Start game'));
        AnyMQ->topic('March::Message::Queue')->publish(March::Msg->new('March::Game::Middle', 'Mid game'));
        AnyMQ->topic('March::Message::Queue')->publish(March::Msg->new('March::Game::End', 'End game'));
        say "Parent finished publishing messages";
        waitpid($pid, 0);
    }
    say 'Parent shutting down';
}

1;
