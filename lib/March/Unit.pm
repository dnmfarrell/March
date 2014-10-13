package March::Unit;
use Role::Tiny::With;
use Math::Shape::Circle;
use feature 'signatures';
no warnings 'experimental';

with 'March::Action::Move';

sub new ($class, $id, $movement_allowance, $shape)
{
    bless {
        id    => $id,
        move  => $movement_allowance,
        shape => $shape,
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

sub shape ($self, $shape=0)
{
    $self->{shape} = $shape if $shape;
    $self->{shape};
}

1;
