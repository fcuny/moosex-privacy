package MooseX::Privacy::Meta::Class::Private;

use Moose::Role;
use MooseX::Types::Moose qw(Str ArrayRef );
use MooseX::Privacy::Meta::Method::Private;

has local_private_methods => (
    traits     => ['Array'],
    is         => 'ro',
    isa        => ArrayRef [Str],
    required   => 1,
    default    => sub { [] },
    auto_deref => 1,
    handles    => { '_push_private_method' => 'push' },
);

sub add_private_method {
    my $self = shift;
    my ( $method_name, $body );
    if ( scalar @_ == 1 ) {
        $method_name = $_[0]->name;
        $body        = $_[0]->body;
    }
    else {
        ( $method_name, $body ) = @_;
    }
    $self->add_method(
        $method_name,
        MooseX::Privacy::Meta::Method::Private->wrap(
            name         => $method_name,
            body         => $body,
            package_name => $self->name
        )
    );
    $self->_push_private_method($method_name);
}

1;
