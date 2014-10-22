package March::PlayerManager;
use AnyMQ;
use feature qw/signatures postderef/;
no warnings 'experimental';
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
    
    my $listener = AnyMQ->new_listener(AnyMQ->topic('March::Signal::Game'));
    $listener->poll( sub { 
        if ($_->{type} eq 'March::Signal::Game::Player::next')
        {
            March::PlayerManager->instance->next_player;
        }
    });
    
    $instance = bless {
        current_player_idx => 0,
        players            => $players,
        listener           => $listener,
    }, $class;
    
    $instance;
}

sub players ($self)
{
    $self->{players};
}

sub next_player ($self)
{
    $self->{current_player_idx} == $self->{players}->$# 
        ? $self->{current_player_idx} = 0
        : $self->{current_player_idx}++;
}

sub current_player ($self)
{
    $self->{players}[ $self->{current_player_idx} ];
}

1;