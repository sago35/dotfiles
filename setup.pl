#!/usr/bin/env perl
use strict;
use warnings;
use utf8;
use File::Spec;

if (0 == scalar @ARGV) {
    printf "usage: $0 install\n";
    exit 1;
}

my $setting = {
    'tmux/conf' => "$ENV{HOME}/.tmux.conf",
    'vim/vimrc' => "$ENV{HOME}/.vimrc",
};

if ($ARGV[0] eq "install") {
    foreach my $key (keys %{$setting}) {
        ln($key, $setting->{$key});
    }
}

sub ln {
    my ($src, $dst) = @_;
    $src = File::Spec->rel2abs($src);
    $dst = File::Spec->rel2abs($dst);

    printf "%s\n", join ' ', 'ln', '-s', $src, $dst;
    symlink $src, $dst;
}
