package MooseX::Privacy::Meta::Attribute::Private;

use Moose::Role;
use Carp qw/confess/;

with 'MooseX::Privacy::Meta::Attribute::Privacy' => {level => 'private'};

sub _check_private {
    my ($meta, $caller, $attr_name, $package_name) = @_;
    confess "Attribute " . $attr_name . " is private"
        unless $caller eq $package_name;
}

1;
