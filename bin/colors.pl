use Color::Scheme;
use List::Util qw(shuffle);
my $scheme = Color::Scheme->new
->scheme('tetrade') 
->distance(1)
->variation('light');
for (0 .. 5) {
  $scheme->from_hue($_ * 15);
  @colors = map { '#' . uc( ($scheme->colors)[$_] ) . 'FF' } qw(0 4 8 12 3 7 11 15 1 5 9 13 2 6 10 14);
  print join(' ', @colors), "\n";
}
