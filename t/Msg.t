use warnings;
use strict;
use Test::More;
use Test::Exception;

BEGIN { use_ok 'March::Msg' }

ok my $msg = March::Msg->new('test', 999, 'A test msg'), 'Constructor';
is $msg->{type}, 'test';
is $msg->{actor_id}, 999;
is $msg->{content}, 'A test msg';

dies_ok { March::Msg->new('test', 999, 'A test msg', 100) } 'dies on too many args';
dies_ok { March::Msg->new('test', 999) } 'dies on too few args';

done_testing();
