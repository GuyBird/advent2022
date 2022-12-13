use v5.10;
use strict;
use warnings;

my @numbers;
while (<>) {
    chomp;
    next if ($_ eq "");
    push @numbers, parseInput(substr($_, 1, -1));
}

push @numbers, parseInput("[2]");
push @numbers, parseInput("[6]");

my @sorted = sort {sortPairs($b,$a)} @numbers;

my ($x, $y, $i) = (0, 0, 1);
foreach (@sorted) {
    $x = $i if (defined $_->[0] and !defined $_->[1] and ref($_->[0]) eq 'ARRAY' and defined $_->[0]->[0] and !defined $_->[0]->[1] and $_->[0]->[0] == 2);
    $y = $i if (defined $_->[0] and !defined $_->[1] and ref($_->[0]) eq 'ARRAY' and defined $_->[0]->[0] and !defined $_->[0]->[1] and $_->[0]->[0] == 6);
    $i++;
}
say $x * $y;

sub parseInput {
    my ($input) = @_;
    my @parsed;

    while(length $input) {
        if ($input =~ /^,/) { 
            $input = substr $input, 1;
        }elsif ($input =~ /^(\d+)/) {
            push @parsed, $1;
            $input = substr $input, (length $1);
        }
        else {
            my @substring = split //, $input;
            my $depth = 0;
            my $i = 0;
            do {
                my $char = shift @substring;
                $i++;
                $depth+= 1 if ($char eq "[");
                $depth-= 1 if ($char eq "]");
            } while ($depth);

            push @parsed, parseInput(substr($input, 1 , ($i - 2)));
            $input = substr $input, $i;
        }
    }
    return \@parsed;
}

sub sortPairs {
    my ($a, $b) = @_;

    if (ref($a) eq 'ARRAY' and ref($b) eq 'ARRAY') {
        for (my $i = 0; $i < scalar @{$a} && $i < scalar @{$b}; $i++) {
            my $result = sortPairs($a->[$i], $b->[$i]);
            return $result if ($result != 0);
        }
        return 1 if scalar @{$a} < scalar @{$b};
        return -1 if scalar @{$a} > scalar @{$b};

    } elsif ($a =~ /^\d+$/ and $b =~ /^\d+$/) {
        return 1 if $a < $b;
        return -1 if $a > $b;

    } else {
        return sortPairs($a, [$b]) if (ref($a) eq 'ARRAY');
        return sortPairs([$a], $b) if (ref($b) eq 'ARRAY');
    }

    return 0;
}