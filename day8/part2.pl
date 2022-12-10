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
    for my $x ( 0 .. ($width - 1)) {
        my $e_score = 0;
        for ( $x + 1 .. ($width - 1)) { 
            $e_score++;
            last unless ($tree_map[$y]->[$x] > $tree_map[$y]->[$_] );
        }
        $e_map[$y]->[$x] = $e_score;

        my $w_score = 0;
        for ( $x + 1 .. ($width - 1)) { 
            $w_score++;
            last unless ($tree_map[$y]->[($width - 1) -$x] > $tree_map[$y]->[($width - 1) - $_] );
        }
        $w_map[$y]->[($width - 1) -$x] = $w_score;
    }
}

for my $x ( 0 .. ($width - 1)) {
    for my $y ( 0 .. ($height - 1)) {
        my $s_score = 0;
        for ( $y + 1 .. ($height - 1)) { 
            $s_score++;
            last unless ($tree_map[$y]->[$x] > $tree_map[$_]->[$x] );
        }
        $s_map[$y]->[$x] = $s_score;

        my $n_score = 0;
        for ( $y + 1 .. ($height - 1)) { 
            $n_score++;
            last unless ($tree_map[($height - 1) -$y]->[$x] > $tree_map[($height - 1) -$_]->[$x] );
        }
        $n_map[($height - 1) -$y]->[$x] = $n_score;
    }
}


my $score = 0;
for my $y ( 0 .. ($height - 1)) {
    for my $x ( 0 .. ($width - 1)) {
        my $cur_score =  $n_map[$y]->[$x] * 
            $s_map[$y]->[$x] *
            $e_map[$y]->[$x] *
            $w_map[$y]->[$x];
        $score = $cur_score if ($cur_score > $score);
    }
}

say $score;