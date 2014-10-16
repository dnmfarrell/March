package March::Attribute::Direction;
use 5.020;
use Role::Tiny;
use feature 'signatures';
no warnings 'experimental';
use March::Game;
use March::Msg;

requires 'id';

sub direction ($self, $new_direction = 0)
{
    if ($new_direction && $new_direction->isa('Math::Shape::Vector'))
    {
        $self->{direction} = $new_direction;

        # publish direction to game queue
        March::Game->instance->publish(
            March::Msg->new(__PACKAGE__, $self->id, $new_direction)
        );
    }
    $self->{direction};
}

1;
