package Wing::Role::Result::Warnings;

=head1 NAME

Wing::Role::Result::Warnings - Sometimes you want to warn your user about something, but not trigger an exception.

=head1 SYNOPSIS

 with 'Wing::Role::Result::Warnings';

 $self->add_warning(500, 'Yo mama is so fat...', {weight => 500}); # this shows up in C<describe()> output under C<_warnings>
 
=head1 METHODS

=cut

use Wing::Perl;
use Ouch;
use Moose::Role;


=head2 warnings ([warnings])

An array reference containing a list of warnings that were generated by this object on this invocation. These warnings are not persisted in the database. They will appear in the output of the C<describe()> method.

=over

=item warnings

You may optionally replace the array reference by passing one in. 

=over 

=item warning

A hash reference containing the warning.

=over

=item code

The error code for this warning.

=item message

The human readable message for this warning.

=item data

Some debugging information. Optional.

=back

=back

=back

=cut

has warnings => (
    is          => 'rw',
    default     => sub { [] },
    predicate   => 'has_warnings',
);

=head2 has_warnings() 

Returns 1 if there are some warnings.


=head2 add_warning ( code, message, [ debug ] ) 

Adds a warning to the describe output of this object. In this way, you can handle minor errors automatically and just let the user know what was done.

=over

=item code

The error code for this warning.

=item message

The human readable message for this warning.

=item data

Some debugging information. Optional.

=back

=cut

sub add_warning {
    my ($self, $code, $message, $debug) = @_;
    my $warnings = $self->warnings;
    push @{$warnings}, {
        code    => $code,
        message => $message,
        data    => $debug,
    };
    $self->warnings($warnings);
}

around describe => sub {
    my ($orig, $self, %options) = @_;
    my $out = $orig->($self, %options);
    if ($self->has_warnings) {
        if (exists $out->{_warnings}) {
            push @{$out->{_warnings}}, @{$self->warnings};
        }
        else {
            $out->{_warnings} = $self->warnings;
        }
    }
    return $out;
};

around describe_delete => sub {
    my ($orig, $self, %options) = @_;
    my $out = $orig->($self, %options);
    if ($self->has_warnings) {
        if (exists $out->{_warnings}) {
            push @{$out->{_warnings}}, @{$self->warnings};
        }
        else {
            $out->{_warnings} = $self->warnings;
        }
    }
    return $out;
};
 
1;
