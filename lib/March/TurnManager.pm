package March::TurnManager;
use feature qw/signatures/;
no warnings 'experimental';
use Carp;
use Regexp::Common;
use March::ConfigManager;
use March::Msg;

my $instance;

sub instance () { $instance }

sub new ($class, $max_turns)
{
    croak '$max_turns argument must be 0 or higher'
        unless $max_turns =~ /$RE{num}{int}/ && $max_turns >= 0;

    my $listener = March::ConfigManager->instance->create_listener;
    $listener->poll(sub { process_message($_[0]) });

    $instance = bless {
            listener           => $listener,
            turn_number        => 1,
            max_turns          => $max_turns,
        }, $class;

    $instance;
}

sub process_msg ($msg)
{
     if ($_->type eq 'March::Actor::Turn::End')
     {
        March::TurnManager->instance->next_turn;
     }
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
        March::ConfigManager->instance->publish(
            March::Msg->new('March::Actor::Game::End', 0, 'End game, max number of turns reached.')
        );

        $self->current_turn_number;
    }
    # increment turn count
    else 
    {
        $self->{turn_number}++;
        March::ConfigManager->instance->publish(
                March::Msg->new('March::Actor::Turn::New', 'Turn ' . $self->current_turn_number . ' is beginning', 0)
        );
    }
    $self->{turn_number};
}
1;
