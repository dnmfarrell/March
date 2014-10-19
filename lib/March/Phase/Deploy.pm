package March::Phase::Deploy;
use 5.020;
use Role::Tiny::With;
use feature 'signatures';
no warnings 'experimental';

#import end()
with 'March::Phase';

sub permitted_actions ($self)
{
    my @permitted_actions = qw/spawn/;
    \@permitted_actions;
}

1;
