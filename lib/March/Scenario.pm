package March::Scenario;
use 5.020;
use warnings;
use feature 'signatures';
no warnings 'experimental';

=head2 DESCRIPTION

The March::Scenario object determines the map, number of players, units assigned to each player deployment and victory conditions.

=cut

sub new ($class, $name)
{
    bless { name => $name }, $class;
}

sub name ($self)
{
    $self->{name};
}

1;
