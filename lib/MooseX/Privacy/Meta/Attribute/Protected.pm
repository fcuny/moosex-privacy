package MooseX::Privacy::Meta::Attribute::Protected;

use Moose::Role;
use Carp qw/confess/;

sub _generate_accessor_method {
    my $attr         = (shift)->associated_attribute;
    my $package_name = $attr->associated_class->name;

    return sub {
        my $self   = shift;
        my $caller = ( scalar caller() );
        confess "Attribute " . $attr->name . " is protected"
            unless $caller eq $package_name || $caller->isa($package_name);
        $attr->set_value( $self, $_[0] ) if scalar(@_) == 1;
        $attr->set_value( $self, [@_] ) if scalar(@_) > 1;
        $attr->get_value($self);
    };
}

1;
