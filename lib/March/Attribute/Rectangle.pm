package March::Attribute::Rectangle;
use Role::Tiny;
use Role::Tiny::With;
use Math::Shape::Rectangle;
use 5.020;
use feature 'signatures';
no warnings 'experimental';
use Carp;

with 'March::Attribute::Shape';

sub rectangle ($self, $origin_x = undef, $origin_y = undef, $width = undef, $height = undef)
{
    unless ($self->{rectangle})
    {
        $self->{rectangle} =
            Math::Shape::Rectangle->new($origin_x, $origin_y, $width, $height);
    }
    $self->{rectangle};
}

sub shape ($self)
{
    $self->{rectangle};
}

1;
