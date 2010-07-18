package MooseX::Privacy::Meta::Attribute::Protected;

use Moose::Role;
use Carp qw/confess/;

with 'MooseX::Privacy::Meta::Attribute::Privacy' => {level => 'protected'};

sub _check_protected {
    my ($meta, $caller, $attr_name, $package_name, $object_name) = @_;
    confess "Attribute " . $attr_name . " is protected"
      unless $caller eq $object_name
          or $caller->isa($package_name);
}

1;
