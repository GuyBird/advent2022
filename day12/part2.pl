use v5.10;
use strict;
use warnings;

my @map;
my @visited;
my @path;

while (<>) {
    chomp;
    my @line = split //, $_;
    push @map, \@line;
    push @visited, [(0) x scalar @line];
    push @path, [(999) x scalar @line];
}

my @stack;
my $found = 0;
foreach my $y (0 .. (scalar @map - 1)) {
    last if $found;
    foreach my $x (0 .. scalar @{$map[$y]} - 1) {
        if ($map[$y]->[$x] eq "S") {
            $visited[$y]->[$x] = 0;
            $path[$y]->[$x] = 0;
            $map[$y]->[$x] = "a";
            $found = 1;
            push @stack, [$y, $x];
            last;
        }
    }
}

my $width = scalar @{$map[0]};
my $length = scalar @map;
$found = 0;
while (!$found) {
    my $coords = getNextNode();

    next if ($visited[$coords->[0]]->[$coords->[1]]);

    if ($coords->[1] < ($width - 1) and !($visited[$coords->[0]]->[$coords->[1] + 1])) {
        checkNode($coords->[1], $coords->[0], $coords->[1] + 1, $coords->[0]);
    }
    if ($coords->[1] > 0 and !($visited[$coords->[0]]->[$coords->[1] - 1])) {
        checkNode($coords->[1], $coords->[0], $coords->[1] - 1, $coords->[0]);     
    }
    if ($coords->[0] < ($length - 1) and !($visited[$coords->[0] + 1]->[$coords->[1]])) {
        checkNode($coords->[1], $coords->[0], $coords->[1], $coords->[0] + 1);       
    }
    if ($coords->[0] > 0 and !($visited[$coords->[0] - 1]->[$coords->[1]])) {
        checkNode($coords->[1], $coords->[0], $coords->[1], $coords->[0] - 1);
    }

    $visited[$coords->[0]]->[$coords->[1]] = $map[$coords->[0]]->[$coords->[1]];
}

say $found;

sub getNextNode {
    my $lowest_path = 999;
    my $lowest_index = 999;
    foreach my $c (0 .. scalar @stack - 1) {
        my $x = $stack[$c]->[1];
        my $y = $stack[$c]->[0];
        if ($path[$y]->[$x] < $lowest_path) {
            $lowest_path = $path[$y]->[$x];
            $lowest_index = $c;
        }

    }
    return splice(@stack, $lowest_index, 1);
}

sub checkNode {
    my ($x,$y,$nx,$ny) = @_;

    if ($map[$ny]->[$nx] eq "E") {
        return unless ($map[$y]->[$x] eq "z" or $map[$y]->[$x] eq "y");
        $found = $path[$y]->[$x] + 1;
    }

    if (ord($map[$y]->[$x]) >= (ord($map[$ny]->[$nx]) - 1)) {
        if ($path[$ny]->[$nx] > $path[$y]->[$x] + 1) {
            $path[$ny]->[$nx] = $path[$y]->[$x] + 1;
        }
        $path[$ny]->[$nx] = 0 if  $map[$ny]->[$nx] eq "a";
        push @stack, [$ny, $nx];
    }        
}

sub printMap {
    my ($map) = @_;
    foreach my $row (@{$map}) {
        foreach my $x (@{$row}) {
            print "$x";
        }
        print "\n";
    }
    print "\n";
}