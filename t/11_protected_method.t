use strict;
use warnings;

use Test::More tests => 5;
use Test::Exception;

{

    package Foo;
    use Moose;
    use MooseX::Privacy;

    protected_method 'bar' => sub {
        my $self = shift;
        return 'baz';
    };
}

{

    package Bar;
    use Moose;
    extends 'Foo';

    sub baz {
        my $self = shift;
        return $self->bar;
    }
}

my $foo = Foo->new();
isa_ok( $foo, 'Foo' );
dies_ok { $foo->bar } "... can't call bar, method is protected";

my $bar = Bar->new();
isa_ok( $bar, 'Bar' );
is $bar->baz(), 'baz', "... got the good value from &bar";

is scalar @{ $foo->meta->local_protected_methods }, 1,
    '... got one protected method';



