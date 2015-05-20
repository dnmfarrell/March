package March::Game;
use Role::Tiny::With;
use 5.020;
use Carp;
use feature qw/signatures postderef/;
no warnings 'experimental';
use March::Logger;

with 'March::Component::MsgQueue';

sub new ($class, $entities)
{
  # setup logging
  my $logger = March::Logger->new();
  $logger->poll('March::Logger');

  my $self = bless {
    entities => [],
    logger   => $logger,
  }, $class;

  for (@$entities)
  {
    $self->add_entity($_);
  }

  return $self;
}

sub add_entity ($self, $entity)
{
  die 'add_entity() required a March::Entity object argument'
    unless $entity->isa('March::Entity');

  push $self->{entities}->@*, $entity;

  return $self;
}

sub start ($self)
{
  $self->{game_loop} = 1;

  while ($self->{game_loop} == 1)
  {
    for my $entity ($self->{entities}->@*)
    {
      $entity->update() if $entity->does('March::Component::Update');
    }
    $self->poll('March::Game');
  }

  return $self;
}

sub process_msg ($self, $msg)
{
  return $self->{game_loop} = 0;
}

1;
