package foundation;

use strict;
no strict 'refs';
use vars qw($VERSION);
$VERSION = '0.01';


=pod

=head1 NAME

foundation - Inheritance without objects


=head1 SYNOPSIS

  package Foo;

  sub fooble { 42 }

  package Bar;

  sub mooble { 23 }

  package FooBar;
  use foundation qw(Foo Bar);

  print fooble();       # prints 42
  print moodle();       # prints 23


=head1 DESCRIPTION

Haven't drunk the OO Kool-Aid yet?  Think object-oriented has
something to do with Ayn Rand?  Do you eat Java programmers for
breakfast?

If the answer to any of those is yes, than this is the module for you!
C<foundation> adds the power of inheritance without getting into a
class-war!

Simply C<use foundation> and list which libraries symbols you wish to
"inherit".  It then sucks in all the symbols from those libraries into
the current one.

=cut

sub import {
    shift;      # toss out our classname

    my(@libraries) = @_;
    my $caller = caller;

    foreach my $library (@libraries) {
        eval "require $library";
        # only ignore "Can't locate" errors.
        die if $@ && $@ !~ /^Can't locate .*? at \(eval /; #'

        while( my($name, $stuff) = each %{$library.'::'} ) {
            *{$caller.'::'.$name} = $stuff;
        }
    }
}

=pod

=head1 BUGS

Plenty, I'm sure.  This is a quick proof-of-concept knock off.

=head1 AUTHOR

Michael G Schwern <schwern@pobox.com>

=head1 SEE ALSO

L<Sex>

=cut

1;
