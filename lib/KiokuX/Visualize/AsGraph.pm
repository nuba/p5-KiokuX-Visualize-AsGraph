package KiokuX::Visualize::AsGraph;
use Moose;

use namespace::clean -except => 'meta';

with 'KiokuDB::Role::Scan' => { result_class => "KiokuX::Visualize::AsGraph::GraphViz" };

sub process_block {
  my ( $self, %args ) = @_;
  my $backend = $self->backend;

  my ( $block, $res ) = @args{qw(block results)};
  my ( $graphviz ) = map { $res->$_ } qw(graphviz );

  foreach my $entry ( @{ $block } ) {

    if ($entry->class =~ m/^KiokuDB::/) {

      my @referenced = $entry->referenced_ids;
      next unless (scalar @referenced > 0);

      my $label = $entry->class;
      $label =~ s/KiokuDB::/KiokuDB::\\n/;
      $graphviz->add_node(
        name      => $entry->id,
        label     => $label,
        shape     => 'diamond',
        fontsize  => '6',
        style     => 'filled,rounded',
        fillcolor => '#DDDDDDFF',
      );

      foreach my $children_id (@referenced) {
        $graphviz->add_edge(
          $entry->id => $children_id,
          weight => 5,
        );
      }

    } else {
      my $port = 0;

      my $label = '<<table border="0" cellborder="0" cellspacing="2"><tr><td colspan="2"><font point-size="10">' . $entry->class .'</font></td></tr>';
      my %data = %{ $entry->data };
      foreach my $key (sort { ref($data{$a}) cmp ref($data{$b}) } keys %data) {
        my $value = $data{$key};
        if (ref($value) eq 'KiokuDB::Reference') {

          my ( $reference_entry ) = $backend->get($value->id);
          my @referenced_ids = $reference_entry->referenced_ids;
          next unless (scalar @referenced_ids > 0);

          $label .= '<tr><td bgcolor="#FFFFFFAA"><font point-size="6">' . $key . '</font></td><td bgcolor="#FFFFFF55" port="port' . $port .'"></td></tr>';

          $graphviz->add_edge(
            $entry->id => $value->id,
            label      => $key,
            from_port  => $port,
          );

          $port++;

        #} elsif (ref($value) eq SOME RANDOM STUFF { 
        #  use a recursive flattening method for everything else
        } else {
          $key =~ s/[{|}]/\\$1/g;
          $value =~ s/[{|}]/\\$1/g;

          $label .= '<tr><td bgcolor="#FFFFFFAA"><font point-size="6">' . $key . '</font></td><td bgcolor="#FFFFFFEE">' . $value . '</td></tr>';
        }
      }
      $label .=  '</table>>';
      $graphviz->add_node(
        name      => $entry->id,
        label     => $label,
        shape     => 'plaintext',
        style     => 'rounded,filled',
        fillcolor => $res->color($entry->class),
      );
    }
  }
}

__PACKAGE__->meta->make_immutable;

__PACKAGE__
