package March::Msg;
use 5.020;
use warnings;
use feature 'signatures';
no warnings 'experimental';

sub new ($class, $type = undef, $content = undef, $actor_id = undef, $action = undef)
{
    bless { type     => $type,
            content  => $content,
            actor_id => $actor_id,
            action   => $action,
    }, $class;
}

sub type ($self)
{
    $self->{type} || '';
}

sub content ($self)
{
    $self->{content} || '';
}

sub action ($self)
{
    $self->{action} || '';
}

sub actor_id ($self)
{
    $self->{actor_id} || '';
}

1;
