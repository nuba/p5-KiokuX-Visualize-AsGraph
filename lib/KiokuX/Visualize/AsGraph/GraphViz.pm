package KiokuX::Visualize::AsGraph::GraphViz;

use Moose;

use Set::Object;
use GraphViz;

use namespace::clean -except => 'meta';

has graphviz => (
  is      => 'rw',
  isa     => 'GraphViz',
  default => sub {
    GraphViz->new(
      node => { 
        fontsize => 7,
      },
      edge => { 
        fontsize => 7,
      },
      layout => 'dot',
      overlap => 'false',
    )
  },
);

has _colors => (
  is         => 'ro',
  isa        => 'HashRef',
  required   => 1,
  default    => sub { {} },
);

has _color_pool => (
  is   => 'ro',
  isa     => 'ArrayRef[Str]',
  default => sub {
    use List::Util 'shuffle';
    no warnings;
    [ # handpicked selection of pastel tones, tetrade form on the color wheel
      shuffle qw(
        #0EFF68 #1EEB6B #0BE35B #48FF8C #76FFA9 #4D2DFF #5438EB #3F22E3 #785FFF #9A87FF
        #FFCE0E #EBC11E #E3B70B #FFDA48 #FFE376 #FF380E #EB421E #E3300B #FF6848 #FF8E76
        #19BAFF #28B0EB #13A4E3 #50CAFF #7CD8FF #9D1EFF #982CEB #8A16E3 #B554FF #C77FFF
        #FFF70E #EBE41E #E3DC0B #FFF948 #FFFB76 #FF8D0E #EB8B1E #E37D0B #FFA948 #FFBE76
        #604AFF #6658CC #3320B8 #8C7CFF #AFA4FF #FF2F86 #CC477F #B81459 #FF68A7 #FF96C2
        #A4FF2F #92CC47 #70B814 #BDFF68 #D1FF96 #FFD22F #CCB047 #B89514 #FFDF68 #FFE996
        )
    ];
  },
);

sub color {
  my $self = shift;
  my $what = shift;
  if (!exists $self->_colors->{$what}) {
    my $color = shift(@{ $self->_color_pool });
    push(@{ $self->_color_pool }, $color);
    $self->_colors->{$what} = $color;
  }
  return $self->_colors->{$what};
}

__PACKAGE__->meta->make_immutable;

__PACKAGE__

__END__
