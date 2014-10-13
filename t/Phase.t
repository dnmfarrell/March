use warnings;
use strict;
use Test::More;
no warnings 'once';

# add required method to March::Phase
*March::Phase::permitted_actions = sub { ['March::Action::Move'] };

BEGIN { use_ok 'March::Phase' }

ok my $self = March::Phase->new;

# fire out an action msg
AnyMQ->topic('March::Action')->publish({ ac => 'March::Action::Move' });

#is $self->{action_list}{'March::Action::Move'}[0], 7, 'Check phase object captured move for id #7';

done_testing();

