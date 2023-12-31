package MooseX::Privacy::Trait::Role;

use MooseX::Role::Parameterized;

parameter name => ( isa => 'Str', required => 1, );

role {
    my $p         = shift;
    my $role_name = "MooseX::Privacy::Meta::Attribute::" . $p->name;

    around accessor_metaclass => sub {
        my ( $orig, $self, @rest ) = @_;

        return Moose::Meta::Class->create_anon_class(
            superclasses => [ $self->$orig(@_) ],
            roles        => [$role_name],
            cache        => 1
        )->name;
    };
};

1;
