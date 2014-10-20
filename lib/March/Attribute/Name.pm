package March::Attribute::Name;
use 5.020;
use Role::Tiny;
use feature 'signatures';
no warnings 'experimental';
use Regexp::Common 'profanity';
use Carp;

sub name ($self, $name = 0)
{
    if ($name)
    {
        croak "$name is profane" if $name =~ /$RE{profanity}/;
        $self->{name} = $name;
    }
    $self->{name};
}

1;
