package March;

use 5.020;
use warnings;

# ABSTRACT: This is an experiment - a 2d game engine, for turn based games written in Perl using the Entity-Component pattern.

1;
__END__
use Carp;
use feature 'signatures';
no warnings 'experimental';
use March::Manager;
use March::Msg;
use AnyMQ;

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
