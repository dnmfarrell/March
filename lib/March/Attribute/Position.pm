package March::Attribute::Position;
use 5.020;
use Role::Tiny;
use feature 'signatures';
no warnings 'experimental';
use March::Game;

requires 'id';

sub position ($self, $new_position = 0)
{
    if ($new_position && $new_position->isa('Math::Shape::Vector'))
    {
        $self->{position} = $new_position;

        # publish position to game queue
        March::Game->publish(
            March::Msg->new(__PACKAGE__, $self->id, $new_position)
        );
    }
    $self->{position};
}

1;
