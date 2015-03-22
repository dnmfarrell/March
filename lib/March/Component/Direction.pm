package March::Component::Direction;
use 5.020;
use Role::Tiny;
use feature 'signatures';
no warnings 'experimental';

with qw/March::Component::Id March::Component::PostMsgQueue/;

=head2 direction()

=head2 direction($direction)

Getter / Setter method for an entities direction, which is a Math::Shape::Vector object.

=cut

sub direction ($self, $new_direction = 0)
{
    if ($new_direction && $new_direction->isa('Math::Shape::Vector'))
    {
        $self->{direction} = $new_direction;

        # publish direction to game queue
        $self->post($new_direction, $self->id);
        $self->post('March::Logger',
          sprintf "Entity %s changed direction to face $new_direction", $self->id);
    }
    $self->{direction}
}

1;
