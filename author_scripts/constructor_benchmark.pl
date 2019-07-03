#!/usr/bin/env perl

use strict;
use warnings;

printf STDOUT 'perl: %s, Class::XSAccessor: %s%s', $], Class::XSAccessor->VERSION, $/;

package WithClassXSAccessor;

use blib;

use Class::XSAccessor {
    constructor => 'new',
};

package WithStdClass;

sub new { my $c = shift; bless {@_}, ref($c) || $c }

package main;

use Dumbbench;
#use Dumbbench::BoxPlot;

my $bench = Dumbbench->new(
  target_rel_precision => 0.0005, # seek ~0.5%
  initial_runs         => 3000,    # the higher the more reliable
);
print "Constructor benchmark:", $/;

$bench->add_instances(
    Dumbbench::Instance::PerlSub->new(name => 'class_xs_accessor', code => sub {
        my $obj;
        $obj = WithClassXSAccessor->new();
        $obj = WithClassXSAccessor->new();
        $obj = WithClassXSAccessor->new();
        $obj = WithClassXSAccessor->new();
        $obj = WithClassXSAccessor->new();
        $obj = WithClassXSAccessor->new();
        $obj = WithClassXSAccessor->new();
        $obj = WithClassXSAccessor->new();
        $obj = WithClassXSAccessor->new();
        $obj = WithClassXSAccessor->new();
    }),
    Dumbbench::Instance::PerlSub->new(name => 'std_class', code => sub {
        my $obj;
        $obj = WithStdClass->new();
        $obj = WithStdClass->new();
        $obj = WithStdClass->new();
        $obj = WithStdClass->new();
        $obj = WithStdClass->new();
        $obj = WithStdClass->new();
        $obj = WithStdClass->new();
        $obj = WithStdClass->new();
        $obj = WithStdClass->new();
        $obj = WithStdClass->new();
    }),
    Dumbbench::Instance::PerlSub->new(name => 'class_xs_accessor_args', code => sub {
        my $obj;
        $obj = WithClassXSAccessor->new(foo => 'bar', baz => 'quux');
        $obj = WithClassXSAccessor->new(foo => 'bar', baz => 'quux');
        $obj = WithClassXSAccessor->new(foo => 'bar', baz => 'quux');
        $obj = WithClassXSAccessor->new(foo => 'bar', baz => 'quux');
        $obj = WithClassXSAccessor->new(foo => 'bar', baz => 'quux');
        $obj = WithClassXSAccessor->new(foo => 'bar', baz => 'quux');
        $obj = WithClassXSAccessor->new(foo => 'bar', baz => 'quux');
        $obj = WithClassXSAccessor->new(foo => 'bar', baz => 'quux');
        $obj = WithClassXSAccessor->new(foo => 'bar', baz => 'quux');
        $obj = WithClassXSAccessor->new(foo => 'bar', baz => 'quux');
    }),
    Dumbbench::Instance::PerlSub->new(name => 'std_class_args', code => sub {
        my $obj;
        $obj = WithStdClass->new(foo => 'bar', baz => 'quux');
        $obj = WithStdClass->new(foo => 'bar', baz => 'quux');
        $obj = WithStdClass->new(foo => 'bar', baz => 'quux');
        $obj = WithStdClass->new(foo => 'bar', baz => 'quux');
        $obj = WithStdClass->new(foo => 'bar', baz => 'quux');
        $obj = WithStdClass->new(foo => 'bar', baz => 'quux');
        $obj = WithStdClass->new(foo => 'bar', baz => 'quux');
        $obj = WithStdClass->new(foo => 'bar', baz => 'quux');
        $obj = WithStdClass->new(foo => 'bar', baz => 'quux');
        $obj = WithStdClass->new(foo => 'bar', baz => 'quux');
    }),
);

$bench->run;
$bench->report;
