package March::Phase;
use 5.020;
use Role::Tiny;
use feature 'signatures';
no warnings 'experimental';
use March::Msg;
use March::Game;

requires 'permitted_actions';

sub end ($self)
{
    March::Game->instance->publish(
        March::Msg->new(__PACKAGE__, 0, 'END')
    );
    $self;
}

1;
