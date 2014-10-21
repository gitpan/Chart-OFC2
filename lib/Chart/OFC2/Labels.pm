package Chart::OFC2::Labels;

=head1 NAME

Chart::OFC2::Labels - OFC2 labels object

=head1 SYNOPSIS

    use Chart::OFC2::Labels;
    
    'x_axis' => Chart::OFC2::XAxis->new(
        'labels' => [ 'Jan', 'Feb', 'Mar', 'Apr', 'May', 'Jun' ],
    ),

    'x_axis' => Chart::OFC2::XAxis->new(
        'labels' => Chart::OFC2::Labels->new(
            'labels' => [ 'Jan', 'Feb', 'Mar', 'Apr', 'May', 'Jun' ],
            'colour' => '#555555'
        ),
    ),

=head1 DESCRIPTION

=cut

use Moose;
use Moose::Util::TypeConstraints;
use MooseX::StrictConstructor;

our $VERSION = '0.05';

coerce 'Chart::OFC2::Labels'
    => from 'ArrayRef'
    => via { Chart::OFC2::Labels->new('labels' => $_) };

=head1 PROPERTIES

    has 'labels' => ( is => 'rw', isa => 'ArrayRef', );
    has 'colour' => ( is => 'rw', isa => 'Str',  );

=cut

has 'labels' => ( is => 'rw', isa => 'ArrayRef', );
has 'colour' => ( is => 'rw', isa => 'Str',  );


=head1 METHODS

=head2 new()

Object constructor.

=head2 TO_JSON()

Returns HashRef that is possible to give to C<encode_json()> function.

=cut

sub TO_JSON {
    my ($self) = @_;
    
    if (defined $self->colour) {
        return {
            map  { my $v = $self->$_; (defined $v ? ($_ => $v) : ()) }
            map  { $_->name } $self->meta->get_all_attributes
        };
    }
    else {
        return [ @{$self->labels} ];
    }
}

1;


__END__

=head1 AUTHOR

Jozef Kutej

=cut
