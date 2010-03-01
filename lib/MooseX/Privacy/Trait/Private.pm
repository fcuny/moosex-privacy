package MooseX::Privacy::Trait::Private;

use Moose::Role;

around accessor_metaclass => sub {
    my ( $orig, $self, @rest ) = @_;

    return Moose::Meta::Class->create_anon_class(
        superclasses => [ $self->$orig(@_) ],
        roles        => ['MooseX::Privacy::Meta::Attribute::Private'],
        cache        => 1
    )->name;
};

1;
