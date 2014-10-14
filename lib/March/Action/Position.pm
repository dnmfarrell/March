package March::Action::Position;
use 5.020;
use Role::Tiny;
use Role::Tiny::With;
use feature 'signatures';
no warnings 'experimental';
use Carp;

with 'March::Action';

requires qw/id/;

sub position ($self, $new_position = 0)
{
    if ($new_position && $new_position->isa('Math::Shape::Vector'))
    {
        $self->{position} = $new_position;
        $self->publish_action(
            March::Msg->new(__PACKAGE__, $self->id, $new_position)
        );
    }
    $self->{position};
}

1;
