package MooseX::Privacy::Meta::Class;

use Moose::Role;
use Moose::Meta::Class;

with qw/MooseX::Privacy::Meta::Class::Private
    MooseX::Privacy::Meta::Class::Protected/;

sub _build_meta_class {
    my $self = shift;
    return Moose::Meta::Class->create_anon_class(
        superclasses => [ $self->method_metaclass ],
        cache        => 1,
    );
}

1;
