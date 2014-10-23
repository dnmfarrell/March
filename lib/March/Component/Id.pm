package March::Component::Id;
use 5.020;
use Role::Tiny;
use feature 'signatures';
no warnings 'experimental';

sub id ($self, $id = 0)
{
    $id ? $self->{id} : $self->{id} = $id;
}

1;
