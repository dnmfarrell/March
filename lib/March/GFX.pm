package March::GFX;
use 5.020;
use warnings;
use Role::Tiny;
use feature qw/signatures postderef/;
no warnings 'experimental';
use March::ConfigManager;
use March::Game;

requires qw/draw/;

$instance;

sub new ($class)
{ 
    my $listener = March::ConfigManager->instance->create_listener;
    $listener->poll(sub { process_message($_[0]) });
    
    $instance = bless { 
        listener  => $listener,
        messages  => [],
    }, $class;
}

sub instance () { $instance }

sub process_message ($message){ push March::SFX->instance->{messages}->@*, $message }

=head2 update

Loops through every message received and calls draw() method passing the message as an argument.

=cut

sub update ($self)
{
    for ($self->{messages}->@*)
    {
        $self->draw($_);
    }
    $self->{messages} = [];
}

1;