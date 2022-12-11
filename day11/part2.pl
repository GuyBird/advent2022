use v5.10;
use strict;
use warnings;

my @monkeys;
my $current_monkey = 0;
my $common_multiple = 1;
while (<>) {
    chomp;
    if ($_ =~ /Monkey (\d+):/) {
        $current_monkey = $1;
        push @monkeys, {monkey_business => 0};
    }

    if ($_ =~ /Starting items: ([0-9, ]+)/) {
        my @starting_items = split /, /, $1;
        $monkeys[$current_monkey]->{items} = \@starting_items;
    }

    if ($_ =~ /Operation: new = old (.) ([\dold]+)/) {
        my $operation = $1;
        my $val = $2;
        $monkeys[$current_monkey]->{operation} = sub {
            my $old = shift;
            return abs(eval($old . $operation . $old)) if ($val eq "old");
            return abs(eval($old . $operation . $val));
        }
    }

    if ($_ =~ /Test: divisible by (\d+)/) {
        my $divisor = $1;
        $common_multiple *= $divisor;
        $monkeys[$current_monkey]->{test} = sub {
            my $val = shift;
            return !($val % $divisor);
        }
    }

    if ($_ =~ /If true: throw to monkey (\d+)/) {
        $monkeys[$current_monkey]->{pass} = $1;
    }

    if ($_ =~ /If false: throw to monkey (\d+)/) {
        $monkeys[$current_monkey]->{fail} = $1;
    }
}

my $rounds = 10000 ;
for (1 .. $rounds) {
    foreach my $monkey (@monkeys) {
        foreach (1 .. scalar @{$monkey->{items}}) {
            $monkey->{monkey_business}++;

            my $worry_level = pop @{$monkey->{items}};
            $worry_level = $monkey->{operation}->($worry_level);
            $worry_level = $worry_level % $common_multiple;
            $worry_level = $common_multiple if (!$worry_level);

            if ($monkey->{test}->($worry_level)) {
                push @{$monkeys[$monkey->{pass}]->{items}}, $worry_level;
            } else {
                push @{$monkeys[$monkey->{fail}]->{items}}, $worry_level;
            }
        }
    }
}


my ($x, $y) = (0, 0);
foreach my $monkey (@monkeys) {
    if ($monkey->{monkey_business} > $x) {
        $y = $x;
        $x = $monkey->{monkey_business};
    } elsif ($monkey->{monkey_business} > $y) {
        $y = $monkey->{monkey_business};
    }
}
say $x * $y;