package March::Component::Position;
use 5.020;
use Role::Tiny;
use Role::Tiny::With;
use feature 'signatures';
no warnings 'experimental';
use March::Msg;

with 'March::Component::Id';

sub position ($self, $new_position = 0)
{
    if ($new_position && $new_position->isa('Math::Shape::Vector'))
    {
        $self->{position} = $new_position;

        # publish position to game queue
        March::ConfigManager->instance->publish(
            March::Msg->new(__PACKAGE__, $new_position, $self->id)
        );
    }
    $self->{position};
}

1;