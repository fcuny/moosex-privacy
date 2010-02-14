package MooseX::Privacy::Meta::Method::Protected;

use Moose;
extends 'Moose::Meta::Method';

use Carp;

sub wrap {
    my $class = shift;
    my %args  = @_;

    my $method         = delete $args{body};
    my $protected_code = sub {
        my $caller = caller();
        croak "The "
            . $args{package_name} . "::"
            . $args{name}
            . " name method is private"
            unless $caller eq $args{package_name}
                || $caller->isa( $args{package_name} );

        goto &{$method};
    };
    $args{body} = $protected_code;
    $class->SUPER::wrap(%args);
}

1;

