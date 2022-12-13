use v5.10;
use strict;
use warnings;

my @numbers;
while (<>) {
    chomp;
    next if ($_ eq "");
    push @numbers, parseInput(substr($_, 1, -1));
}

my $score = 0;
foreach my $left ( 0 .. scalar @numbers - 1) {
    next if ($left % 2);

    my $correct_order = sortPairs($numbers[$left],$numbers[$left + 1]);
    $score += ($left / 2) + 1 if ($correct_order);
}

say $score;

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
            return $result if ($result != 2);
        }
        return 1 if scalar @{$a} < scalar @{$b};
        return 0 if scalar @{$a} > scalar @{$b};

    } elsif ($a =~ /^\d+$/ and $b =~ /^\d+$/) {
        return 1 if $a < $b;
        return 0 if $a > $b;

    } else {
        return sortPairs($a, [$b]) if (ref($a) eq 'ARRAY');
        return sortPairs([$a], $b) if (ref($b) eq 'ARRAY');
    }
    
    return 2;
}