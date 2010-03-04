use strict;
use warnings;

use Test::More tests => 5;
use Test::Exception;

{

    package Foo;
    use Moose;
    use MooseX::Privacy;

    has foo => ( is => 'rw', isa => 'Str', traits => [qw/Private/] );
    sub bar { my $self = shift; $self->foo('bar'); $self->foo }
}

ok my $foo = Foo->new();

dies_ok { $foo->foo };
ok $foo->bar;
is scalar @{ $foo->meta->local_private_attributes }, 1;

{

    package Bar;
    use Moose;
    has bar => ( is => 'rw', isa => 'Str', traits => [qw/Private/] );
}

ok my $bar = Bar->new();



