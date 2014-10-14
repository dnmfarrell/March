package March::Attribute::Id;
use 5.020;
use Role::Tiny;
use feature 'signatures';
no warnings 'experimental';

sub id ($self)
{
    $self->{id};
}

1;
