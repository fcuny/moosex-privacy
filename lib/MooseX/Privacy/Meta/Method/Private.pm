package MooseX::Privacy::Meta::Method::Private;

use Moose;
extends 'Moose::Meta::Method';

use Carp;

sub wrap {
    my $class = shift;
    my %args  = @_;

    my $method       = delete $args{body};
    my $private_code = sub {
        croak "The "
            . $args{package_name} . "::"
            . $args{name}
            . " method is private"
            unless ( scalar caller() ) eq $args{package_name};

        goto &{$method};
    };
    $args{body} = $private_code;
    $class->SUPER::wrap(%args);
}

1;
