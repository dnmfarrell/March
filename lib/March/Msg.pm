use warnings;
use strict;
package March::Msg;

use feature 'signatures';
no warnings 'experimental';

sub new ($class, $type, $actor_id, $content)
{
    bless { type     => $type,
            actor_id => $actor_id,
            content  => $content,
    }, $class;
}

1;
