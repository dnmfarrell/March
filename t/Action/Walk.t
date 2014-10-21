use strict;
use warnings;
use Test::More;
use Math::Shape::Vector;
use Test::Exception;
use March::Actor::Humanoid;
use March::Map;
use March::Phase::Deploy;

my $deploy_phase = March::Phase::Deploy->new;
my $human = bless { id => 1 }, 'March::Actor::Humanoid';
my $map = March::Map->new(1000, 1000);
my $game = March::Game->instance([$deploy_phase], [$human], $map);

# create an object
my $self = bless { position => Math::Shape::Vector->new(54, 67),
                   direction=> Math::Shape::Vector->new(1, 0),

}, 'March::Action::Walk';

# add required subs
sub March::Action::Walk::id { 20 };
sub March::Action::Walk::move_allowance { 100 };
sub March::Action::Walk::direction
{
    $_[1] ? $_[0]->{direction} = $_[1]
          : $_[0]->{direction}
};
sub March::Action::Walk::position
{
    $_[1] ? $_[0]->{position} = $_[1]
          : $_[0]->{position}
};

BEGIN { use_ok 'March::Action::Walk' }

dies_ok{ $self->walk( Math::Shape::Vector->new(1000, 100) ) } 'Dies on walk to new vector too far away';
is $self->{position}->{x}, 54, 'Has not moved';
is $self->{position}->{y}, 67, 'Has not moved';
is $self->{direction}->{x}, 1, 'Has not turned';
is $self->{direction}->{y}, 0, 'Has not turned';

is $self->walk( Math::Shape::Vector->new(54, 100) ), 33, 'Walk to new vector';
is $self->{position}->{x}, 54,  'Object is still at x 54';
is $self->{position}->{y}, 100, 'Object has moved to y 100';
is $self->{direction}->{x}, 0,  '';
is $self->{direction}->{y}, 1,  'Object is facing "north"';

done_testing();

