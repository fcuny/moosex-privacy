package MooseX::Privacy::Meta::Class;

use Moose::Role;
use Moose::Meta::Class;

with qw/MooseX::Privacy::Meta::Class::Private
    MooseX::Privacy::Meta::Class::Protected/;

1;
