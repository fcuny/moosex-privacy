use strict;
use warnings;

use Test::More tests => 5;
use Test::Exception;

{

    package Foo;
    use Moose;
    use MooseX::Privacy;

    has foo => (
        is      => 'rw',
        isa     => 'Str',
        traits  => [qw/Protected/],
        default => 'foo'
    );
}

{

    package Bar;
    use Moose;
    extends 'Foo';

    sub bar { (shift)->foo };
}

ok my $foo = Foo->new();
dies_ok { $foo->foo };
is scalar @{ $foo->meta->local_protected_attributes }, 1;

ok my $bar = Bar->new();
ok $bar->bar();





