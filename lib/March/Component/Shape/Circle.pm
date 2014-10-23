package March::Component::Shape::Circle;
use Role::Tiny;
use Role::Tiny::With;
use Math::Shape::Circle;
use 5.020;
use feature 'signatures';
no warnings 'experimental';
use Carp;

with 'March::Attribute::Shape';

sub circle ($self, $x = undef, $y = undef, $radius = undef)
{
    unless ($self->{circle})
    {
        $self->{circle} =
            Math::Shape::Circle->new($x, $y, $radius);
    }
    $self->{circle};
}

sub shape ($self)
{
    $self->{circle};
}

1;
