package Chart::OFC2::Axis;

=head1 NAME

Chart::OFC2::Axis - OFC2 axis base module

=head1 SYNOPSIS

    use Chart::OFC2::Axis;
    my $x_axis = Chart::OFC2::XAxis->new(
        'labels' => [ 'Jan', 'Feb', 'Mar', 'Apr', 'May' ],
    ),

=head1 DESCRIPTION

X or Y axis for OFC2.

=cut

use Moose;
use Moose::Util::TypeConstraints;

our $VERSION = '0.01';

use Chart::OFC2;
use Chart::OFC2::Labels;


=head1 PROPERTIES

    subtype 'Chart-OFC2-YAxis'
        => as 'Object'
        => where { $_[0]->isa('Chart::OFC2::YAxis') };
    subtype 'Chart-OFC2-XAxis' 
        => as 'Object'
        => where { $_[0]->isa('Chart::OFC2::XAxis') };

    has 'name'        => ( is => 'rw', isa => enum(['x_axis', 'y_axis', 'y_axis_right']), required => 1 );
    has 'labels'      => ( is => 'rw', isa => 'Chart-OFC2-Labels', coerce  => 1);
    has 'stroke'      => ( is => 'rw', isa => 'Int', );
    has 'colour'      => ( is => 'rw', isa => 'Str',  );
    has 'offset'      => ( is => 'rw', isa => 'Bool', );
    has 'grid_colour' => ( is => 'rw', isa => 'Str', );
    has '3d'          => ( is => 'rw', isa => 'Bool', );
    has 'steps'       => ( is => 'rw', isa => 'Int', );
    has 'visible'     => ( is => 'rw', isa => 'Bool',  );
    has 'min'         => ( is => 'rw', isa => 'Num|Str|Undef', );   # can be 'a' for auto too
    has 'max'         => ( is => 'rw', isa => 'Num|Str|Undef', );   # can be 'a' for auto too

=cut

subtype 'Chart-OFC2-YAxis'
    => as 'Object'
    => where { $_[0]->isa('Chart::OFC2::YAxis') };
subtype 'Chart-OFC2-XAxis' 
    => as 'Object'
    => where { $_[0]->isa('Chart::OFC2::XAxis') };

coerce 'Chart-OFC2-XAxis'
    => from 'HashRef'
    => via { Chart::OFC2::XAxis->new($_) };
coerce 'Chart-OFC2-YAxis'
    => from 'HashRef'
    => via { Chart::OFC2::YAxis->new($_) };

has 'name'        => ( is => 'rw', isa => enum(['x_axis', 'y_axis', 'y_axis_right']), required => 1 );
has 'labels'      => ( is => 'rw', isa => 'Chart-OFC2-Labels', coerce  => 1);
has 'stroke'      => ( is => 'rw', isa => 'Int', );
has 'colour'      => ( is => 'rw', isa => 'Str',  );
has 'offset'      => ( is => 'rw', isa => 'Bool', );
has 'grid_colour' => ( is => 'rw', isa => 'Str', );
has '3d'          => ( is => 'rw', isa => 'Bool', );
has 'steps'       => ( is => 'rw', isa => 'Chart-OFC2-NaturalInt', );
has 'visible'     => ( is => 'rw', isa => 'Bool',  );
has 'min'         => ( is => 'rw', isa => 'Num|Str|Undef', );   # can be 'a' for auto too
has 'max'         => ( is => 'rw', isa => 'Num|Str|Undef', );   # can be 'a' for auto too

=head1 METHODS

=head2 TO_JSON()

Returns HashRef that is possible to give to C<encode_json()> function.

=cut

sub TO_JSON {
    my ($self) = @_;
    
    return {
        map  { my $v = $self->$_; (defined $v ? ($_ => $v) : ()) }
        grep { $_ ne 'name' }
        map  { $_->name } $self->meta->compute_all_applicable_attributes
    };
}

1;


=head1 Chart::OFC2::XAxis

X axis object.

    extends 'Chart::OFC2::Axis';

=cut

package Chart::OFC2::XAxis;
use Moose;

extends 'Chart::OFC2::Axis';

=head1 PROPERTIES

    has '+name'       => ( default => 'x_axis', );
    has 'tick_height' => ( is => 'rw', isa => 'Int', );

=cut

has '+name'       => ( default => 'x_axis', );
has 'tick_height' => ( is => 'rw', isa => 'Int', );

1;


=head1 Chart::OFC2::YAxis

y axis object.

    extends 'Chart::OFC2::Axis';

=cut

package Chart::OFC2::YAxis;
use Moose;

extends 'Chart::OFC2::Axis';

=head1 PROPERTIES

    has '+name'        => ( default => 'y_axis' );
    has 'tick_length' => ( is => 'rw', isa => 'Int', );

=cut

has '+name'        => ( default => 'y_axis' );
has 'tick_length' => ( is => 'rw', isa => 'Int', );

1;


=head1 Chart::OFC2::YAxisRight

y axis on the right side object.

    extends 'Chart::OFC2::YAxis';

=cut

package Chart::OFC2::YAxisRight;

use Moose;

extends 'Chart::OFC2::YAxis';

=head1 PROPERTIES

    has '+name' => ( default => 'y_axis_right' );

=cut

has '+name' => ( default => 'y_axis_right' );

1;


__END__

=head1 AUTHOR

Jozef Kutej

=cut
