package March::GFX;
use 5.020;
use warnings;
use AnyMQ;
use Role::Tiny;
use feature qw/signatures postderef/;
no warnings 'experimental';

requires qw/draw/;

$instance;

sub new ($class)
{ 
    my $game_channel = AnyMQ->new_listener(AnyMQ->topic('March::Signal::Game'));
    $game_channel->poll(sub { process_signal($_[0]) });
    
    my $order_channel = AnyMQ->new_listener(AnyMQ->topic('March::Signal::Order'));
    $order_channel->poll(sub { process_signal($_[0]) });
    
    my $actor_channel = AnyMQ->new_listener(AnyMQ->topic('March::Signal::Actor'));
    $actor_channel->poll(sub { process_signal($_[0]) });
    
    $instance = bless { 
        game_channel  => $game_channel,
        order_channel => $order_channel,
        actor_channel => $actor_channel,
        signals       => [],
    }, $class;
}

sub instance () { $instance }

sub process_signal ($signal){ push March::SFX->instance->{signals}->@*, $signal }

=head2 update

Loops through every signal received and calls play_sound() method passing the signal as an argument.

=cut

sub update ($self)
{
    for ($self->{signals}->@*)
    {
        $self->draw($_);
    }
    $self->{signals} = [];
}

1;