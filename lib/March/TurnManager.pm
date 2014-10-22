package March::TurnManager;
use AnyMQ;
use feature qw/signatures/;
no warnings 'experimental';
use Carp;
use Regexp::Common
use March::Msg;

my $instance;

sub instance () { $instance }

sub new ($class, $max_turns)
{
    croak '$max_turns argument must be 0 or higher'
        unless $max_turns =~ /$RE{num}{int}/ && $max_turns >= 0;
    
    my $listener = AnyMQ->new_listener(AnyMQ->topic('March::Signal::Game'));
    $listener->poll(sub {
        March::TurnManager->instance->next_turn if $_->type eq 'March::Signal::Game::Turn::End';
    });
    
    $instance = bless {
            listener           => $listener,
            turn_number        => 1,
            max_turns          => $max_turns,
        }, $class;
    
    $instance;
}

sub current_turn_number ($self)
{
    $self->{turn_number};
}

sub next_turn ($self)
{
    # check end game
    if ($self->{max_turns} > 0 
        && $self->{max_turns} == $self->current_turn_number)
    {
        AnyMQ->topic('March::Signal::Game')->publish(
            March::Msg->new('March::Signal::Game::End', 0, 'End game, max number of turns reached.');
        );
        $self->current_turn_number;
    }
    
    # check for last turn
    elsif ($self->{max_turns} > 0 
        && $self->{max_turns} - $self->current_turn_number == 1)
    {
        AnyMQ->topic('March::Signal::Game')->publish(
            March::Msg->new('March::Signal::Game::End', 0, 'End game, max number of turns reached.');
        );
        $self->current_turn_number;
    }
    
    # increment turn count
    else 
    {
        AnyMQ->topic('March::Signal::Game')->publish(
                March::Msg->new('March::Signal::Game::Turn::New', 0, 'New turn beginning');
            );
        ++$self->{current_turn_number};
    }
}
1;