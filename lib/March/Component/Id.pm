package March::Component::Id;
use 5.020;
use Role::Tiny;
use feature 'signatures';
no warnings 'experimental';
use Data::UUID;

sub id ($self)
{
    unless (exists $self->{id})
    {
      $self->{id} = Data::UUID->new->create_str;
    }
    $self->{id};
}

1;
