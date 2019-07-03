#!/usr/bin/env perl

use strict;
use warnings;

printf STDOUT 'perl: %s, Class::XSAccessor: %s%s', $], Class::XSAccessor->VERSION, $/;
print STDOUT "Benchmarking accessors\n";

package WithClassXSAccessor;

use blib;

use Class::XSAccessor {
    constructor => 'new',
    accessors => ['foo']
};

package WithStdClass;

sub new { my $c = shift; bless {@_}, ref($c) || $c }
sub foo {
    my ($self, $arg) = @_;

    if (scalar @_ > 1) {
        $self->{'foo'} = $arg;
    }

    return $self->{'foo'};
}

package main;

use Dumbbench;
#use Dumbbench::BoxPlot;

my $bench = Dumbbench->new(
  target_rel_precision => 0.00005, # seek ~0.5%
  initial_runs         => 2000,    # the higher the more reliable
);

$bench->add_instances(
    Dumbbench::Instance::PerlSub->new(name => 'XSAccessor', code => sub {
        my $obj;
        $obj = WithClassXSAccessor->new();
        bench_accessor($obj);
    }),
    Dumbbench::Instance::PerlSub->new(name => 'Pure Perl', code => sub {
        my $obj;
        $obj = WithStdClass->new();
        bench_accessor($obj);
    }),
);

$bench->run;
$bench->report;
#$bench->box_plot->show;

sub bench_accessor {
    my $o = shift;
    $o->foo(1);
    for(1..100) {
        if($o->foo) {
            $o->foo($_);
        }
    }
}
