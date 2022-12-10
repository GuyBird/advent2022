use v5.10;
use strict;
use warnings;
use Tree::Simple;

my @input = <>;
map {chomp} @input;

my $filesystem = Tree::Simple->new("root");
my $curr_dir =  $filesystem;

foreach (@input) {
    if ($_ =~ /^\$ \w{2} (\S+)/) {
        my $name = $1;

        if ($name eq "..") {
            $curr_dir = $curr_dir->getParent();
        } else {
            my $changed = 0;
            for my $child (@{$curr_dir->getAllChildren()}) {
                if ($child->getNodeValue()->{name} eq $name) {
                    $changed = 1;
                    $curr_dir = $child;
                }
            }
            unless ($changed) {
                my $dir = Tree::Simple->new({name => $name, size => 0,});
                $curr_dir->addChild($dir);
                $curr_dir = $dir;
            }
        }
    } elsif ($_ =~ /([dir0-9]+) (\S+)/){
        my $size = $1;
        $size = 0 if ($size eq "dir");
        $curr_dir->addChild(Tree::Simple->new({name => $2, size => $size,}));
    }
}

getSizes($filesystem->getChild(0));
getScore($filesystem);

sub getSizes {
    my ($node) = @_;
    return $node->getNodeValue()->{size} if ($node->getChildCount() == 0);
    
    my $size = 0;
    map {$size += getSizes($_)} (@{$node->getAllChildren()});
    $node->setNodeValue({name => $node->getNodeValue()->{name}, size => $size,});

    return $size;
}

sub getScore {
    my ($root) = @_;
    my $score = 70000000;
    my $needed_space = 30000000 - ($score - $root->getChild(0)->getNodeValue()->{size});

    $root->traverse (
        sub {
            my $node = shift;
            if ($node->getChildCount() != 0 and $node->getNodeValue()->{size} >= $needed_space and $node->getNodeValue()->{size} < $score) {
                $score = $node->getNodeValue()->{size};
            }
        }
    );
    say $score;
}

sub printFileSystem {
    my ($root) = @_;
    $root->traverse (
        sub {
            my $node = shift;
            say (('. ' x $node->getDepth()) . $node->getNodeValue()->{name} . ' , size=' . $node->getNodeValue()->{size});
        }
    );
}