package March::Unit;
use Role::Tiny::With;
use Math::Shape::Circle;
use feature 'signatures';
no warnings 'experimental';

with 'March::Action::Position';
with 'March::Action::Move';

sub new ($class, $id, $movement_allowance, $position)
{
    bless {
        id       => $id,
        move     => $movement_allowance,
        position => $position,
    }, $class;

}

sub move_allowance ($self)
{
    $self->{move};
}

sub id ($self)
{
    $self->{id};
}

1;
