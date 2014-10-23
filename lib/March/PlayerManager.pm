package March::PlayerManager;
use Role::Tiny;
use feature qw/signatures postderef/;
no warnings 'experimental';
use March::ConfigManager;
use March::Msg;
use Carp;

my $instance;

sub instance () { $instance }

sub new ($class, $players)
{
    for ($players->@*)
    {
        croak 'non March::Actor::Player object passed to ' . __PACKAGE__
            unless $_->DOES->('March::Actor::Player');
    }

    my $listener = March::ConfigManager->instance->create_listener;
    $listener->poll(sub { process_message($_[0]) });
    
    $instance = bless {
        current_player_idx => 0,
        players            => $players,
        listener           => $listener,
    }, $class;
    
    $instance;
}

sub process_msg ($msg)
{
    if ($msg->type eq 'March::Actor::Player::Next')
    {
        March::PlayerManager->instance->next_player;
    }
}

sub players ($self)
{
    $self->{players};
}

sub next_player ($self)
{
    $self->{current_player_idx} == $self->{players}->$#*
        ? $self->{current_player_idx} = 0
        : $self->{current_player_idx}++;
}

sub current_player ($self)
{
    $self->{players}[ $self->{current_player_idx} ];
}

1;
