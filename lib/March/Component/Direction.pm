package March::Component::Direction;
use 5.020;
use Role::Tiny;
use feature 'signatures';
no warnings 'experimental';
use March::ConfigManager;
use March::Msg;

with 'March::Component::Id';

sub direction ($self, $new_direction = 0)
{
    if ($new_direction && $new_direction->isa('Math::Shape::Vector'))
    {
        $self->{direction} = $new_direction;

        # publish direction to game queue
        March::ConfigManager->instance->publish(
            March::Msg->new(__PACKAGE__, $new_direction, $self->id)
        );
    }
    $self->{direction}
}

1;
