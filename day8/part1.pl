use v5.10;
use strict;
use warnings;

my @tree_map;
while (<>) {
    chomp;
    my @line = split //, $_;
    push @tree_map, \@line;
}

my $width = scalar @{$tree_map[0]};
my $height = scalar @tree_map;

my @n_map;
my @s_map;
my @e_map;
my @w_map;
for (1 .. $height) {
    push @n_map, [(0) x $width]; 
    push @s_map, [(0) x $width]; 
    push @e_map, [(0) x $width]; 
    push @w_map, [(0) x $width]; 
}

for my $y ( 0 .. ($height - 1)) {
    my $max_e = -1;
    my $max_w = -1;
    for my $x ( 0 .. ($width - 1)) {
        if ($tree_map[$y]->[$x] > $max_e) {
            $max_e = $tree_map[$y]->[$x];
            $e_map[$y]->[$x] = 1;
        }

        if ($tree_map[$y]->[($width - 1) -$x] > $max_w) {
            $max_w = $tree_map[$y]->[($width - 1) -$x];
            $w_map[$y]->[($width - 1) -$x] = 1;
        }
    }
}

for my $x ( 0 .. ($width - 1)) {
    my $max_n = -1;
    my $max_s = -1;
    for my $y ( 0 .. ($height - 1)) {
        if ($tree_map[$y]->[$x] > $max_n) {
            $max_n = $tree_map[$y]->[$x];
            $n_map[$y]->[$x] = 1;
        }

        if ($tree_map[($height - 1) -$y]->[$x] > $max_s) {
            $max_s = $tree_map[($height - 1) -$y]->[$x];
            $s_map[($height - 1) -$y]->[$x] = 1;
        }
    }
}

my $score;
for my $y ( 0 .. ($height - 1)) {
    for my $x ( 0 .. ($width - 1)) {
        if ($n_map[$y]->[$x] or 
            $s_map[$y]->[$x] or
            $e_map[$y]->[$x] or
            $w_map[$y]->[$x]) {
            $score++;
        }
    }
}
say $score;
